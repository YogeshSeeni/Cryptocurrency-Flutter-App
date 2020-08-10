import 'package:crypto_app/views/bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency App',
      color: Colors.black,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        accentColor: Colors.grey,
      ),
      darkTheme: ThemeData.dark(),
      home: BottomNavbar(),
    );
  }
}

