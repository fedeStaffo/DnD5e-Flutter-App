import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dettagli_npc.dart';

class VisualizzaNpc extends StatefulWidget {
  final String? campagna;

  VisualizzaNpc({required this.campagna});

  @override
  _VisualizzaNpcState createState() => _VisualizzaNpcState();
}

class _VisualizzaNpcState extends State<VisualizzaNpc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizza NPC'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('npc')
            .where('campagna', isEqualTo: widget.campagna)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Si è verificato un errore durante il recupero degli NPC.'),
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
              child: Text('Nessun NPC presente in questa campagna.'),
            );
          }

          return ListView.builder(
            itemCount: npcList.length,
            itemBuilder: (context, index) {
              final npcData = npcList[index].data() as Map<String, dynamic>;
              final nome = npcData['nome'];
              final legame = npcData['legame'];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NpcDettagli(
                        nome: nome,
                        campagna: widget.campagna!,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(
                      nome,
                      style: const TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      legame,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
