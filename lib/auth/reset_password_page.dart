import 'package:flutter/material.dart';
import 'package:progetto_dd/auth/auth.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  String? errorMessage = '';

  Future<void> resetPassword() async {
    try {
      final email = _controllerEmail.text.trim();

      // Verifica se l'email è vuota, contiene spazi o non contiene il simbolo '@'
      if (email.isEmpty || email.contains(' ') || !(email.contains('@'))) {
        setState(() {
          errorMessage = 'Inserisci un\'email valida.';
        });
        return;
      }

      // Chiama la funzione di reset password fornita dalla classe Auth
      await Auth().resetPassword(email);

      setState(() {
        errorMessage = 'Email di reset password inviata. Controlla la tua casella di posta.';
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  // Widget per i campi di input
  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
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

  // Widget per il pulsante di invio reset password
  Widget _submitButton() {
    return ElevatedButton(
      onPressed: resetPassword,
      child: const Text('Invia Reset Password'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Inserisci la tua email per reimpostare la password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/forget_password_icon.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 12),
            _entryField('Email', _controllerEmail),
            const SizedBox(height: 12),
            _errorMessage(),
            const SizedBox(height: 16),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}
