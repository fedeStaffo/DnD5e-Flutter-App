import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final String? nome;
  final String? classe;
  final String? razza;

  CharacterCard({this.nome, this.classe, this.razza});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          nome ?? '',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Classe: ${classe ?? ''}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Razza: ${razza ?? ''}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

