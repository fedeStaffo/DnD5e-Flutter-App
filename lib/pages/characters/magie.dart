import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MagieScreen extends StatefulWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  MagieScreen({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  @override
  _MagieScreenState createState() => _MagieScreenState();
}

class _MagieScreenState extends State<MagieScreen> {
  List<String> magie = [];

  @override
  void initState() {
    super.initState();
    fetchMagie(); // Recupera l'elenco delle magie al momento dell'inizializzazione dello stato
  }

  Future<void> fetchMagie() async {
    // Recupera i dati del personaggio corrispondente ai parametri forniti
    final personaggiSnapshot = await FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: widget.nome)
        .where('classe', isEqualTo: widget.classe)
        .where('razza', isEqualTo: widget.razza)
        .where('utenteId', isEqualTo: widget.utenteId)
        .get();

    if (personaggiSnapshot.docs.isNotEmpty) {
      final personaggioDoc = personaggiSnapshot.docs.first;
      final magieData = personaggioDoc.data()['magie'];

      if (magieData is List) {
        setState(() {
          magie = List<String>.from(magieData); // Aggiorna la lista delle magie con i dati ottenuti
        });
      }
    }
  }

  Widget buildMagieList() {
    if (magie.isEmpty) {
      // Se non ci sono magie disponibili per il personaggio, mostra un messaggio appropriato
      return const Text(
        'Nessun incantesimo disponibile per tale personaggio',
        style: TextStyle(fontSize: 18),
      );
    }

    final magieText = magie.join(',\n'); // Unisce le magie in un unico testo separato da virgole

    return Text(
      magieText,
      style: const TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Lista incantesimi:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          buildMagieList(), // Mostra l'elenco delle magie
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
