import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SessioneDettagli extends StatelessWidget {
  final String numero;
  final String campagna;

  SessioneDettagli({required this.numero, required this.campagna});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dettagli Sessione',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sessioni')
            .where('campagna', isEqualTo: campagna)
            .where('numero', isEqualTo: numero)
            .snapshots(),
        builder: (context, snapshot) {
          // Controllo degli errori
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Si è verificato un errore durante il recupero dei dettagli della sessione.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          // Controllo dello stato di connessione
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final sessioniList = snapshot.data!.docs;

          // Controllo se la sessione è stata trovata
          if (sessioniList.isEmpty) {
            return const Center(
              child: Text(
                'Sessione non trovata.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final sessioneData = sessioniList[0].data() as Map<String, dynamic>;
          final descrizione = sessioneData['descrizione'];
          final giorno = sessioneData['giorno'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sessione: $numero',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Giorno: $giorno',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Descrizione: $descrizione',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
