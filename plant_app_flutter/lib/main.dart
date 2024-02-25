import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app_flutter/providers/http_client_provider.dart';
import 'package:plant_app_flutter/user_page.dart';
import 'chat.dart';
import 'Messagerie.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'acceuil.dart';
import 'models/annoucement.dart';
import 'product_page.dart';
import 'annonce.dart';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/localhost.crt');
  SecurityContext securityContext = SecurityContext.defaultContext;
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

void main() async {
  HttpOverrides.global = ClientProvider();
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
        '/user': (context) => UserPage(),
        '/MessagingPage': (context) => MessagingPage(),
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
    LoginPage(),
    SignupPage(),
    MyHomePage(),
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
