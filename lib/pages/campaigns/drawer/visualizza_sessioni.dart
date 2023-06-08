import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dettagli_sessione.dart';

class VisualizzaSessioni extends StatefulWidget {
  final String? campagna;

  VisualizzaSessioni({required this.campagna});

  @override
  _VisualizzaSessioniState createState() => _VisualizzaSessioniState();
}

class _VisualizzaSessioniState extends State<VisualizzaSessioni> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visualizza Sessioni',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sessioni')
            .where('campagna', isEqualTo: widget.campagna)
            .snapshots(),
        builder: (context, snapshot) {
          // Gestisce gli errori durante il recupero delle sessioni
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Si è verificato un errore durante il recupero delle sessioni.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          // Mostra uno spinner di caricamento mentre si attende la connessione al database
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final sessioniList = snapshot.data!.docs;

          // Mostra un messaggio se non ci sono sessioni nella campagna
          if (sessioniList.isEmpty) {
            return const Center(
              child: Text(
                'Nessuna sessione presente in questa campagna.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final User? currentUser = _auth.currentUser;

          // Costruisce una ListView per visualizzare le sessioni
          return ListView.builder(
            itemCount: sessioniList.length,
            itemBuilder: (context, index) {
              final sessioneData = sessioniList[index].data() as Map<String, dynamic>;
              final numero = sessioneData['numero'];
              final giorno = sessioneData['giorno'];

              final isMaster = currentUser != null &&
                  sessioneData['master'] == currentUser.uid &&
                  sessioneData['campagna'] == widget.campagna;

              return Card(
                child: ListTile(
                  title: Text(
                    'Sessione: $numero',
                    style: const TextStyle(fontSize: 26),
                  ),
                  subtitle: Text(
                    'Giorno: $giorno',
                    style: const TextStyle(fontSize: 24),
                  ),
                  onTap: () {
                    // Naviga alla schermata di dettaglio sessione passando i dati necessari
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessioneDettagli(
                          numero: numero,
                          campagna: widget.campagna!,
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Elimina la sessione se l'utente corrente è il master della campagna
                    if (isMaster) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Elimina Sessione'),
                          content: const Text('Sei sicuro di voler eliminare questa sessione?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Annulla'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Effettua l'eliminazione della sessione
                                FirebaseFirestore.instance
                                    .collection('sessioni')
                                    .doc(sessioniList[index].id)
                                    .delete();
                                Navigator.pop(context);
                              },
                              child: const Text('Elimina'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
