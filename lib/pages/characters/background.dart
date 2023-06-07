import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../memory/character.dart';

class BackGroundScreen extends StatefulWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  BackGroundScreen({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  @override
  _BackGroundScreenState createState() => _BackGroundScreenState();
}

class _BackGroundScreenState extends State<BackGroundScreen> {
  String _selectedField = 'Allineamento'; // Campo selezionato per la modifica inizializzato a "Allineamento"
  final TextEditingController _modificaController = TextEditingController(); // Controller per il campo di testo di modifica
  String? _selectedAlignment; // Allineamento selezionato

  void _salvaModifica() async {
    final String modifica = _modificaController.text.trim(); // Testo di modifica ottenuto dal campo di testo

    if (modifica.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Errore'),
            content: Text('Non sono ammessi campi vuoti.'), // Messaggio di errore se il campo di modifica è vuoto
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final personaggiSnapshot = await FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: widget.nome)
        .where('classe', isEqualTo: widget.classe)
        .where('razza', isEqualTo: widget.razza)
        .where('utenteId', isEqualTo: widget.utenteId)
        .get(); // Ottiene lo snapshot dei personaggi corrispondenti ai criteri di ricerca

    if (personaggiSnapshot.docs.isNotEmpty) {
      final personaggioDoc = personaggiSnapshot.docs.first; // Ottiene il primo documento nella lista
      final fieldName = _selectedField.toLowerCase(); // Converte il nome del campo selezionato in minuscolo
      final fieldData = {fieldName: modifica}; // Dati da aggiornare nel documento

      await personaggioDoc.reference.update(fieldData); // Aggiorna il documento con i nuovi dati

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Successo'),
            content: Text('Modifica salvata correttamente.'), // Messaggio di successo per la modifica salvata
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildAllineamentoSpinner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: _selectedAlignment,
          onChanged: (String? newValue) {
            setState(() {
              _selectedAlignment = newValue;
              _modificaController.text = newValue!; // Aggiorna il campo di testo di modifica con l'allineamento selezionato
            });
          },
          items: <String>[
            'Legale Buono',
            'Neutrale Buono',
            'Caotico Buono',
            'Legale Neutrale',
            'Neutrale',
            'Caotico Neutrale',
            'Legale Malvagio',
            'Neutrale Malvagio',
            'Caotico Malvagio',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextInput() {
    return TextFormField(
      controller: _modificaController,
      maxLines: _selectedField == 'Allineamento' ? 1 : null,
      decoration: InputDecoration(
        labelText: _selectedField,
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('personaggi')
          .where('nome', isEqualTo: widget.nome)
          .where('classe', isEqualTo: widget.classe)
          .where('razza', isEqualTo: widget.razza)
          .where('utenteId', isEqualTo: widget.utenteId)
          .get(), // Ottiene lo snapshot dei personaggi corrispondenti ai criteri di ricerca
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Errore: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Personaggio non trovato'), // Messaggio se il personaggio non è stato trovato
          );
        } else {
          final personaggio = Personaggio.fromSnapshot(
            snapshot.data!.docs.first, // Utilizzo il primo documento nella lista
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Background',
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Allineamento: ${personaggio.allineamento ?? ''}',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  'Descrizione: ${personaggio.descrizione ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Ideali: ${personaggio.ideali ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Legami: ${personaggio.legami ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Storia: ${personaggio.storia ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Difetti: ${personaggio.difetti ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Tratti: ${personaggio.tratti ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Modifica:',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: _selectedField,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedField = newValue!; // Aggiorna il campo selezionato per la modifica
                          if (_selectedField == 'Allineamento') {
                            _modificaController.text = _selectedAlignment ?? ''; // Aggiorna il campo di testo di modifica con l'allineamento selezionato
                          } else {
                            _modificaController.text = '';
                          }
                        });
                      },
                      items: <String>[
                        'Allineamento',
                        'Descrizione',
                        'Ideali',
                        'Legami',
                        'Storia',
                        'Difetti',
                        'Tratti',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _selectedField == 'Allineamento'
                    ? _buildAllineamentoSpinner()
                    : _buildTextInput(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _salvaModifica,
                      child: Text('Salva'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
