import 'package:flutter/material.dart';
import 'package:progetto_dd/pages/characters/background.dart';
import 'package:progetto_dd/pages/characters/info_classe_razza.dart';
import 'package:progetto_dd/pages/characters/inventario.dart';
import 'package:progetto_dd/pages/characters/statistiche.dart';
import 'magie.dart';

class VisualizzaPersonaggio extends StatefulWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  VisualizzaPersonaggio({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  @override
  _VisualizzaPersonaggioState createState() => _VisualizzaPersonaggioState();
}

class _VisualizzaPersonaggioState extends State<VisualizzaPersonaggio> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    // Aggiunge le schermate corrispondenti agli indici della navigazione inferiore alla lista _screens
    _screens.add(
      StatisticheScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
    _screens.add(
      InventarioScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
    _screens.add(
      MagieScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
    _screens.add(
      BackGroundScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
    _screens.add(
      InfoCRScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizza Personaggio'),
      ),
      body: _screens[_currentIndex], // Mostra la schermata corrispondente all'indice corrente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Imposta l'indice corrente per la navigazione inferiore
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambia l'indice corrente quando viene premuta una voce di navigazione
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/personaggio.png',
              width: 24,
              height: 24,
            ),
            label: 'Statistiche',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/zaino.png',
              width: 24,
              height: 24,
            ),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/mage_staff.png',
              width: 24,
              height: 24,
            ),
            label: 'Incantesimi',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/story.png',
              width: 24,
              height: 24,
            ),
            label: 'Background',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/crusader.png',
              width: 24,
              height: 24,
            ),
            label: 'Classe e Razza',
          ),
        ],
        selectedItemColor: Colors.black, // Imposta il colore del testo per l'elemento selezionato
      ),
    );
  }
}
