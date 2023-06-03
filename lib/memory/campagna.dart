import 'package:cloud_firestore/cloud_firestore.dart';

class Campagna {
  final String nome;
  final String masterId;
  final String masterNome;
  final String password;
  final List<String> partecipanti;

  Campagna({
    required this.nome,
    required this.masterId,
    required this.masterNome,
    required this.password,
    required this.partecipanti,
  });

  factory Campagna.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Campagna(
      nome: data['nome'] ?? '',
      masterId: data['masterId'] ?? '',
      masterNome: data['masterNome'] ?? '',
      password: data['password'] ?? '',
      partecipanti: List<String>.from(data['partecipanti'] ?? []),
    );
  }
}
