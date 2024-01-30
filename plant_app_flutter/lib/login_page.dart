import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc pour la page
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Connexion',
                style: TextStyle(
                  color: Colors.lightGreen[500], // Texte en noir pour une meilleure lisibilité
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0, // Largeur du conteneur réduite
                decoration: BoxDecoration(
                  color: Colors.green[50], // Fond vert pour le conteneur
                  borderRadius: BorderRadius.circular(10.0), // Coins arrondis
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 0, // Pas d'ombre
                        color: Colors.white, // Fond blanc pour le champ de saisie
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Coins arrondis
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nom d\'utilisateur',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Card(
                        elevation: 0, // Pas d'ombre
                        color: Colors.white, // Fond blanc pour le champ de saisie
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Coins arrondis
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          // Ajoutez ici la logique de connexion
                        },
                        child: Text('Se connecter',
                          style: TextStyle(
                            color: Colors.lightGreen[500], // Texte en noir pour une meilleure lisibilité
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
    );
  }
}
