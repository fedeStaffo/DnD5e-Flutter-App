import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../memory/campaign.dart';
import '../../memory/campaign_card.dart';

// Schermata della lista delle campagne
class CampaignListScreen extends StatefulWidget {
  @override
  _CampaignListScreenState createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ottiene lo stream delle campagne
  Stream<List<Campagna>> getCampagne() {
    // Ottiene l'ID dell'utente corrente
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Query per ottenere le campagne in cui l'utente è il master
    final campagneQueryMaster = _firestore
        .collection('campagne')
        .where('masterId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) => _combineCampagneLists(snapshot.docs));

    // Query per ottenere le campagne in cui l'utente è un partecipante
    final campagneQueryPlayer = _firestore
        .collection('campagne')
        .where('partecipanti', arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) => _combineCampagneLists(snapshot.docs));

    // Combina i risultati delle due query in un'unica lista di campagne
    return Rx.combineLatest2<List<Campagna>, List<Campagna>, List<Campagna>>(
      campagneQueryMaster,
      campagneQueryPlayer,
          (campagneMaster, campagnePlayer) {
        return [...campagneMaster, ...campagnePlayer];
      },
    );
  }

  // Combina le liste di documenti di campagne in una lista di oggetti Campagna
  List<Campagna> _combineCampagneLists(List<QueryDocumentSnapshot> campagneDocs) {
    return campagneDocs.map((doc) => Campagna.fromSnapshot(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le Mie Campagne'), // Titolo dell'app
      ),
      body: StreamBuilder<List<Campagna>>(
        stream: getCampagne(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Gestione dell'errore
            return const Center(
              child: Text('Si è verificato un errore.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Visualizzazione di un indicatore di caricamento
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final campagne = snapshot.data;

          if (campagne == null || campagne.isEmpty) {
            // Messaggio se non ci sono campagne trovate
            return const Center(
              child: Text('Nessuna campagna trovata.'),
            );
          }

          // Costruzione della lista delle campagne
          return ListView.builder(
            itemCount: campagne.length,
            itemBuilder: (context, index) {
              final campagna = campagne[index];

              // Visualizzazione di una card per ogni campagna
              return CampaignCard(
                nome: campagna.nome,
                masterId: campagna.masterId,
                masterNome: campagna.masterNome,
              );
            },
          );
        },
      ),
    );
  }
}
