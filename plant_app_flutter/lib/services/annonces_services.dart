
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
    var client = await clientProvider.createClient();

    String url = 'https://10.0.2.2:32768/api/annonces/createannonce';
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

  Future<Announcement?> getAnnonce(int? id) async {
    String token = await tokenProvider.getToken();
    var client = await clientProvider.createClient();

    String url = 'https://10.0.2.2:32768/api/annonces/$id';
    Uri uri = Uri.parse(url);

    var request = http.Request('GET', uri);
    request.headers['Authorization'] = 'Bearer $token';
    try{
      final response = await client.send(request);
      if(response.statusCode == HttpStatus.ok){
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseData = json.decode(responseBody);
        Announcement annonce = Announcement(
          id: responseData['id'],
          title: responseData['title'],
          description: responseData['description'],
          location: responseData['location'],
          price: responseData['price'].toString(),
          latitude: responseData['latitude'],
          longitude: responseData['longitude'],
          userId: responseData['userId'],
          name: responseData['name'],
          lastName: responseData['lastName'],
          imageUrl: responseData['imageUrl']
        );

        return annonce;
      }
    }
    catch (e){
      print(e);
      return null;
    }
    return null;
  }

  Future<List<Announcement>> getHomeAnnonce(String location) async {
    String apiUrl = 'https://10.0.2.2:32768/api/annonces/homepage';
    String token = await tokenProvider.getToken();

    Uri uri = Uri.parse(apiUrl);
    String requestBody = json.encode(location);

    var client = await clientProvider.createClient();

    final request = http.Request('POST', uri);

    try{
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      request.body = requestBody;
      final response = await client.send(request);

      if(response.statusCode == HttpStatus.ok){
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseData = json.decode(responseBody);
        List<Announcement> announcements = [];
        for(var data in responseData){
          announcements.add(Announcement(
              title: data["title"],
              name: data["name"],
              lastName: data["lastName"],
              description: data["description"],
              location: data["location"],
              latitude: data["latitude"],
              longitude: data["longitude"],
              id: data["id"]
          ));
        }
        return announcements;
      }
      else{
        throw Error();
      }
    }catch (error){
      print(error.toString());
      return List.empty();
    }finally{
      client.close();
    }
  }

  Future<List<Announcement>> getAnnoncePage(String location) async {
    String apiUrl = 'https://10.0.2.2:32768/api/annonces/annonces';
    String token = await tokenProvider.getToken();

    Uri uri = Uri.parse(apiUrl);
    String requestBody = json.encode(location);

    var client = await clientProvider.createClient();

    final request = http.Request('POST', uri);

    try{
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';
      request.body = requestBody;
      final response = await client.send(request);

      if(response.statusCode == HttpStatus.ok){
        String responseBody = await response.stream.bytesToString();
        List<dynamic> responseData = json.decode(responseBody);
        List<Announcement> announcements = [];
        for(var data in responseData){
          announcements.add(Announcement(
              title: data["title"],
              name: data["name"],
              lastName: data["lastName"],
              description: data["description"],
              location: data["location"],
              latitude: data["latitude"],
              longitude: data["longitude"],
              id: data["id"]
          ));
        }
        return announcements;
      }
      else{
        throw Error();
      }
    }catch (error){
      print(error.toString());
      return List.empty();
    }finally{
      client.close();
    }
  }
}