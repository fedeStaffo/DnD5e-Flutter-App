import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dettagli_npc.dart';

class VisualizzaNpc extends StatefulWidget {
  final String? campagna;

  VisualizzaNpc({required this.campagna});

  @override
  _VisualizzaNpcState createState() => _VisualizzaNpcState();
}

class _VisualizzaNpcState extends State<VisualizzaNpc> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          // Gestisce gli errori durante il recupero degli NPC
          if (snapshot.hasError) {
            return const Center(
              child: Text('Si è verificato un errore durante il recupero degli NPC.'),
            );
          }

          // Mostra uno spinner di caricamento mentre si attende la connessione al database
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final npcList = snapshot.data!.docs;

          // Mostra un messaggio se non ci sono NPC nella campagna
          if (npcList.isEmpty) {
            return const Center(
              child: Text('Nessun NPC presente in questa campagna.'),
            );
          }

          // Costruisce una ListView per visualizzare gli NPC
          return ListView.builder(
            itemCount: npcList.length,
            itemBuilder: (context, index) {
              final npcData = npcList[index].data() as Map<String, dynamic>;
              final nome = npcData['nome'];
              final legame = npcData['legame'];

              final User? currentUser = _auth.currentUser;

              // Verifica se l'utente corrente è il master della campagna
              final isMaster = currentUser != null &&
                  npcData['master'] == currentUser.uid &&
                  npcData['campagna'] == widget.campagna;

              return InkWell(
                onTap: () {
                  // Naviga alla schermata di dettaglio NPC passando i dati necessari
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
                onLongPress: () {
                  // Elimina l'NPC se l'utente corrente è il master della campagna
                  if (isMaster) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Elimina NPC'),
                        content: const Text('Sei sicuro di voler eliminare questo NPC?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Annulla'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Esegui l'eliminazione dell'NPC
                              FirebaseFirestore.instance.collection('npc').doc(npcList[index].id).delete();
                              Navigator.pop(context);
                            },
                            child: const Text('Elimina'),
                          ),
                        ],
                      ),
                    );
                  }
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
