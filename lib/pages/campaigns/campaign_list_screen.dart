import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../../memory/campagna.dart';

class CampaignListScreen extends StatefulWidget {
  @override
  _CampaignListScreenState createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Campagna>> getCampagne() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final campagneQueryMaster = _firestore
        .collection('campagne')
        .where('masterId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) => _combineCampagneLists(snapshot.docs));

    final campagneQueryPlayer = _firestore
        .collection('campagne')
        .where('partecipanti', arrayContains: userId)
        .snapshots()
        .asyncMap((snapshot) => _combineCampagneLists(snapshot.docs));

    return Rx.combineLatest2<List<Campagna>, List<Campagna>, List<Campagna>>(
      campagneQueryMaster,
      campagneQueryPlayer,
          (campagneMaster, campagnePlayer) {
        return [...campagneMaster, ...campagnePlayer];
      },
    );
  }

  List<Campagna> _combineCampagneLists(List<QueryDocumentSnapshot> campagneDocs) {
    return campagneDocs.map((doc) => Campagna.fromSnapshot(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le Mie Campagne'),
      ),
      body: StreamBuilder<List<Campagna>>(
        stream: getCampagne(),
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

          final campagne = snapshot.data;

          if (campagne == null || campagne.isEmpty) {
            return const Center(
              child: Text('Nessuna campagna trovata.'),
            );
          }

          return ListView.builder(
            itemCount: campagne.length,
            itemBuilder: (context, index) {
              final campagna = campagne[index];

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

class CampaignCard extends StatelessWidget {
  final String? nome;
  final String? masterId;
  final String? masterNome;

  CampaignCard({
    this.nome,
    this.masterId,
    this.masterNome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          nome ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Master: ${masterNome ?? ''}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
