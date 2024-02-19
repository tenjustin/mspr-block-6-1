class Announcement {
  final String title;
  final String name;
  final String lastName;
  final String description;
  final String location;
  final String? price;
  double? latitude;
  double? longitude;

  Announcement({
    required this.title,
    required this.name,
    required this.lastName,
    required this.description,
    required this.location,
    this.price,
    required this.latitude,
    required this.longitude,
  });
}
