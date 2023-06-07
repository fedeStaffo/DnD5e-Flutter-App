import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progetto_dd/pages/campaigns/home_campaigns.dart';
import 'firebase_options.dart';
import 'package:progetto_dd/widget_tree.dart';
import 'package:progetto_dd/auth/login_register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inizializzazione di Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheda D&D 5e',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      routes: {
        '/login': (context) => LoginPage(), // Pagina di accesso
        '/home_campaigns': (context) => HomeCampaigns(), // Pagina principale delle campagne
      },
      home: const WidgetTree(), // Widget principale dell'applicazione
    );
  }
}
