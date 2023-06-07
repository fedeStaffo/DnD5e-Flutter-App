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

  String? _userId; // ID utente corrente
  String? _email; // Email utente corrente
  int _numPersonaggi = 0; // Numero di personaggi creati dall'utente
  String _razzaPreferita = ''; // Razza preferita dell'utente
  String _classePreferita = ''; // Classe preferita dell'utente
  int _numCampagnePartecipate = 0; // Numero di campagne a cui l'utente ha partecipato

  @override
  void initState() {
    super.initState();
    _caricaInformazioniUtente(); // Carica le informazioni dell'utente quando lo stato del widget viene inizializzato
  }

  Future<void> _caricaInformazioniUtente() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        _userId = user.uid; // Imposta l'ID utente corrente
        _email = user.email; // Imposta l'email utente corrente
      });

      await _calcolaNumeroPersonaggi(); // Calcola il numero di personaggi creati dall'utente
      await _calcolaRazzaPreferita(); // Calcola la razza preferita dell'utente
      await _calcolaClassePreferita(); // Calcola la classe preferita dell'utente
      await _calcolaNumeroCampagnePartecipate(); // Calcola il numero di campagne a cui l'utente ha partecipato
    }
  }

  Future<void> _calcolaNumeroPersonaggi() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('personaggi')
        .where('utenteId', isEqualTo: _userId)
        .get();

    setState(() {
      _numPersonaggi = querySnapshot.size; // Imposta il numero di personaggi creati dall'utente
    });
  }

  Future<void> _calcolaRazzaPreferita() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('personaggi')
        .where('utenteId', isEqualTo: _userId)
        .get();

    final Map<String, int> razzeOccorrenze = {};

    // Calcola il numero di occorrenze per ogni razza dei personaggi dell'utente
    querySnapshot.docs.forEach((doc) {
      final String razza = doc['razza'] ?? 'N/A';
      razzeOccorrenze[razza] = (razzeOccorrenze[razza] ?? 0) + 1;
    });

    if (razzeOccorrenze.isNotEmpty) {
      final List<MapEntry<String, int>> sortedRazze = razzeOccorrenze.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (sortedRazze.length > 1 && sortedRazze[0].value == sortedRazze[1].value) {
        setState(() {
          _razzaPreferita = 'Nessuna'; // Se ci sono più razze con lo stesso numero di occorrenze massime, la razza preferita viene impostata come "Nessuna"
        });
      } else {
        setState(() {
          _razzaPreferita = sortedRazze.first.key; // Imposta la razza preferita come la prima razza con il numero massimo di occorrenze
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

    // Calcola il numero di occorrenze per ogni classe dei personaggi dell'utente
    querySnapshot.docs.forEach((doc) {
      final String classe = doc['classe'] ?? 'N/A';
      classiOccorrenze[classe] = (classiOccorrenze[classe] ?? 0) + 1;
    });

    if (classiOccorrenze.isNotEmpty) {
      final List<MapEntry<String, int>> sortedClassi = classiOccorrenze.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (sortedClassi.length > 1 && sortedClassi[0].value == sortedClassi[1].value) {
        setState(() {
          _classePreferita = 'Nessuna'; // Se ci sono più classi con lo stesso numero di occorrenze massime, la classe preferita viene impostata come "Nessuna"
        });
      } else {
        setState(() {
          _classePreferita = sortedClassi.first.key; // Imposta la classe preferita come la prima classe con il numero massimo di occorrenze
        });
      }
    }
  }

  Future<void> _calcolaNumeroCampagnePartecipate() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('campagne').get();

    int numCampagne = 0;

    // Conta il numero di campagne a cui l'utente ha partecipato come master o come partecipante
    querySnapshot.docs.forEach((doc) {
      final String masterId = doc['masterId'] ?? '';
      final List<dynamic> partecipanti = doc['partecipanti'] ?? [];

      if (masterId == _userId || partecipanti.contains(_userId)) {
        numCampagne++;
      }
    });

    setState(() {
      _numCampagnePartecipate = numCampagne; // Imposta il numero di campagne a cui l'utente ha partecipato
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
                'Email: $_email', // Visualizza l'email dell'utente corrente
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Numero personaggi creati: $_numPersonaggi', // Visualizza il numero di personaggi creati dall'utente corrente
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Razza preferita: $_razzaPreferita', // Visualizza la razza preferita dell'utente corrente
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Classe preferita: $_classePreferita', // Visualizza la classe preferita dell'utente corrente
                style: const TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Numero campagne partecipate: $_numCampagnePartecipate', // Visualizza il numero di campagne a cui l'utente corrente ha partecipato
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
