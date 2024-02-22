import 'dart:io';

class Announcement {
  final int? id;
  final String title;
  final String name;
  final String lastName;
  final String description;
  final String location;
  final String? price;
  final File? file;
  final double? latitude;
  final double? longitude;
  final int? userId;
  final String imageUrl;

  Announcement({
    this.id,
    required this.title,
    required this.name,
    required this.lastName,
    required this.description,
    required this.location,
    this.price,
    this.file,
    this.latitude,
    this.longitude,
    this.userId,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'name': name,
      'lastName': lastName,
      'description': description,
      'location': location,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'image': file
    };
  }
}
