import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:plant_app_flutter/annoucement.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                      label: Text('Choisir dans la galerie'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent[400],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Announcement newAnnouncement = Announcement(
                          title: _titleController.text,
                          name: 'John', // Example name
                          lastName: 'Doe', // Example last name
                          description: _descriptionController.text,
                          location: _locationController.text,
                          price: _priceController.text.isNotEmpty
                              ? _priceController.text
                              : null,
                        );

                        print('New Announcement: $newAnnouncement');

                        Navigator.pop(context);
                      },
                      child: Text('Ajouter'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


