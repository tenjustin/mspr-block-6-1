import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plant_app_flutter/models/annoucement.dart';
import 'package:plant_app_flutter/providers/http_client_provider.dart';
import 'package:plant_app_flutter/providers/token_provider.dart';
import 'package:plant_app_flutter/services/annonces_services.dart';
import 'custom_app_bar.dart';
import 'chat.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatelessWidget {
  late int? id;
  static ClientProvider clientProvider = ClientProvider();
  static TokenProvider tokenProvider = TokenProvider();
  static AnnonceServices annonceServices = AnnonceServices(clientProvider: clientProvider, tokenProvider: tokenProvider);
  final String ownerImage = 'url-to-image';
  final double ownerRating = 4.5;

  ProductPage({super.key,
    required this.id
});


  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    var contentStyle = TextStyle(fontSize: 18);
    var buttonStyle = ElevatedButton.styleFrom(primary: Colors.green);

    return FutureBuilder(future: annonceServices.getAnnonce(id),
        builder: (context, AsyncSnapshot<Announcement?> announcement){
      if(announcement.connectionState == ConnectionState.waiting){
        return const CircularProgressIndicator();
      }
          return Scaffold(
            appBar: CustomAppBar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FutureBuilder(
                  future: fetchImage(announcement.data!.imageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Erreur: ${snapshot.error}');
                      }
                      return Image.memory(snapshot.data!);
                    } else {
                      return CircularProgressIndicator();
                    }}),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(ownerImage), // Use the owner's image URL
                          radius: 30,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(announcement.data!.name, style: titleStyle),
                            subtitle: Row(
                              children: <Widget>[
                                Icon(Icons.star, color: Colors.yellow, size: 20),
                                Icon(Icons.star, color: Colors.yellow, size: 20),
                                Icon(Icons.star, color: Colors.yellow, size: 20),
                                Icon(Icons.star, color: Colors.yellow, size: 20),
                                Icon(Icons.star_half, color: Colors.yellow, size: 20),
                                Text(' ($ownerRating)', style: contentStyle),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text('Message'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(announcement.data!.title, style: titleStyle),
                        Text(announcement.data!.location, style: contentStyle),
                        Text(announcement.data!.price.toString(), style: titleStyle),
                        SizedBox(height: 16.0),
                        Text(announcement.data!.description, style: contentStyle),
                        SizedBox(height: 16.0),
                        Text('[Habitudes du propriétaire]', style: contentStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    }
  Future<Uint8List> fetchImage(String? imageUrl) async {
    var client = await clientProvider.createClient();
    final request = http.Request('GET', Uri.parse(imageUrl!));
    var response = await client.send(request);
    if (response.statusCode == 200) {
      return response.stream.toBytes();
    } else {
      throw Exception('Impossible de charger l\'image');
    }
  }
}