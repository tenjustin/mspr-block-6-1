
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:plant_app_flutter/models/annoucement.dart';
import 'package:plant_app_flutter/providers/token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';

import '../providers/http_client_provider.dart';

class AnnonceServices {
  final ClientProvider clientProvider;
  final TokenProvider tokenProvider;

  AnnonceServices({
    required this.clientProvider,
    required this.tokenProvider,
});

  createAnnonce(Announcement announcement, BuildContext context) async{
    String token = await tokenProvider.getToken();
    var client = clientProvider.createClient();

    String url = 'https://10.0.2.2:32770/api/annonces/createannonce';
    Uri uri = Uri.parse(url);

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['Title'] = announcement.title;
    request.fields['Name'] = announcement.name;
    request.fields['LastName'] = announcement.lastName;
    request.fields['Description'] = announcement.description;
    request.fields['Price'] = announcement.price ?? '';
    request.fields['UserId'] = announcement.userId?.toString() ?? '';
    request.fields['Latitude'] = announcement.latitude?.toString() ?? '';
    request.fields['Longitude'] = announcement.longitude?.toString() ?? '';
    request.fields['Location'] = announcement.location;
    if (announcement.file != null) {
      final file = await http.MultipartFile.fromPath('Image', announcement.file!.path);
      request.files.add(file);
    }

    try {
      final response = await client.send(request);
      if (response.statusCode == 200) {
        print('Requête réussie');
      } else {
        print('Échec de la requête avec le code ${response.statusCode}');
        print('Réponse du serveur: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      print('Erreur lors de l\'envoi de la requête : $error');
    } finally {
      client.close();
    }
  }
}