import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app_flutter/models/user.dart';
import 'package:plant_app_flutter/providers/identity_provider.dart';
import 'package:plant_app_flutter/providers/token_provider.dart';
import 'package:plant_app_flutter/providers/http_client_provider.dart';

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
  LoginPage({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TokenProvider tokenProvider = TokenProvider();
  IdentityProvider identityProvider = IdentityProvider();
  ClientProvider httpProvider = ClientProvider();

  tryAuth(BuildContext context) async {
    String apiUrl = 'https://10.0.2.2:32770/api/User/loguser';
    String username = usernameController.text;
    String password = passwordController.text;

    Uri uri = Uri.parse(apiUrl);
    String requestBody = jsonEncode({'identifiant': username, 'password': password});

    var client = httpProvider.createClient();

    final request = http.Request('POST', uri);

    try{
      request.headers['Content-Type'] = 'application/json';
      request.body = requestBody;
      final response = await client.send(request);

      if(response.statusCode == HttpStatus.ok){
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseData = json.decode(responseBody);

        String token = responseData["token"];
        User user = User(
          id: responseData["id"],
          pseudo: responseData["pseudo"],
          nom: responseData["nom"],
          prenom: responseData["prenom"],
          email: responseData["email"]
        );
        identityProvider.storeCredentials(user);
        tokenProvider.storeToken(token);
        Navigator.pushNamed(context, "/home");

      }
      else{
        throw Error();
      }
    }catch (error){
        print(error);
    }finally{
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  color: Colors.lightGreen[500],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Container(
                width: 300.0,
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
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nom d\'utilisateur',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          controller: usernameController,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                          controller: passwordController,
                        ),
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {

                          tryAuth(context);
                        },
                        child: Text(
                          'Se connecter',
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
    );
  }
}