import 'package:flutter/material.dart';
import 'package:progetto_dd/auth/auth.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Sei sicuro di voler effettuare il logout?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Effettua il logout utilizzando la classe Auth
                Auth().signOut();
                // Reindirizza l'utente alla pagina di login
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
