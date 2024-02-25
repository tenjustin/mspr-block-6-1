import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_app_flutter/providers/http_client_provider.dart';
import 'package:plant_app_flutter/providers/token_provider.dart';
import 'package:plant_app_flutter/services/annonces_services.dart';
import 'models/annoucement.dart'; // Assurez-vous que le chemin d'importation est correct
import 'product_page.dart'; // Assurez-vous que cette page est correctement définie
import 'custom_app_bar.dart'; // Assurez-vous que ce widget est correctement défini

class AnnoncePage extends StatefulWidget {
  static ClientProvider clientProvider = ClientProvider();
  static TokenProvider tokenProvider = TokenProvider();
  static AnnonceServices annonceServices = AnnonceServices(clientProvider: clientProvider, tokenProvider: tokenProvider);

  @override
  State<AnnoncePage> createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  Position? _currentPosition;
  String? ville;

  final List<Announcement> ads = [
    Announcement(
      title: 'Besoin de garde',
      name: 'Nom du compte',
      lastName: '',
      description: "J'ai besoin d'un garde plante pour pouvoir garder mes plantes",
      location: 'Location example', // Remplacez par l'emplacement réel
      price: 'Price example', // Remplacez par le prix réel si disponible
      latitude: 0.0,
      longitude: 0.0,
    ),
    Announcement(
      title: 'ntm',
      name: 'Nom du ntm',
      lastName: 'ntm',
      description: "J'ai besoin d'un garde ntm pour pouvoir garder mes ntm",
      location: 'Location ntm', // Remplacez par l'emplacement réel
      price: 'Price ntm', // Remplacez par le prix réel si disponible
      latitude: 0.0,
      longitude: 0.0,
    ),
  ];

  Future<Position?> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCurrentVille() async {
    _currentPosition = await _getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    if (placemarks.isNotEmpty) {
      return placemarks[0].locality ?? '';
    }
    return '';
  }

  // Ajoutez le paramètre BuildContext à la méthode
  Widget _buildAnnouncementCard(BuildContext context, Announcement announcement) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent[400],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "${announcement.name} ${announcement.lastName}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            announcement.description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    id: announcement.id, // Remplacez par la note du propriétaire
                  ),
                ),
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Text(
              "Voir l'annonce",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Utilisez CustomAppBar ici
      body: FutureBuilder(
        future: getCurrentVille(),
        builder: (context, AsyncSnapshot<String> ville){
          if (ville.connectionState == ConnectionState.active ||
              ville.connectionState == ConnectionState.waiting || ville.data == null) {
            return CircularProgressIndicator();
          }
          return FutureBuilder(future: AnnoncePage.annonceServices.getAnnoncePage(ville.data!),
              builder: (context, AsyncSnapshot<List<Announcement>> annonces){
            if (annonces.connectionState == ConnectionState.active ||
                annonces.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: annonces.data!.length,
              itemBuilder: (context, index) {
                // Passez context en tant que paramètre ici
                return _buildAnnouncementCard(context, annonces.data![index]);
              },
            );
          });
        }
      )
    );
  }
}