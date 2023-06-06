import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progetto_dd/pages/campaigns/drawer/aggiorna_stato_personaggio.dart';
import 'package:progetto_dd/pages/campaigns/drawer/aggiungi_equipaggiamento.dart';
import 'package:progetto_dd/pages/campaigns/drawer/crea_npc.dart';
import 'package:progetto_dd/pages/campaigns/drawer/crea_sessione.dart';
import 'package:progetto_dd/pages/campaigns/drawer/dado.dart';
import 'package:progetto_dd/pages/campaigns/drawer/elimina_campagna.dart';
import 'package:progetto_dd/pages/campaigns/drawer/visualizza_npc.dart';
import 'package:progetto_dd/pages/campaigns/drawer/visualizza_sessioni.dart';
import '../../../memory/campaign.dart';
import '../../../memory/character_card.dart';
import 'campaign_reset_password.dart';
import 'elimina_giocatori.dart';

class CampaignScreen extends StatelessWidget {
  final Campagna campagna;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CampaignScreen({required this.campagna});

  @override
  Widget build(BuildContext context) {

    final User? user = _auth.currentUser;
    String? userId = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campagna'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/drawer_campagna.png',
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: const Text('Campagna'),
              leading: Image.asset(
                'assets/images/casetta.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampaignScreen(
                      campagna: campagna,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Dado'),
              leading: Image.asset(
                'assets/images/dado.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dado(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Npc'),
              leading: Image.asset(
                'assets/images/npc.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualizzaNpc(
                      campagna: campagna.nome,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sessioni'),
              leading: Image.asset(
                'assets/images/libro_aperto.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualizzaSessioni(
                      campagna: campagna.nome,
                    ),
                  ),
                );
              },
            ),
            if (campagna.masterId == userId) ...[
              const Divider(color: Colors.black),
              const Text('Master'),
              ListTile(
                title: const Text('Crea Npc'),
                leading: Image.asset(
                  'assets/images/fabbro.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreaNpc(
                        campagna: campagna.nome,
                        masterId: campagna.masterId,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Crea Sessioni'),
                leading: Image.asset(
                  'assets/images/penna_antica.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreaSessione(
                        campagna: campagna.nome,
                        masterId: campagna.masterId,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Effetti'),
                leading: Image.asset(
                  'assets/images/effetti.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AggiornaStatoPersonaggio(
                        campagnaNome: campagna.nome,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Nuovo Oggetto'),
                leading: Image.asset(
                  'assets/images/pozione.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AggiungiEquipaggiamento(
                        campagnaNome: campagna.nome,
                      ),
                    ),
                  );
                },
              ),
            ],
            if (campagna.masterId == userId) ...[
              const Divider(color: Colors.black),
              const Text('Gestione Campagne'),
              ListTile(
                title: const Text('Reset password'),
                leading: Image.asset(
                  'assets/images/password.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampaignResetPassword(
                        campagnaNome: campagna.nome,
                        masterId: campagna.masterId,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Elimina Giocatori'),
                leading: Image.asset(
                  'assets/images/john_wick.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EliminaGiocatori(
                        campagnaNome: campagna.nome,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Elimina Campagna'),
                leading: Image.asset(
                  'assets/images/bombetta.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EliminaCampagna(
                        campagnaNome: campagna.nome,
                        masterId: campagna.masterId,
                      ),
                    ),
                  );
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Chiudi'),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Master: ${campagna.masterNome}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Personaggi partecipanti:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('personaggi')
                    .where('campagna', isEqualTo: campagna.nome)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Si è verificato un errore.');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Text('Nessun personaggio trovato.');
                  }

                  final personaggi = snapshot.data!.docs;

                  if (personaggi.isEmpty) {
                    return const Text('Nessun personaggio trovato.');
                  }

                  return ListView.builder(
                    itemCount: personaggi.length,
                    itemBuilder: (context, index) {
                      final personaggio = personaggi[index];

                      return CharacterCard(
                        nome: personaggio['nome'],
                        classe: personaggio['classe'],
                        razza: personaggio['razza'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
