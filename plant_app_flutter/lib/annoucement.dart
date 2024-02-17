class Announcement {
  final String title;
  final String name;
  final String lastName;
  final String description;
  final String location;
  final String? price;

  Announcement({
    required this.title,
    required this.name,
    required this.lastName,
    required this.description,
    required this.location,
    this.price,
  });
}
