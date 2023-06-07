import 'package:flutter/services.dart';
import 'dart:convert';

class StringResources{
  static Map<String, dynamic>? _strings;

  //Metodo che carica le stringhe da 'strings.json' in maniera asincrona.
  static Future<void> loadString() async{
    String jsonString = await rootBundle.loadString('assets/strings.json');
    _strings = json.decode(jsonString);
  }

  //Metodo che restituisce una stringa corrispondente a una determinata chiave.
  static String getString(String key){
    /* Restituisce la stringa corrispondente alla chiave 'key' da '_strings', se presente.
    Altrimenti, restituisce una stringa vuota ('')
     */
    return _strings?[key] ?? '';
  }

}