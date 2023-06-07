import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_dd/auth/auth.dart';
import 'package:progetto_dd/auth/reset_password_page.dart';

import '../pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isRegistered = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool passwordObscured = true;

  // Funzione per effettuare l'accesso con email e password
  Future<void> signInWithEmailAndPassword() async {
    try {
      final email = _controllerEmail.text.trim();
      final password = _controllerPassword.text.trim();

      // Verifica che email e password non siano vuote o contengano spazi
      if (email.isEmpty || password.isEmpty || email.contains(' ') || password.contains(' ')) {
        setState(() {
          errorMessage = 'Inserisci una email e una password valide.';
        });
        return;
      }

      // Effettua l'accesso utilizzando la classe Auth
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Naviga alla MyHomePage dopo un accesso avvenuto con successo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Scheda D&D 5e')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }


  // Funzione per creare un nuovo account con email e password
  Future<void> createUserWithEmailAndPassword() async {
    try {
      final email = _controllerEmail.text.trim();
      final password = _controllerPassword.text.trim();

      // Verifica che email e password non siano vuote o contengano spazi
      if (email.isEmpty || password.isEmpty || email.contains(' ') || password.contains(' ')) {
        setState(() {
          errorMessage = 'Inserisci una email e una password valide.';
        });
        return;
      }

      // Verifica che l'email contenga il simbolo @
      if (!email.contains('@')) {
        setState(() {
          errorMessage = 'Inserisci un\'email valida.';
        });
        return;
      }

      // Crea un nuovo account utilizzando la classe Auth
      await Auth().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      setState(() {
        isRegistered = true;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Widget per il campo di input di testo
  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: title == 'Password' ? passwordObscured : false,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: title == 'Password'
            ? IconButton(
          onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
          icon: Icon(passwordObscured ? Icons.visibility : Icons.visibility_off),
        )
            : null,
      ),
    );
  }

  // Widget per il messaggio di errore
  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Oops! $errorMessage',
      style: const TextStyle(color: Colors.red),
    );
  }

  // Widget per il messaggio di successo
  Widget _successMessage() {
    if (isRegistered) {
      return Text(
        'Registrazione avvenuta con successo!',
        style: const TextStyle(color: Colors.green),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  // Widget per il pulsante di invio
  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Accedi' : 'Registrati'),
    );
  }

  // Widget per il pulsante di login o registrazione
  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
          errorMessage = '';
          isRegistered = false;
          _controllerEmail.clear();
          _controllerPassword.clear();
        });
      },
      child: Text(
        isLogin ? 'Non sei registrato?\nRegistrati' : 'Già registrato?\nAccedi',
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget per il pulsante di reset della password
  Widget _resetPasswordButton() {
    return TextButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordPage()),
        );
      },
      child: const Text(
        'Password dimenticata?',
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benvenuto in Scheda D&D 5e'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Accedi o registrati per proseguire!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _entryField('Email', _controllerEmail),
            const SizedBox(height: 12),
            _entryField('Password', _controllerPassword),
            const SizedBox(height: 12),
            _errorMessage(),
            _successMessage(),
            const SizedBox(height: 16),
            _submitButton(),
            const SizedBox(height: 12),
            _loginOrRegisterButton(),
            _resetPasswordButton(),
          ],
        ),
      ),
    );
  }
}
