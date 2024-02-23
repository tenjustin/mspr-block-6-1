
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class IdentityProvider{
  Future<void> storeCredentials(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id.toString());
    prefs.setString('pseudo', user.pseudo);
    prefs.setString('nom', user.nom);
    prefs.setString('prenom', user.prenom);
    prefs.setString('email', user.email);
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = int.parse(prefs.getString('id') ?? '0');
    var pseudo = prefs.getString('pseudo') ?? '';
    var nom = prefs.getString('nom') ?? '';
    var prenom = prefs.getString('prenom') ?? '';
    var email = prefs.getString('email') ?? '';

    return User(id: id, pseudo: pseudo, nom: nom, prenom: prenom, email: email);
    //return prefs.getString('jwt_token') ?? '';
  }
}