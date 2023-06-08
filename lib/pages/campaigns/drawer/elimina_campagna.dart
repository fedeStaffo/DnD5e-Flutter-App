import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EliminaCampagna extends StatelessWidget {
  final String? campagnaNome;
  final String? masterId;

  EliminaCampagna({required this.campagnaNome, required this.masterId});

  // Funzione per eliminare gli NPC associati alla campagna
  void _eliminaNPC() {
    FirebaseFirestore.instance
        .collection('npc')
        .where('campagna', isEqualTo: campagnaNome)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print('Si è verificato un errore durante l\'eliminazione degli NPC: $error');
    });
  }

  // Funzione per eliminare le sessioni associate alla campagna
  void _eliminaSessioni() {
    FirebaseFirestore.instance
        .collection('sessioni')
        .where('campagna', isEqualTo: campagnaNome)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print('Si è verificato un errore durante l\'eliminazione delle sessioni: $error');
    });
  }

  // Funzione per aggiornare i personaggi associati alla campagna
  void _aggiornaPersonaggi() {
    FirebaseFirestore.instance
        .collection('personaggi')
        .where('campagna', isEqualTo: campagnaNome)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'campagna': null,
        });
      });
    }).catchError((error) {
      print('Si è verificato un errore durante l\'aggiornamento dei personaggi: $error');
    });
  }

  // Funzione per eliminare la campagna
  void _eliminaCampagna(BuildContext context) {
    FirebaseFirestore.instance
        .collection('campagne')
        .where('nome', isEqualTo: campagnaNome)
        .where('masterId', isEqualTo: masterId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {
        final document = querySnapshot.docs[0];
        document.reference.delete().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Campagna eliminata con successo!'),
          ));
          Navigator.pushNamedAndRemoveUntil(
              context, '/home_campaigns', (Route<dynamic> route) => false);
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Si è verificato un errore durante l\'eliminazione della campagna.'),
          ));
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  // Funzione per mostrare il dialog di conferma
  void _mostraDialogConferma(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Conferma Eliminazione'),
          content: const Text('Sei sicuro di voler eliminare la campagna?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Chiude il dialog
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Chiude il dialog
                _confermaEliminazione(context);
              },
              child: const Text('Conferma'),
            ),
          ],
        );
      },
    );
  }

  // Funzione per confermare l'eliminazione della campagna
  void _confermaEliminazione(BuildContext context) {
    _eliminaNPC();
    _eliminaSessioni();
    _aggiornaPersonaggi();
    _eliminaCampagna(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elimina Campagna'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Elimina la campagna e tutti i suoi dati',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nome Campagna: $campagnaNome',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _mostraDialogConferma(context),
                child: const Text(
                  'Elimina Campagna',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
