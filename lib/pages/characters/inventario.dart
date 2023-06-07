import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../memory/character.dart';

class InventarioScreen extends StatefulWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  InventarioScreen({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  @override
  _InventarioScreenState createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final TextEditingController _equipaggiamentoController = TextEditingController();

  void _salvaEquipaggiamento() async {
    final String equipaggiamento = _equipaggiamentoController.text.trim();

    if (equipaggiamento.isEmpty) {
      // Mostra una finestra di dialogo se il campo equipaggiamento è vuoto
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Errore'),
            content: Text('Non sono ammessi campi vuoti.'),
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

    // Esegui una query per trovare il personaggio corrispondente
    final personaggiSnapshot = await FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: widget.nome)
        .where('classe', isEqualTo: widget.classe)
        .where('razza', isEqualTo: widget.razza)
        .where('utenteId', isEqualTo: widget.utenteId)
        .get();

    if (personaggiSnapshot.docs.isNotEmpty) {
      final personaggioDoc = personaggiSnapshot.docs.first;
      final personaggio = Personaggio.fromSnapshot(personaggioDoc);
      final updatedEquipaggiamento = [...personaggio.equipaggiamento ?? [], equipaggiamento];

      // Aggiorna il documento del personaggio con il nuovo equipaggiamento
      await personaggioDoc.reference.update({'equipaggiamento': updatedEquipaggiamento});

      // Mostra una finestra di dialogo per confermare il successo dell'aggiunta dell'oggetto
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Successo'),
            content: Text('Oggetto salvato correttamente, torna indietro per vedere la lista aggiornata.'),
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

  void _rimuoviEquipaggiamento(String equipaggiamento) async {
    // Esegui una query per trovare il personaggio corrispondente
    final personaggiSnapshot = await FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: widget.nome)
        .where('classe', isEqualTo: widget.classe)
        .where('razza', isEqualTo: widget.razza)
        .where('utenteId', isEqualTo: widget.utenteId)
        .get();

    if (personaggiSnapshot.docs.isNotEmpty) {
      final personaggioDoc = personaggiSnapshot.docs.first;
      final personaggio = Personaggio.fromSnapshot(personaggioDoc);
      final updatedEquipaggiamento = [...personaggio.equipaggiamento ?? []];
      updatedEquipaggiamento.remove(equipaggiamento);

      // Aggiorna il documento del personaggio rimuovendo l'oggetto dall'equipaggiamento
      await personaggioDoc.reference.update({'equipaggiamento': updatedEquipaggiamento});

      // Mostra una finestra di dialogo per confermare il successo della rimozione dell'oggetto
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Successo'),
            content: Text('Oggetto rimosso correttamente, torna indietro per vedere la lista aggiornata.'),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('personaggi')
          .where('nome', isEqualTo: widget.nome)
          .where('classe', isEqualTo: widget.classe)
          .where('razza', isEqualTo: widget.razza)
          .where('utenteId', isEqualTo: widget.utenteId)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Se la connessione è in attesa, mostra un indicatore di caricamento
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Se si verifica un errore, mostra un messaggio di errore
          return Center(
            child: Text('Errore: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          // Se non ci sono dati o i dati sono vuoti, mostra un messaggio che il personaggio non è stato trovato
          return const Center(
            child: Text('Personaggio non trovato'),
          );
        } else {
          final personaggio = Personaggio.fromSnapshot(
            snapshot.data!.docs.first, // Utilizza il primo documento nella lista
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Equipaggiamento:\n',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  personaggio.equipaggiamento?.join(',\n') ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _equipaggiamentoController,
                  decoration: const InputDecoration(
                    labelText: 'Oggetto da aggiungere o rimuovere',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _salvaEquipaggiamento,
                      child: Text('Aggiungi'),
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Rimuovi oggetto'),
                              content: Text('Sei sicuro di voler rimuovere questo oggetto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Annulla'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _rimuoviEquipaggiamento('oggetto_da_rimuovere');
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Rimuovi'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Rimuovi'),
                    ),
                  ],
                )

              ],
            ),
          );
        }
      },
    );
  }
}
