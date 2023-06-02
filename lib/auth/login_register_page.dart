import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progetto_dd/auth/auth.dart';
import 'package:progetto_dd/auth/reset_password_page.dart';

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

  Future<void> signInWithEmailAndPassword() async {
    try {
      final email = _controllerEmail.text.trim();
      final password = _controllerPassword.text.trim();

      if (email.isEmpty || password.isEmpty || email.contains(' ') || password.contains(' ')) {
        setState(() {
          errorMessage = 'Inserisci una email e una password valide.';
        });
        return;
      }

      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final email = _controllerEmail.text.trim();
      final password = _controllerPassword.text.trim();

      if (email.isEmpty || password.isEmpty || email.contains(' ') || password.contains(' ')) {
        setState(() {
          errorMessage = 'Inserisci una email e una password valide.';
        });
        return;
      }

      if (!email.contains('@')) {
        setState(() {
          errorMessage = 'Inserisci un\'email valida.';
        });
        return;
      }

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

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Oops! $errorMessage',
      style: const TextStyle(color: Colors.red),
    );
  }

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

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Accedi' : 'Registrati'),
    );
  }

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
