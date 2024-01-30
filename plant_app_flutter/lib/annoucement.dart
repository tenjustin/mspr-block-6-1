class Announcement {
  final String title;
  final String name;
  final String lastName;
  final String description;
  final String location;
  final String? price; // Make price property optional

  Announcement({
    required this.title,
    required this.name,
    required this.lastName,
    required this.description,
    required this.location,
    this.price, // Make price property optional
  });
}
