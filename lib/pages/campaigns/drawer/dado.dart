import 'package:flutter/material.dart';

class Dado extends StatelessWidget {
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
              Container(
                margin: EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Dado',
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Modificatore',
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d100'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[900],
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d20'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[500],
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d12'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d10'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen,
                        onPrimary: Colors.white,
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
                      onPressed: () {},
                      child: Text('d8'),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d6'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d4'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d3'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('d2'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF800000),
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('7'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('8'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('9'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('4'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('5'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('6'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('1'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('2'),
                      ),
                      SizedBox(width: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('3'),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('0'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}