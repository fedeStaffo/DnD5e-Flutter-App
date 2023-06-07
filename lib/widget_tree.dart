import 'package:progetto_dd/auth/auth.dart';
import 'package:progetto_dd/auth/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:progetto_dd/pages/home.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, // Stream per monitorare lo stato dell'autenticazione
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Se è presente un utente autenticato, mostra la home page
          return MyHomePage(title: 'Scheda D&D 5e');
        } else {
          // Altrimenti, mostra la pagina di accesso
          return const LoginPage();
        }
      },
    );
  }
}
