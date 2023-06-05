import 'package:flutter/material.dart';
import '../pages/campaigns/drawer/campaign_screen.dart';
import 'campaign.dart';

class CampaignCard extends StatelessWidget {
  final String? nome;
  final String? masterId;
  final String? masterNome;

  CampaignCard({
    this.nome,
    this.masterId,
    this.masterNome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell( // Aggiunta di InkWell come genitore
        onTap: () {
          // Azione da eseguire al clic sulla campagna
          _navigateToCampaign(context);
        },
        child: ListTile(
          title: Text(
            nome ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Master: ${masterNome ?? ''}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCampaign(BuildContext context) {
    // Creazione dell'oggetto Campagna con i dati necessari
    final campagna = Campagna(
      nome: nome,
      masterId: masterId,
      masterNome: masterNome,
      password: '',
      partecipanti: [],
    );

    // Passaggio alla schermata della campagna con i dati salvati
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CampaignScreen(campagna: campagna),
      ),
    );
  }
}