class Sessione {
  final String? numero; // Numero della sessione
  final String? giorno; // Giorno in cui si tiene la sessione
  final String? descrizione; // Descrizione della sessione
  final String? campagna; // Campagna a cui appartiene la sessione
  final String? master; // Master che guida la sessione

  Sessione({
    this.numero,
    this.giorno,
    this.descrizione,
    this.campagna,
    this.master,
  });
}
