import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Container(
        color: Colors.blue.shade200,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Programmatori',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Enrico Maria Sardellini',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    'Federico Staffolani',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    'Alessandro Renzi',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/info_image.webp',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
