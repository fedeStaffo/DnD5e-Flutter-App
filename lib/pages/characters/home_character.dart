import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class CharacterCard extends StatelessWidget {
  final String? nome;
  final String? classe;
  final String? razza;

  CharacterCard({this.nome, this.classe, this.razza});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          nome ?? '',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Classe: ${classe ?? ''}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Razza: ${razza ?? ''}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

