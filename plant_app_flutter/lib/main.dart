// Dans main.dart
import 'package:flutter/material.dart';
import 'custom_app_bar.dart'; // Importez CustomAppBar
import 'product_page.dart';
import 'user_page.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(),
    ProductPage(),
    UserPage(),
    // Ajoutez d'autres pages si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A\'rosa-je',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: _selectedIndex != 0 ? CustomAppBar() : null, // Conditionnel
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        // Le reste de votre Scaffold body
      ),
      routes: {
        '/home': (context) => _widgetOptions[0],
        '/product': (context) => _widgetOptions[1],
        '/user': (context) => _widgetOptions[2],
        // Définissez d'autres routes ici
      },
    );
  }
}
