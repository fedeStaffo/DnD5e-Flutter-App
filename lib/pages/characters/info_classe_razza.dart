import 'package:flutter/material.dart';
import '../../utils/string_resources.dart';

class InfoCRScreen extends StatefulWidget {
  final String? nome;
  final String? classe;
  final String? razza;
  final String? utenteId;

  InfoCRScreen({
    this.nome,
    this.classe,
    this.razza,
    this.utenteId,
  });

  @override
  _InfoCRScreenState createState() => _InfoCRScreenState();
}

class _InfoCRScreenState extends State<InfoCRScreen> {
  String? infoClasse; // Informazioni sulla classe
  String? infoRazza; // Informazioni sulla razza

  @override
  void initState() {
    super.initState();
    loadStringResources(); // Carica le risorse di stringa
  }

  Future<void> loadStringResources() async {
    await StringResources.loadString(); // Carica le risorse di stringa asincronamente
    setState(() {
      // Aggiorna lo stato con le informazioni sulla classe e sulla razza
      infoClasse = StringResources.getString('info_${widget.classe?.toLowerCase()}');
      infoRazza = StringResources.getString('info_${widget.razza?.toLowerCase()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Informazioni sulla classe:', // Titolo delle informazioni sulla classe
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          const SizedBox(height: 10),
          Text(
            infoClasse ?? '', // Mostra le informazioni sulla classe
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Text(
            'Informazioni sulla razza:', // Titolo delle informazioni sulla razza
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          const SizedBox(height: 10),
          Text(
            infoRazza ?? '', // Mostra le informazioni sulla razza
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
