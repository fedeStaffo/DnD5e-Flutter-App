import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profilo extends StatefulWidget {
  @override
  _ProfiloState createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _userId;
  String? _email;
  int _numPersonaggi = 0;
  String _razzaPreferita = '';
  String _classePreferita = '';
  int _numCampagnePartecipate = 0;

  @override
  void initState() {
    super.initState();
    _caricaInformazioniUtente();
  }

  Future<void> _caricaInformazioniUtente() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        _userId = user.uid;
        _email = user.email;
      });

      await _calcolaNumeroPersonaggi();
      await _calcolaRazzaPreferita();
      await _calcolaClassePreferita();
      await _calcolaNumeroCampagnePartecipate();
    }
  }

  Future<void> _calcolaNumeroPersonaggi() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('personaggi')
        .where('utenteId', isEqualTo: _userId)
        .get();

    setState(() {
      _numPersonaggi = querySnapshot.size;
    });
  }

  Future<void> _calcolaRazzaPreferita() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('personaggi')
        .where('utenteId', isEqualTo: _userId)
        .get();

    final Map<String, int> razzeOccorrenze = {};

    querySnapshot.docs.forEach((doc) {
      final String razza = doc['razza'] ?? 'N/A';
      razzeOccorrenze[razza] = (razzeOccorrenze[razza] ?? 0) + 1;
    });

    if (razzeOccorrenze.isNotEmpty) {
      final List<MapEntry<String, int>> sortedRazze = razzeOccorrenze.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (sortedRazze.length > 1 && sortedRazze[0].value == sortedRazze[1].value) {
        setState(() {
          _razzaPreferita = 'Nessuna';
        });
      } else {
        setState(() {
          _razzaPreferita = sortedRazze.first.key;
        });
      }
    }
  }

  Future<void> _calcolaClassePreferita() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('personaggi')
        .where('utenteId', isEqualTo: _userId)
        .get();

    final Map<String, int> classiOccorrenze = {};

    querySnapshot.docs.forEach((doc) {
      final String classe = doc['classe'] ?? 'N/A';
      classiOccorrenze[classe] = (classiOccorrenze[classe] ?? 0) + 1;
    });

    if (classiOccorrenze.isNotEmpty) {
      final List<MapEntry<String, int>> sortedClassi = classiOccorrenze.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (sortedClassi.length > 1 && sortedClassi[0].value == sortedClassi[1].value) {
        setState(() {
          _classePreferita = 'Nessuna';
        });
      } else {
        setState(() {
          _classePreferita = sortedClassi.first.key;
        });
      }
    }
  }


  Future<void> _calcolaNumeroCampagnePartecipate() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('campagne').get();

    int numCampagne = 0;

    querySnapshot.docs.forEach((doc) {
      final String masterId = doc['masterId'] ?? '';
      final List<dynamic> partecipanti = doc['partecipanti'] ?? [];

      if (masterId == _userId || partecipanti.contains(_userId)) {
        numCampagne++;
      }
    });

    setState(() {
      _numCampagnePartecipate = numCampagne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Informazioni utente',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Email: $_email',
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Numero personaggi creati: $_numPersonaggi',
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Razza preferita: $_razzaPreferita',
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Classe preferita: $_classePreferita',
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Numero campagne partecipate: $_numCampagnePartecipate',
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
