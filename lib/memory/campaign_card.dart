import 'package:flutter/material.dart';
import '../pages/campaigns/drawer/campaign_screen.dart';
import 'campaign.dart';

class CampaignCard extends StatelessWidget {
  final String? nome; // Nome della campagna
  final String? masterId; // ID del master della campagna
  final String? masterNome; // Nome del master della campagna

  CampaignCard({
    this.nome,
    this.masterId,
    this.masterNome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell( // Aggiunta di InkWell come genitore per renderlo cliccabile
        onTap: () {
          // Azione da eseguire al clic sulla campagna
          _navigateToCampaign(context);
        },
        child: ListTile(
          title: Text(
            nome ?? '', // Visualizza il nome della campagna, se presente
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Master: ${masterNome ?? ''}', // Visualizza il nome del master della campagna, se presente
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
