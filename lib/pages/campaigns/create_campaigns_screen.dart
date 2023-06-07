import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateCampaignScreen extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confermaPasswordController = TextEditingController();
  final TextEditingController _masterController = TextEditingController();

  final CollectionReference<Map<String, dynamic>> campagneRef =
  FirebaseFirestore.instance.collection('campagne');

  // Crea una nuova campagna
  void _creaCampagna(BuildContext context) {
    final String nome = _nomeController.text;
    final String password = _passwordController.text;
    final String confermaPassword = _confermaPasswordController.text;
    final String master = _masterController.text;

    // Verifica che tutti i campi siano compilati correttamente
    if (nome.isNotEmpty &&
        password.isNotEmpty &&
        confermaPassword.isNotEmpty &&
        password == confermaPassword) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final nuovoDocumento = campagneRef.doc();

        final campagna = {
          'nome': nome,
          'password': password,
          'masterNome': master,
          'masterId': currentUser.uid,
        };

        // Salva la campagna nel database
        nuovoDocumento
            .set(campagna)
            .then((_) {
          // Mostra una finestra di dialogo di successo
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Successo'),
                content: const Text('La campagna è stata creata.'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        })
            .catchError((error) {
          // Mostra una finestra di dialogo di errore
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Errore'),
                content: const Text('Si è verificato un errore durante la creazione della campagna.'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      }
    } else {
      // Mostra una finestra di dialogo se i campi non sono compilati correttamente
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Compila tutti i campi correttamente.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea Campagna'), // Titolo dell'app
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome Campagna',
              ),
            ),
            TextField(
              controller: _masterController,
              decoration: const InputDecoration(
                labelText: 'Nome Master',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _confermaPasswordController,
              decoration: const InputDecoration(
                labelText: 'Conferma Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _creaCampagna(context),
              child: const Text('Crea'),
            ),
          ],
        ),
      ),
    );
  }
}
