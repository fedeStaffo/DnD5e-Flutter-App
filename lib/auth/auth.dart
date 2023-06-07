import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Restituisce l'utente corrente se è autenticato, altrimenti null
  User? get currentUser => _firebaseAuth.currentUser;

  // Restituisce uno stream di User? che rappresenta gli eventi di cambio di stato di autenticazione
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Effettua l'accesso utilizzando l'email e la password fornite
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // Crea un nuovo account utilizzando l'email e la password fornite
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Effettua il logout
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Invia una email per il ripristino della password all'indirizzo specificato
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
