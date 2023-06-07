import 'package:cloud_firestore/cloud_firestore.dart';

class Campagna {
  final String? nome; // Nome della campagna
  final String? masterId; // ID del master della campagna
  final String? masterNome; // Nome del master della campagna
  final String? password; // Password della campagna
  final List<String>? partecipanti; // Elenco dei partecipanti alla campagna

  Campagna({
    required this.nome,
    required this.masterId,
    required this.masterNome,
    required this.password,
    required this.partecipanti,
  });

  // Factory method per creare un'istanza di Campagna a partire da uno snapshot di Firestore
  factory Campagna.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Campagna(
      nome: data['nome'] ?? '', // Recupera il nome dalla mappa dei dati dello snapshot
      masterId: data['masterId'] ?? '', // Recupera l'ID del master dalla mappa dei dati dello snapshot
      masterNome: data['masterNome'] ?? '', // Recupera il nome del master dalla mappa dei dati dello snapshot
      password: data['password'] ?? '', // Recupera la password dalla mappa dei dati dello snapshot
      partecipanti: List<String>.from(data['partecipanti'] ?? []), // Recupera la lista dei partecipanti dalla mappa dei dati dello snapshot
    );
  }
}
