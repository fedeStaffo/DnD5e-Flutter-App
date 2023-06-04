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

}
