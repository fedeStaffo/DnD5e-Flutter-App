import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreaNpc extends StatefulWidget {
  final String? campagna;
  final String? masterId;

  CreaNpc({required this.campagna, required this.masterId});

  @override
  _CreaNpcState createState() => _CreaNpcState();
}

class _CreaNpcState extends State<CreaNpc> {
  final TextEditingController _nomeController = TextEditingController();
  String? _legameSelezionato;
  final TextEditingController _descrizioneController = TextEditingController();

  final List<String> _legami = [
    'Alleato',
    'Amico',
    'Animale',
    'Base',
    'Boss',
    'Divinità',
    'Familiare',
    'Locandiere',
    'Maestro',
    'Mostriciattolo',
    'Nemesi',
    'Nemico',
    'Patrono',
  ];

  void _creaNpc() async {
    final String nome = _nomeController.text;
    final String legame = _legameSelezionato ?? '';
    final String descrizione = _descrizioneController.text;
    final String? campagna = widget.campagna;
    final String? master = widget.masterId;

    if (nome.isEmpty || legame.isEmpty || descrizione.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Riempi tutti i campi.'),
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

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('npc')
        .where('campagna', isEqualTo: campagna)
        .where('nome', isEqualTo: nome)
        .get();

    if (snapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Esiste già un NPC con lo stesso nome nella stessa campagna'),
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

    final npcData = {
      'nome': nome,
      'legame': legame,
      'descrizione': descrizione,
      'campagna': campagna,
      'master': master,
    };

    FirebaseFirestore.instance.collection('npc').add(npcData).then((_) {
      _nomeController.clear();
      _legameSelezionato = null;
      _descrizioneController.clear();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Successo'),
            content: const Text('NPC creato correttamente.'),
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Errore'),
            content: const Text('Si è verificato un errore durante la creazione dell\'NPC.'),
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
        title: const Text('Crea NPC'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                value: _legameSelezionato,
                hint: const Text('Seleziona un legame'),
                onChanged: (value) {
                  setState(() {
                    _legameSelezionato = value;
                  });
                },
                items: _legami.map((legame) {
                  return DropdownMenuItem<String>(
                    value: legame,
                    child: Text(legame),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _descrizioneController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _creaNpc,
                child: const Text('Crea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
