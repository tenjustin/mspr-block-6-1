import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:plant_app_flutter/annoucement.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:permission_handler/permission_handler.dart';

class AddAnnouncementPage extends StatefulWidget {
  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}


class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

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


  void _updateLocationController(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        _locationController.text = placemarks[0].locality ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition().then((position) {
      if (position != null) {
        _updateLocationController(position);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une annonce'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Localisation'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Prix'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                _image != null
                    ? Image.file(_image!, height: 100)
                    : Text('Aucune image sélectionnée'),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: getImageFromCamera,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Prendre une photo'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: getImageFromGallery,
                  icon: Icon(Icons.photo_library),
                  label: Text('Galerie'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _getCurrentPosition().then((position) {
                      if (position != null) {
                        _updateLocationController(position);
                        Announcement newAnnouncement = Announcement(
                          title: _titleController.text,
                          name: 'John', // Exemple de nom
                          lastName: 'Doe', // Exemple de nom de famille
                          description: _descriptionController.text,
                          location: _locationController.text,
                          price: _priceController.text.isNotEmpty ? _priceController.text : null,
                          latitude: position.latitude, // Utilisation de la latitude de la position actuelle
                          longitude: position.longitude, // Utilisation de la longitude de la position actuelle
                        );

                        print('Nouvelle annonce: $newAnnouncement');

                        Navigator.pop(context);
                      } else {
                        // Gestion de l'absence de permission ou d'accès à la localisation
                      }
                    });
                  },
                  child: Text('Ajouter'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Ajustez la hauteur du bouton
                    minimumSize: Size(double.infinity, 0), // Étirez le bouton pour remplir l'espace disponible
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


