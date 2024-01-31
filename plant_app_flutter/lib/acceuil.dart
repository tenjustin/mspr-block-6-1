import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'annoucement.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'product_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _LocationPageState();
}

class _LocationPageState extends State<MyHomePage> {
  String? _currentAddress;
  Position? _currentPosition;

  MapController _mapController = MapController();


  void _navigateToHome() {
    final currentRoute = ModalRoute.of(context);
    if (currentRoute?.settings.name != '/') {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  List<Announcement> announcements = [
    Announcement(
      title: "Titre 1",
      name: "John",
      lastName: "Doe",
      description: "Description de l'annonce 1.",
      price: "10",
      location: "Béziers"
    ),
    Announcement(
      title: "Titre 2",
      name: "Jane",
      lastName: "Doe",
      description: "Description de l'annonce 2.",
      price: "16",
      location: "Montpellier"
    ),
  ];

  @override
  void initState() {
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
              'La localisation est désactivé , activé la')));
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
      // Position not available, request permission again
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
        _handleLocationPermission(); // Request permission again
      }
    } else {
      setState(() => _currentPosition = position);
      _moveMapCamera(_currentPosition!);
    }
  }

  void _moveMapCamera(Position position) {
    _mapController.move(
      LatLng(position.latitude, position.longitude),
      15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: 500,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
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
                              subdomains: ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(
                                    _currentPosition?.latitude ?? 0.0,
                                    _currentPosition?.longitude ?? 0.0,
                                  ),
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "ANNONCE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {

                          print("Déposer une annonce");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.greenAccent[400]),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "Déposer une annonce",
                          style: TextStyle(
                            color: Colors.black, // Set text color to black
                            fontSize: 20.0, // Set font size to 20.0
                            fontWeight: FontWeight.bold, // Optionally set font weight
                          ),
                        ),
                      ),
                    ),
                    // Utilisation d'un GridView pour afficher les annonces côte à côte
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Nombre de colonnes dans le GridView
                          crossAxisSpacing: 10.0, // Espacement horizontal entre les éléments
                          mainAxisSpacing: 10.0, // Espacement vertical entre les éléments
                        ),
                        itemCount: announcements.length,
                        itemBuilder: (context, index) {
                          return _buildAnnouncementCard(announcements[index]);
                        },
                      ),

                    ),
                    // Ajout du bouton "Déposer une annonce"

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
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      title: announcement.title,
                      location: announcement.location,
                      price: announcement.price ?? "N/A", // Provide a default value if price is null
                      description: announcement.description,
                      ownerName: announcement.name,
                      ownerImage: 'url_to_owner_image', // Replace with the owner's image URL
                      ownerRating: 4.5, // Replace with the owner's rating
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
          ),
        ],
      ),
    );
  }
}
