import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'product_page.dart';
import 'user_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // List of widgets to call on tab tap.
  final List<Widget> _widgetOptions = [
    ProductPage(),
    UserPage(),
    // Add more pages if you have them
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A\'rosa-je',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: CustomAppBar(), // This stays common across all pages
        body: IndexedStack( // This will preserve the state of each page
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'User',
            ),
            // Add more items for each page you have
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
