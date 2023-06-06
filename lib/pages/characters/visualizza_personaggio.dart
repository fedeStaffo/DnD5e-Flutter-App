import 'package:flutter/material.dart';
import 'package:progetto_dd/pages/characters/background.dart';
import 'package:progetto_dd/pages/characters/inventario.dart';
import 'package:progetto_dd/pages/characters/statistiche.dart';

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
    _screens.add(
      StatisticheScreen(
        nome: widget.nome,
        classe: widget.classe,
        razza: widget.razza,
        utenteId: widget.utenteId,
      ),
    );
    _screens.add(
      InventrioScreen(
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
    // Aggiungi qui gli altri screen alla lista _screens se necessario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizza Personaggio'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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