import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';


class Dado extends StatefulWidget {
  @override
  _DadoState createState() => _DadoState();
}

class _DadoState extends State<Dado> {
  String diceResult = '';
  String modificatoreResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: diceResult.isEmpty ? 'Dado' : diceResult,
                          ),
                          initialValue: diceResult,
                          onChanged: (value) {
                            setState(() {
                              diceResult = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (diceResult.isNotEmpty) {
                          final plusIndex = diceResult.lastIndexOf('+');
                          if (plusIndex >= 0) {
                            diceResult = diceResult.substring(0, plusIndex).trim();
                          } else {
                            diceResult = '';
                          }
                        }
                      });
                    },
                    icon: Icon(Icons.backspace),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: modificatoreResult.isEmpty ? 'Modificatore' : modificatoreResult,
                          ),
                          initialValue: modificatoreResult,
                          onChanged: (value) {
                            setState(() {
                              modificatoreResult = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (modificatoreResult.isNotEmpty) {
                          modificatoreResult = modificatoreResult.substring(0, modificatoreResult.length - 1);
                        }
                      });
                    },
                    icon: Icon(Icons.backspace),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd100 ';
                          } else {
                            diceResult += ' + d100';
                          }
                        });
                      },
                      child: Text('d100'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd20 ';
                          } else {
                            diceResult += ' + d20';
                          }
                        });
                      },
                      child: Text('d20'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[500],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd12 ';
                          } else {
                            diceResult += ' + d12';
                          }
                        });
                      },
                      child: Text('d12'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd10 ';
                          } else {
                            diceResult += ' + d10';
                          }
                        });
                      },
                      child: Text('d10'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd8 ';
                          } else {
                            diceResult += ' + d8';
                          }
                        });
                      },
                      child: Text('d8'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd6 ';
                          } else {
                            diceResult += ' + d6';
                          }
                        });
                      },
                      child: Text('d6'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd4 ';
                          } else {
                            diceResult += ' + d4';
                          }
                        });
                      },
                      child: Text('d4'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd3 ';
                          } else {
                            diceResult += ' + d3';
                          }
                        });
                      },
                      child: Text('d3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lime,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (diceResult.isEmpty) {
                            diceResult = 'd2 ';
                          } else {
                            diceResult += ' + d2';
                          }
                        });
                      },
                      child: Text('d2'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF800000),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '7';
                          });
                        },
                        child: Text('7'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '8';
                          });
                        },
                        child: Text('8'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '9';
                          });
                        },
                        child: Text('9'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '4';
                          });
                        },
                        child: Text('4'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '5';
                          });
                        },
                        child: Text('5'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '6';
                          });
                        },
                        child: Text('6'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '1';
                          });
                        },
                        child: Text('1'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '2';
                          });
                        },
                        child: Text('2'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '3';
                          });
                        },
                        child: Text('3'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '-';
                          });
                        },
                        child: Text("-"),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '0';
                          });
                        },
                        child: Text('0'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            modificatoreResult += '+';
                          });
                        },
                        child: Text('+'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: rollDice,
                child: Text('Roll'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void rollDice() {
    // Controlla se sia la variabile diceResult che modificatoreResult sono vuote
    if (diceResult.isEmpty && modificatoreResult.isEmpty) {
      return; // Non fare nulla se entrambe le variabili sono vuote
    }

    // Controlla se diceResult è vuota e modificatoreResult non è vuota
    if (diceResult.isEmpty && modificatoreResult.isNotEmpty) {
      // Controlla se modificatoreResult termina con "+" o "-"
      if (modificatoreResult.endsWith('+') || modificatoreResult.endsWith('-')) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('L\'espressione matematica è incompleta.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        try {
          final result = valutaEspressione(modificatoreResult).toInt();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Risultato'),
                content: Text('Il risultato dell\'espressione è $result'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } catch (e) {
          print('Errore nella valutazione dell\'espressione: $e');
        }
      }
    }

    // Controlla se diceResult non è vuota e modificatoreResult è vuota
    if (diceResult.isNotEmpty && modificatoreResult.isEmpty) {
      List<int> individualRolls = getIndividualDiceRolls(diceResult);
      int sum = individualRolls.reduce((value, element) => value + element);

      String individualRollsString = individualRolls
          .map((roll) => '[$roll]')
          .join(' + ');

      // Mostra il risultato dei lanci dei dadi individuali se è stato lanciato solo un dado
      if (individualRolls.length == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Risultato'),
              content: Text("$sum"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Mostra il risultato dei lanci dei dadi individuali e la somma totale se sono stati lanciati più dadi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Risultato'),
              content: Text("Somma lanci: $sum\n\n$diceResult : $individualRollsString"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    // Controlla se sia diceResult che modificatoreResult non sono vuote
    if (diceResult.isNotEmpty && modificatoreResult.isNotEmpty) {
      List<int> individualRolls = getIndividualDiceRolls(diceResult);
      int sum = individualRolls.reduce((value, element) => value + element);

      String individualRollsString = individualRolls
          .map((roll) => '[$roll]')
          .join(' + ');

      // Controlla se modificatoreResult termina con "+" o "-"
      if (modificatoreResult.endsWith('+') || modificatoreResult.endsWith('-')) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Errore'),
              content: Text('L\'espressione matematica è incompleta.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        final result = valutaEspressione(modificatoreResult).toInt();
        int sumfinale = sum + result;

        // Mostra il risultato dei lanci dei dadi individuali, la somma totale e il modificatore
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Risultato'),
              content: Text('Totale: $sumfinale\n\n$diceResult : $individualRollsString\n\nModificatore: $result'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  double valutaEspressione(String expression) {
    // Crea un'istanza del parser
    final parser = Parser();

    // Crea un'istanza del contesto per le variabili
    final context = ContextModel();

    // Parsa l'espressione usando il parser
    final exp = parser.parse(expression);

    // Valuta l'espressione usando il contesto e ottieni il risultato valutato
    final evaluated = exp.evaluate(EvaluationType.REAL, context);

    // Converte il risultato in formato double e restituisce il valore
    return double.parse(evaluated.toString());
  }


  List<int> getIndividualDiceRolls(String diceExpression) {
    // Crea una lista per memorizzare i singoli lanci dei dadi
    List<int> individualRolls = [];

    // Crea un'espressione regolare per trovare corrispondenze con il pattern 'd(\d+)'
    RegExp regExp = RegExp(r'd(\d+)');

    // Trova tutte le corrispondenze dell'espressione regolare nella stringa diceExpression
    Iterable<Match> matches = regExp.allMatches(diceExpression);

    // Itera su tutte le corrispondenze trovate
    for (Match match in matches) {
      // Ottieni il numero di facce del dado dalla corrispondenza e convertilo in intero
      int numFaces = int.parse(match.group(1)!);

      // Esegui il lancio del dado con il numero di facce specificato
      int roll = rollDiceWithFaces(numFaces);

      // Aggiungi il risultato del lancio alla lista dei singoli lanci
      individualRolls.add(roll);
    }

    // Restituisci la lista dei singoli lanci dei dadi
    return individualRolls;
  }


  int rollDiceWithFaces(int numFaces) {
    // Crea una nuova istanza della classe Random
    Random random = Random();

    // Genera un numero casuale compreso tra 0 (incluso) e numFaces (escluso)
    // Aggiunge 1 al risultato per ottenere un numero compreso tra 1 e numFaces (inclusi)
    return random.nextInt(numFaces) + 1;
  }

}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final Function(String) onChanged;

  // Costruttore della classe MyTextFormField
  const MyTextFormField({
    Key? key,
    required this.hintText,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Restituisce un TextFormField personalizzato
    return TextFormField(
      // Configura la decorazione del campo di testo
      decoration: InputDecoration(
        hintText: hintText,
      ),
      // Imposta il valore iniziale del campo di testo
      initialValue: initialValue,
      // Definisce l'azione da eseguire quando il valore del campo di testo cambia
      onChanged: onChanged,
      // Imposta la tastiera virtuale per accettare solo numeri, inclusi i decimali e i segni
      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
      // Applica una formattazione per consentire solo input numerici
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
    );
  }
}


