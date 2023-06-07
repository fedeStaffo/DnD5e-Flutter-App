import 'package:cloud_firestore/cloud_firestore.dart';

class Personaggio {
  final String? nome; // Nome del personaggio
  final String? utenteId; // ID dell'utente proprietario del personaggio
  final String? classe; // Classe del personaggio
  final String? razza; // Razza del personaggio
  final String? campagna; // Campagna a cui il personaggio è associato
  final List<String>? competenze; // Lista delle competenze del personaggio
  final List<String>? equipaggiamento; // Lista dell'equipaggiamento del personaggio
  final String? stato; // Stato attuale del personaggio
  final int? vitaMax; // Vita massima del personaggio
  final int? vita; // Vita attuale del personaggio
  final int? livello; // Livello del personaggio
  final int? classeArmatura; // Classe armatura del personaggio
  final int? carisma; // Valore di carisma del personaggio
  final int? costituzione; // Valore di costituzione del personaggio
  final int? destrezza; // Valore di destrezza del personaggio
  final int? forza; // Valore di forza del personaggio
  final int? intelligenza; // Valore di intelligenza del personaggio
  final int? saggezza; // Valore di saggezza del personaggio
  final String? allineamento; // Allineamento del personaggio
  final String? descrizione; // Descrizione del personaggio
  final String? ideali; // Ideali del personaggio
  final String? legami; // Legami del personaggio
  final String? storia; // Storia del personaggio
  final String? difetti; // Difetti del personaggio
  final String? tratti; // Tratti del personaggio

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
  })  : competenze = competenze ?? [], // Se competenze è null, viene assegnata una lista vuota
        equipaggiamento = equipaggiamento ?? []; // Se equipaggiamento è null, viene assegnata una lista vuota

  // Factory method per creare un'istanza di Personaggio a partire da uno snapshot di Firestore
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
