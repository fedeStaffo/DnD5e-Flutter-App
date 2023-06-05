import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AggiornaStatoPersonaggio extends StatefulWidget {
  final String? campagnaNome;

  AggiornaStatoPersonaggio({required this.campagnaNome});

  @override
  _AggiornaStatoPersonaggioState createState() => _AggiornaStatoPersonaggioState();
}

class _AggiornaStatoPersonaggioState extends State<AggiornaStatoPersonaggio> {
  String? selectedGiocatore;
  String? selectedStato;
  List<String> giocatori = [];
  List<String> stati = [
    'Accecato',
    'Affascinato',
    'Afferrato',
    'Assordato',
    'Avvelenato',
    'Incapacitato',
    'Invisibile',
    'Paralizzato',
    'Pietrificato',
    'Privo di sensi',
    'Prono',
    'Spaventato',
    'Stordito',
    'Trattenuto',
    'Nessuno',
  ];

  @override
  void initState() {
    super.initState();
    _fetchGiocatori();
  }

  void _fetchGiocatori() {
    FirebaseFirestore.instance
        .collection('personaggi')
        .where('campagna', isEqualTo: widget.campagnaNome)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size > 0) {
        setState(() {
          giocatori = querySnapshot.docs.map<String>((doc) => doc['nome'] as String).toList();
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  void _aggiornaStato() {
    if (selectedGiocatore == null || selectedStato == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Seleziona un giocatore e uno stato.'),
      ));
      return;
    }

    FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: selectedGiocatore)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {
        final document = querySnapshot.docs[0];

        document.reference.update({
          'stato': selectedStato,
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Stato aggiornato con successo!'),
          ));
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Si è verificato un errore durante l\'aggiornamento dello stato.'),
          ));
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiorna Stato Personaggio'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seleziona il giocatore e lo stato da aggiornare',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGiocatore,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGiocatore = newValue;
                  });
                },
                items: giocatori.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Giocatore',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStato,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStato = newValue;
                  });
                },
                items: stati.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Stato',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _aggiornaStato,
                child: const Text(
                  'Aggiorna Stato',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
