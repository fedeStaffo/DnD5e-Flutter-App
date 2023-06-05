import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/characters/visualizza_personaggio.dart';
import 'character.dart';

class CharacterCard extends StatelessWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CharacterCard({this.nome, this.classe, this.razza, this.utenteId});

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    String? userId = user?.uid;

    return Card(
      child: ListTile(
        title: Text(
          nome ?? '',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Classe: ${classe ?? ''}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Razza: ${razza ?? ''}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        onTap: () {
          if (utenteId == userId) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VisualizzaPersonaggio(
                  nome: this.nome,
                  classe: this.classe,
                  razza: this.razza,
                  utenteId: this.utenteId,
                ),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('personaggi')
                    .where('utenteId', isEqualTo: utenteId)
                    .where('nome', isEqualTo: nome)
                    .where('classe', isEqualTo: classe)
                    .where('razza', isEqualTo: razza)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError || snapshot.data!.docs.isEmpty) {
                    return AlertDialog(
                      title: Text(nome ?? ''),
                      content: const Text('Impossibile recuperare i dettagli del personaggio.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Chiudi'),
                        ),
                      ],
                    );
                  }

                  final personaggio = Personaggio.fromSnapshot(snapshot.data!.docs.first);

                  return AlertDialog(
                    title: Text(nome ?? ''),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nome: ${personaggio.nome ?? ''}'),
                        Text('Razza: ${personaggio.razza ?? ''}'),
                        Text('Classe: ${personaggio.classe ?? ''}'),
                        Text('Vita Massima: ${personaggio.vitaMax ?? ''}'),
                        Text('Vita Attuale: ${personaggio.vita ?? ''}'),
                        Text('Classe Armatura: ${personaggio.classeArmatura ?? ''}'),
                        Text('Forza: ${personaggio.forza ?? ''}'),
                        Text('Intelligenza: ${personaggio.intelligenza ?? ''}'),
                        Text('Costituzione: ${personaggio.costituzione ?? ''}'),
                        Text('Saggezza: ${personaggio.saggezza ?? ''}'),
                        Text('Carisma: ${personaggio.carisma ?? ''}'),
                        Text('Destrezza: ${personaggio.destrezza ?? ''}'),
                        Text('Allineamento: ${personaggio.allineamento ?? ''}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Chiudi'),
                      ),
                    ],
                  );
                },
              ),
            );

          }
        },
      ),
    );
  }
}
