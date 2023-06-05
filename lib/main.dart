import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progetto_dd/pages/campaigns/home_campaigns.dart';
import 'firebase_options.dart';
import 'package:progetto_dd/widget_tree.dart';
import 'package:progetto_dd/auth/login_register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          // PROVA: Prova a cambiare il primarySwatch con un altro colore, come Colors.green.
        ),
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home_campaigns': (context) => HomeCampaigns(),
      },
      home: const WidgetTree()
    );
  }
}
