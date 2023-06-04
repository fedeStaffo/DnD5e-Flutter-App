import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../memory/character_card.dart';

class HomeCharacter extends StatelessWidget {
  final String userId;

  HomeCharacter({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I Miei Personaggi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('personaggi')
            .where('utenteId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Si è verificato un errore.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nessun personaggio trovato.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final personaggio = snapshot.data!.docs[index];

              return CharacterCard(
                nome: personaggio['nome'],
                classe: personaggio['classe'],
                razza: personaggio['razza'],
              );
            },
          );
        },
      ),
    );
  }
}