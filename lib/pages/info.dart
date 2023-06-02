import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Programmatori',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Enrico Maria Sardellini',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  _launchUrl('www.github.com/Ems01');
                },
                child: const Text(
                  'https://github.com/Ems01',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Federico Staffolani',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  _launchUrl('www.github.com/fedeStaffo');
                },
                child: const Text(
                  'https://github.com/fedeStaffo',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Alessandro Renzi',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  _launchUrl('www.github.com/renzialex');
                },
                child: const Text(
                  'https://github.com/renzialex',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/info_image.webp',
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
