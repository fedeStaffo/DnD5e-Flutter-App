import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreaSessione extends StatefulWidget {
  final String? campagna;
  final String? masterId;

  CreaSessione({required this.campagna, required this.masterId});

  @override
  _CreaSessioneState createState() => _CreaSessioneState();
}

class _CreaSessioneState extends State<CreaSessione> {
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _giornoController = TextEditingController();
  final TextEditingController _descrizioneController = TextEditingController();

  // Funzione per creare una sessione
  void _creaSessione() async {
    final String numero = _numeroController.text;
    final String giorno = _giornoController.text;
    final String descrizione = _descrizioneController.text;
    final String? campagna = widget.campagna;
    final String? master = widget.masterId;

    // Controllo se tutti i campi sono stati riempiti
    if (numero.isEmpty || giorno.isEmpty || descrizione.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Assicurati di compilare tutti i campi'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Controllo se il formato della data è corretto
    final RegExp dateRegex = RegExp(r'^\d{4}/\d{2}/\d{2}$');
    if (!dateRegex.hasMatch(giorno)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Inserisci una data nel formato corretto (YYYY/MM/DD)'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Controllo se il numero è un valore numerico
    if (int.tryParse(numero) == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Inserisci un numero valido'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Controllo se esiste già una sessione con lo stesso numero nella stessa campagna
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('sessioni')
        .where('campagna', isEqualTo: campagna)
        .where('numero', isEqualTo: numero)
        .get();

    if (snapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Esiste già una sessione con lo stesso numero nella stessa campagna'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Creazione della sessione nel database
    FirebaseFirestore.instance.collection('sessioni').add({
      'numero': numero,
      'giorno': giorno,
      'descrizione': descrizione,
      'campagna': campagna,
      'master': master,
    }).then((_) {
      // Mostra un dialogo di successo
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Successo'),
            content: const Text('La sessione è stata creata'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Mostra un dialogo di errore in caso di fallimento
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Si è verificato un errore durante la creazione della sessione'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea Sessione'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _numeroController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Numero',
                ),
              ),
              TextField(
                controller: _giornoController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Giorno (YYYY/MM/DD)',
                ),
              ),
              TextField(
                controller: _descrizioneController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _creaSessione,
                child: const Text('Crea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
