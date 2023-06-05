import 'package:cloud_firestore/cloud_firestore.dart';

class Personaggio {
  final String? nome;
  final String? utenteId;
  final String? classe;
  final String? razza;
  final String? campagna;
  final List<String>? competenze;
  final List<String>? equipaggiamento;
  final String? stato;
  final int? vitaMax;
  final int? vita;
  final int? livello;
  final int? classeArmatura;
  final int? carisma;
  final int? costituzione;
  final int? destrezza;
  final int? forza;
  final int? intelligenza;
  final int? saggezza;
  final String? allineamento;
  final String? descrizione;
  final String? ideali;
  final String? legami;
  final String? storia;
  final String? difetti;
  final String? tratti;

  Personaggio({
    this.nome,
    this.utenteId,
    this.classe,
    this.razza,
    this.campagna,
    List<String>? competenze,
    List<String>? equipaggiamento,
    this.stato,
    this.vitaMax,
    this.vita,
    this.livello,
    this.classeArmatura,
    this.carisma,
    this.costituzione,
    this.destrezza,
    this.forza,
    this.intelligenza,
    this.saggezza,
    this.allineamento,
    this.descrizione,
    this.ideali,
    this.legami,
    this.storia,
    this.difetti,
    this.tratti,
  })  : competenze = competenze ?? [],
        equipaggiamento = equipaggiamento ?? [];

  factory Personaggio.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    return Personaggio(
      nome: data?['nome'],
      utenteId: data?['utenteId'],
      classe: data?['classe'],
      razza: data?['razza'],
      campagna: data?['campagna'],
      competenze: List<String>.from(data?['competenze'] ?? []),
      equipaggiamento: List<String>.from(data?['equipaggiamento'] ?? []),
      stato: data?['stato'],
      vitaMax: data?['vitaMax'],
      vita: data?['vita'],
      livello: data?['livello'],
      classeArmatura: data?['classeArmatura'],
      carisma: data?['carisma'],
      costituzione: data?['costituzione'],
      destrezza: data?['destrezza'],
      forza: data?['forza'],
      intelligenza: data?['intelligenza'],
      saggezza: data?['saggezza'],
      allineamento: data?['allineamento'],
      descrizione: data?['descrizione'],
      ideali: data?['ideali'],
      legami: data?['legami'],
      storia: data?['storia'],
      difetti: data?['difetti'],
      tratti: data?['tratti'],
    );
  }
}

