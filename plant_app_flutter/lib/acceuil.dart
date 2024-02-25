import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_app_flutter/providers/http_client_provider.dart';
import 'package:plant_app_flutter/providers/token_provider.dart';
import 'package:plant_app_flutter/services/annonces_services.dart';
import 'models/annoucement.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'product_page.dart';
import 'addannouncementpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _LocationPageState();
}

class _LocationPageState extends State<MyHomePage> {
  String? _currentAddress;
  String? _currentVille;
  Position? _currentPosition;
  static ClientProvider clientProvider = ClientProvider();
  static TokenProvider tokenProvider = TokenProvider();
  static AnnonceServices annonceServices = AnnonceServices(clientProvider: clientProvider, tokenProvider: tokenProvider);
  MapController _mapController = MapController();


  void _navigateToHome() {
    final currentRoute = ModalRoute.of(context);
    if (currentRoute?.settings.name != '/') {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void initState()  {
    super.initState();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'La localisation est désactivé , activé')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'La localisation est désactivé')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      debugPrint("Error getting current position: $e");
    }

    if (position == null) {
      final shouldRequestPermission = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Permission"),
            content: Text("We need your location to provide accurate information. Please grant location permission."),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Grant"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Deny"),
              ),
            ],
          );
        },
      );

      if (shouldRequestPermission == true) {
        _handleLocationPermission();
      }
    } else {
      setState(() => _currentPosition = position);
      _moveMapCamera(_currentPosition!);
    }
  }

  void _moveMapCamera(Position position) {
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    _mapController.move(
      LatLng(position.latitude, position.longitude),
      15.0,
    );
  }

  Future<LatLng> _getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
    } catch (e) {
      print('Error converting address to coordinates: $e');
    }
    return LatLng(0.0, 0.0); // Retourne une position par défaut si la conversion échoue
  }


  Future<String> getCurrentVille() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    if (placemarks.isNotEmpty) {
      return placemarks[0].locality ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _mapController.move(_mapController.center, _mapController.zoom + 1);
            },
            child: Icon(Icons.zoom_in),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              _mapController.move(_mapController.center, _mapController.zoom - 1);
            },
            child: Icon(Icons.zoom_out),
          ),
        ],
      ),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.green.shade300],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      height: 300,
                      width: 500,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            center: LatLng(
                              _currentPosition?.latitude ?? 0.0,
                              _currentPosition?.longitude ?? 0.0,
                            ),
                            zoom: 15.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            FutureBuilder(future: getCurrentVille(),
                                builder: (context, AsyncSnapshot<String> ville){
                                  if (ville.connectionState == ConnectionState.active ||
                                      ville.connectionState == ConnectionState.waiting || ville.data == null) {
                                    return CircularProgressIndicator();
                                  }
                              return FutureBuilder(future: annonceServices.getHomeAnnonce(ville.data!),
                                  builder: (context, AsyncSnapshot<List<Announcement>> annonces){
                                    if (annonces.connectionState == ConnectionState.active ||
                                        annonces.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                        }
                                    return MarkerLayer(
                                      markers: [
                                        // Ajoutez d'abord le marqueur pour la position actuelle
                                        Marker(
                                          width: 80.0,
                                          height: 80.0,
                                          point: LatLng(
                                            _currentPosition?.latitude ?? 0.0,
                                            _currentPosition?.longitude ?? 0.0,
                                          ),
                                          child: const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                        ),
                                        // Parcourez maintenant les annonces et ajoutez des marqueurs pour chacune
                                        for (var announcement in annonces.data!)
                                          if (announcement.latitude != null && announcement.longitude != null)
                                            Marker(
                                              width: 80.0,
                                              height: 80.0,
                                              point: LatLng(
                                                // Convertissez la localisation de l'annonce en latitude et longitude
                                                announcement.latitude!,
                                                announcement.longitude!,
                                              ),
                                              // Utilisez InkWell pour détecter les clics sur le marqueur
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProductPage(
                                                        id: announcement.id,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.place,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                      ],
                                    );
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: const Text(
                        "ANNONCE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAnnouncementPage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.greenAccent[400]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Déposer une annonce",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Utilisation d'un GridView pour afficher les annonces côte à côte
                    Expanded(
                      child: FutureBuilder(future: annonceServices.getHomeAnnonce('Mountain View'),
                        builder: (context, AsyncSnapshot<List<Announcement>> annonces){
                          if(annonces.connectionState == ConnectionState.waiting){
                            return const CircularProgressIndicator();
                          }
                          return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Nombre de colonnes dans le GridView
                              crossAxisSpacing: 10.0, // Espacement horizontal entre les éléments
                              mainAxisSpacing: 10.0, // Espacement vertical entre les éléments
                            ),
                            itemCount: annonces.data!.length,
                            itemBuilder: (context, index) {
                              return _buildAnnouncementCard(annonces.data![index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAnnouncementCard(Announcement announcement) {
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
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "${announcement.name} ${announcement.lastName}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            announcement.description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      id: announcement.id,
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
              child: const Text(
                "Voir l'annonce",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
