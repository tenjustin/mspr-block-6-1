import 'package:flutter/material.dart';
import 'package:plant_app_flutter/user_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'acceuil.dart';
import 'annoucement.dart';
import 'product_page.dart';
import 'annonce.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthenticationPage(),
        '/announcements': (context) => AnnoncePage(),
        '/home': (context) => MyHomePage(),
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        '/user': (context) => UserPage(), // Replace with your user page
        '/product': (context) => ProductPage(
          title: "title",
          location: "location",
          price: "price",
          description: "description",
          ownerName: "ownerName",
          ownerImage: "ownerImage",
          ownerRating: 4,
        ),
      },
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}
class _AuthenticationPageState extends State<AuthenticationPage> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    SignupPage(),
    LoginPage(),
    MyHomePage(),
    ProductPage(
      title: "title",
      location: "location",
      price: "price",
      description: "description",
      ownerName: "ownerName",
      ownerImage: "ownerImage",
      ownerRating: 4,
    )
  ];

  @override
  Widget build(BuildContext context) {
    Widget currentPage = Container(); // Default value or loading indicator

    if (_currentPageIndex >= 0 && _currentPageIndex < _pages.length) {
      currentPage = _pages[_currentPageIndex]!;
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Connexion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Inscription',
          ),
        ],
      ),
    );
  }
}

