import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progetto_dd/auth/logout_page.dart';
import 'package:progetto_dd/pages/campaigns/home_campaigns.dart';
import 'characters/home_character.dart';
import 'info.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.asset(
                'assets/images/drawer_image.jpg',
                fit: BoxFit.fill,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profilo'),
              onTap: () {
                // Azioni da eseguire quando "Profilo" viene selezionato
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Azioni da eseguire quando "Logout" viene selezionato
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogoutPage()),
                );
              },
            ),
            const Divider(color: Colors.black,),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Info e contatti'),
              onTap: () {
                // Azioni da eseguire quando "Info e contatti" viene selezionato
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
            ),
            const Divider(color: Colors.black,),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Chiudi'),
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeCharacter(userId: currentUser!.uid),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/knight.png'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Personaggi',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeCampaigns(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/treasure_map.png'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Campagne',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}