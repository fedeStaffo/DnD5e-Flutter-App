import 'package:progetto_dd/auth/auth.dart';
import 'package:progetto_dd/auth/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:progetto_dd/pages/home.dart';

class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}): super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return MyHomePage(title: 'Scheda D&D 5e');
        } else {
          return const LoginPage();
        }
      }
    );
  }
}