import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EliminaGiocatori extends StatefulWidget {
  final String? campagnaNome;

  EliminaGiocatori({required this.campagnaNome});

  @override
  _EliminaGiocatoriState createState() => _EliminaGiocatoriState();
}

class _EliminaGiocatoriState extends State<EliminaGiocatori> {
  String? selectedGiocatore;
  List<String> giocatori = [];

  @override
  void initState() {
    super.initState();
    _fetchGiocatori();
  }

  void _fetchGiocatori() {
    FirebaseFirestore.instance
        .collection('campagne')
        .where('nome', isEqualTo: widget.campagnaNome)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {
        final document = querySnapshot.docs[0];
        List<dynamic> personaggi = document['personaggi'];
        setState(() {
          giocatori = personaggi.cast<String>();
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  void _eliminaGiocatore() {
    FirebaseFirestore.instance
        .collection('campagne')
        .where('nome', isEqualTo: widget.campagnaNome)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {
        final document = querySnapshot.docs[0];
        List<dynamic> partecipanti = List.from(document['partecipanti']);
        List<dynamic> personaggi = List.from(document['personaggi']);

        String giocatoreId = '';

        for (var i = 0; i < personaggi.length; i++) {
          if (personaggi[i] == selectedGiocatore) {
            giocatoreId = partecipanti[i];
            break;
          }
        }

        partecipanti.remove(giocatoreId);
        personaggi.remove(selectedGiocatore);

        document.reference.update({
          'partecipanti': partecipanti,
          'personaggi': personaggi,
        }).then((_) {
          // Setta a nullo il campo "campagna" del personaggio
          FirebaseFirestore.instance
              .collection('personaggi')
              .where('nome', isEqualTo: selectedGiocatore)
              .get()
              .then((querySnapshot) {
            if (querySnapshot.size == 1) {
              final document = querySnapshot.docs[0];
              document.reference.update({'campagna': ''}).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Giocatore eliminato con successo!'),
                ));
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Si è verificato un errore durante l\'eliminazione del giocatore.'),
                ));
              });
            }
          }).catchError((error) {
            print('Si è verificato un errore durante la query: $error');
          });
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Si è verificato un errore durante l\'eliminazione del giocatore.'),
          ));
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elimina Giocatori'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seleziona il giocatore da eliminare dalla campagna',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedGiocatore,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGiocatore = newValue;
                });
              },
              items: giocatori.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Giocatore',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _eliminaGiocatore,
              child: const Text(
                'Elimina',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
