import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../memory/character.dart';
import 'modifica_stats.dart';
import 'home_character.dart';

class StatisticheScreen extends StatelessWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  StatisticheScreen({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  Future<void> eliminaPersonaggio(BuildContext context) async {
    // Elimina il personaggio corrispondente dai dati Firestore
    await FirebaseFirestore.instance
        .collection('personaggi')
        .where('nome', isEqualTo: nome)
        .where('classe', isEqualTo: classe)
        .where('razza', isEqualTo: razza)
        .where('utenteId', isEqualTo: utenteId)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot personaggio = snapshot.docs.first;
        personaggio.reference.delete();

        // Torna alla schermata HomeCharacter dopo l'eliminazione
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeCharacter(userId: utenteId!,),
          ),
        );
      }
    }).catchError((error) {
      // Mostra un dialog in caso di errore durante l'eliminazione
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Errore'),
            content: Text('Si è verificato un errore durante l\'eliminazione del personaggio.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Chiudi dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('personaggi')
          .where('nome', isEqualTo: nome)
          .where('classe', isEqualTo: classe)
          .where('razza', isEqualTo: razza)
          .where('utenteId', isEqualTo: utenteId)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Visualizza un indicatore di caricamento durante il recupero dei dati
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Gestisci gli errori di recupero dei dati
          return Center(
            child: Text(
              'Errore: ${snapshot.error}',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          // Se non sono disponibili dati o il personaggio non è stato trovato
          return const Center(
            child: Text(
              'Personaggio non trovato',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          // Se il personaggio è stato trovato, visualizza i dati
          final personaggio = Personaggio.fromSnapshot(
            snapshot.data!.docs.first, // Utilizzo il primo documento nella lista
          );

          int? bonusComp;
          int? bonusCaster;

          bonusComp = getBonusComp(personaggio.livello ?? 0);
          if (personaggio.classe == 'Bardo') {
            bonusCaster = getModificatore(personaggio.carisma ?? 0);
          } else {
            bonusCaster = getModificatore(personaggio.intelligenza ?? 0);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome: ${personaggio.nome ?? ''}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Classe: ${personaggio.classe ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Razza: ${personaggio.razza ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Campagna: ${personaggio.campagna ?? ''}\n',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Competenze: ${personaggio.competenze?.join(', ') ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Stato: ${personaggio.stato ?? ''}\n',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Vita Massima: ${personaggio.vitaMax ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Vita: ${personaggio.vita ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Livello: ${personaggio.livello ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Classe Armatura: ${personaggio.classeArmatura ?? ''}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modificatore Forza: ${personaggio.forza != null ? '${personaggio.forza} (${getModificatore(personaggio.forza!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore Destrezza: ${personaggio.destrezza != null ? '${personaggio.destrezza} (${getModificatore(personaggio.destrezza!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore Costituzione: ${personaggio.costituzione != null ? '${personaggio.costituzione} (${getModificatore(personaggio.costituzione!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore Intelligenza: ${personaggio.intelligenza != null ? '${personaggio.intelligenza} (${getModificatore(personaggio.intelligenza!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore Saggezza: ${personaggio.saggezza != null ? '${personaggio.saggezza} (${getModificatore(personaggio.saggezza!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore Carisma: ${personaggio.carisma != null ? '${personaggio.carisma} (${getModificatore(personaggio.carisma!)})' : ''}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Modificatore CD: ${getCD(bonusComp, bonusCaster)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Bonus Attacco: ${getBonusAttacco(bonusComp, bonusCaster)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModificaStatsFragment(
                              nome: nome,
                              classe: classe,
                              razza: razza,
                              utenteId: utenteId,
                            ),
                          ),
                        );
                      },
                      child: Text('Modifica'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (personaggio.campagna == null || personaggio.campagna == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Elimina personaggio'),
                                content: Text('Sei sicuro di voler eliminare il personaggio?'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          // Chiudi il dialog senza eliminare il personaggio
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Annulla'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Elimina il personaggio
                                          FirebaseFirestore.instance
                                              .collection('personaggi')
                                              .where('nome', isEqualTo: nome)
                                              .where('classe', isEqualTo: classe)
                                              .where('razza', isEqualTo: razza)
                                              .where('utenteId', isEqualTo: utenteId)
                                              .get()
                                              .then((snapshot) {
                                            if (snapshot.docs.isNotEmpty) {
                                              snapshot.docs.first.reference.delete().then((value) {
                                                // Torna alla pagina HomeCharacter dopo l'eliminazione
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context, '/homeCharacter', (route) => false);
                                              }).catchError((error) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Errore'),
                                                      content: Text('Si è verificato un errore durante l\'eliminazione del personaggio.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              });
                                            }
                                          });
                                        },
                                        child: Text('Elimina'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Errore'),
                                content: Text('Non puoi eliminare il personaggio perché è in una campagna.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Elimina'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}


int getModificatore(int n) {
  int m = 0;
  switch (n) {
    case 3:
      m = -4;
      break;
    case 4:
    case 5:
      m = -3;
      break;
    case 6:
    case 7:
      m = -2;
      break;
    case 8:
    case 9:
      m = -1;
      break;
    case 10:
    case 11:
      m = 0;
      break;
    case 12:
    case 13:
      m = 1;
      break;
    case 14:
    case 15:
      m = 2;
      break;
    case 16:
    case 17:
      m = 3;
      break;
    case 18:
    case 19:
      m = 4;
      break;
    case 20:
    case 21:
      m = 5;
      break;
    case 22:
      m = 6;
      break;
  }
  return m;
}

int getBonusComp(int livello) {
  int m = 0;
  switch (livello) {
    case 1:
    case 2:
    case 3:
    case 4:
      m = 2;
      break;
    case 5:
    case 6:
    case 7:
    case 8:
      m = 3;
      break;
    case 9:
    case 10:
    case 11:
    case 12:
      m = 4;
      break;
    case 13:
    case 14:
    case 15:
    case 16:
      m = 5;
      break;
    case 17:
    case 18:
    case 19:
    case 20:
      m = 6;
      break;
  }
  return m;
}

int getCD(int bonusComp, int bonusCaster) {
  return 8 + bonusComp + bonusCaster;
}

int getBonusAttacco(int bonusComp, int bonusCaster) {
  return bonusComp + bonusCaster;
}
