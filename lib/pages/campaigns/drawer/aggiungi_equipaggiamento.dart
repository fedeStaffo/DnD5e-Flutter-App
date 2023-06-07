import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AggiungiEquipaggiamento extends StatefulWidget {
  final String? campagnaNome;

  AggiungiEquipaggiamento({required this.campagnaNome});

  @override
  _AggiungiEquipaggiamentoState createState() => _AggiungiEquipaggiamentoState();
}

class _AggiungiEquipaggiamentoState extends State<AggiungiEquipaggiamento> {
  String? selectedGiocatore; // Giocatore selezionato
  List<String> giocatori = []; // Elenco dei giocatori

  final TextEditingController _equipaggiamentoController = TextEditingController(); // Controller per il campo di testo dell'equipaggiamento

  @override
  void initState() {
    super.initState();
    _fetchGiocatori(); // Recupera i giocatori della campagna dal database
  }

  void _fetchGiocatori() {
    // Recupera i giocatori associati alla campagna dal database
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

  void _aggiungiEquipaggiamento() {
    // Aggiunge l'equipaggiamento al personaggio nel database
    if (selectedGiocatore == null || _equipaggiamentoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Seleziona un giocatore e inserisci l\'equipaggiamento.'),
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
        List<dynamic> equipaggiamento = List.from(document['equipaggiamento']);
        equipaggiamento.add(_equipaggiamentoController.text);

        document.reference.update({
          'equipaggiamento': equipaggiamento,
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Equipaggiamento aggiunto con successo!'),
          ));
          _equipaggiamentoController.clear();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Si è verificato un errore durante l\'aggiunta dell\'equipaggiamento.'),
          ));
        });
      }
    }).catchError((error) {
      print('Si è verificato un errore durante la query: $error');
    });
  }

  @override
  void dispose() {
    _equipaggiamentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aggiungi Equipaggiamento'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seleziona il giocatore a cui aggiungere l\'equipaggiamento',
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
                  // Elenco dei giocatori disponibili nel menu a tendina
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
              TextField(
                controller: _equipaggiamentoController,
                decoration: const InputDecoration(
                  labelText: 'Equipaggiamento',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _aggiungiEquipaggiamento,
                child: const Text(
                  'Aggiungi',
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
