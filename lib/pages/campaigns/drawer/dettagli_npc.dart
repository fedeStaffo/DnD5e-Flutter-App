import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NpcDettagli extends StatelessWidget {
  final String nome;
  final String campagna;

  NpcDettagli({required this.nome, required this.campagna});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dettagli NPC',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('npc')
            .where('campagna', isEqualTo: campagna)
            .where('nome', isEqualTo: nome)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Si è verificato un errore durante il recupero dei dettagli dell\'NPC.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final npcList = snapshot.data!.docs;

          if (npcList.isEmpty) {
            return const Center(
              child: Text(
                'NPC non trovato.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final npcData = npcList[0].data() as Map<String, dynamic>;
          final legame = npcData['legame'];
          final descrizione = npcData['descrizione'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome: $nome',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Legame: $legame',
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
