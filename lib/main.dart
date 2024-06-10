import 'package:flutter/material.dart';
import 'package:refugio_animales/globalInterfaces/login.dart';


void main() async{

  runApp(MaterialApp(
    home: MiWidget(),
  ));
}

class MiWidget extends StatefulWidget {
  @override
  _MiWidgetState createState() => _MiWidgetState();
}

class _MiWidgetState extends State<MiWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': ( _ ) => const login(),
      }
    );
  }
}








