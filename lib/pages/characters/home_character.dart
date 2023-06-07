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
        title: const Text('I Miei Personaggi'), // Titolo dell'appbar
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('personaggi')
            .where('utenteId', isEqualTo: userId)
            .snapshots(), // Stream che ascolta le modifiche alla collezione 'personaggi' filtrata per l'utente corrente
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Si è verificato un errore.'), // Messaggio di errore se si verifica un errore nello stream
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Indicatore di caricamento se lo stream è in attesa
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nessun personaggio trovato.'), // Messaggio se non ci sono dati o se la collezione è vuota
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length, // Numero di elementi nella collezione
            itemBuilder: (context, index) {
              final personaggio = snapshot.data!.docs[index]; // Ottiene il documento del personaggio corrente

              return CharacterCard(
                nome: personaggio['nome'], // Passa il nome del personaggio al widget CharacterCard
                classe: personaggio['classe'], // Passa la classe del personaggio al widget CharacterCard
                razza: personaggio['razza'], // Passa la razza del personaggio al widget CharacterCard
                utenteId: userId, // Passa l'ID dell'utente al widget CharacterCard
              );
            },
          );
        },
      ),
    );
  }
}
