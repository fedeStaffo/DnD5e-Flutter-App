import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignResetPassword extends StatefulWidget {
  final String? campagnaNome;
  final String? masterId;

  CampaignResetPassword({required this.campagnaNome, required this.masterId});

  @override
  _CampaignResetPasswordState createState() => _CampaignResetPasswordState();
}

class _CampaignResetPasswordState extends State<CampaignResetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _newPasswordErrorText;
  String? _confirmPasswordErrorText;

  String? passwordPrecedente;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchPasswordPrecedente();
  }

  void _fetchPasswordPrecedente() {
    FirebaseFirestore.instance
        .collection('campagne')
        .where('nome', isEqualTo: widget.campagnaNome)
        .where('masterId', isEqualTo: widget.masterId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {
        final document = querySnapshot.docs[0];
        setState(() {
          passwordPrecedente = document['password'];
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  void _resetPassword() {
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Verifica se le password corrispondono
    if (newPassword == confirmPassword) {
      // Esegui la query per ottenere il documento corrispondente
      FirebaseFirestore.instance
          .collection('campagne')
          .where('nome', isEqualTo: widget.campagnaNome)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.size == 1) {
          final document = querySnapshot.docs[0];
          // Aggiorna il campo password del documento trovato
          document.reference.update({'password': newPassword}).then((_) {
            // Aggiornamento avvenuto con successo
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Password aggiornata con successo!'),
            ));
          }).catchError((error) {
            // Si è verificato un errore durante l'aggiornamento
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Si è verificato un errore durante l\'aggiornamento della password.'),
            ));
          });
        }
      }).catchError((error) {
        print('Si è verificato un errore durante la query: $error');
      });
    } else {
      setState(() {
        _newPasswordErrorText = 'Le password non corrispondono';
        _confirmPasswordErrorText = 'Le password non corrispondono';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Password precedente: ${passwordPrecedente ?? 'N/A'}'),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nuova password',
                errorText: _newPasswordErrorText,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Conferma nuova password',
                errorText: _confirmPasswordErrorText,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Conferma'),
            ),
          ],
        ),
      ),
    );
  }
}
