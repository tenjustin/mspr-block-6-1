import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    color: Colors.lightGreen[500],
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildTextField('Nom'),
                        SizedBox(height: 16.0),
                        buildTextField('Prénom'),
                        SizedBox(height: 16.0),
                        buildTextField('Pseudo'),
                        SizedBox(height: 16.0),
                        buildTextField('Mot de passe', obscureText: true),
                        SizedBox(height: 16.0),
                        buildTextField('Confirmation mot de passe', obscureText: true),
                        SizedBox(height: 16.0),
                        buildTextField('Adresse e-mail'),
                        SizedBox(height: 16.0),
                        buildTextField('Sexe'),
                        SizedBox(height: 16.0),
                        buildTextField('Date de naissance'),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Ajoutez ici la logique d'inscription
                          },
                          child: Text(
                            'S\'inscrire',
                            style: TextStyle(
                              color: Colors.lightGreen[500],
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, {bool obscureText = false}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}

