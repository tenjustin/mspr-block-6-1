import 'package:flutter/material.dart';
import 'models/annoucement.dart'; // Assurez-vous que le chemin d'importation est correct
import 'product_page.dart'; // Assurez-vous que cette page est correctement définie
import 'custom_app_bar.dart'; // Assurez-vous que ce widget est correctement défini

class AnnoncePage extends StatelessWidget {
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
                    title: "Toi",
                    location: announcement.location,
                    price: announcement.price ?? "N/A", // Fournissez une valeur par défaut si le prix est null
                    description: announcement.description,
                    ownerName: announcement.name,
                    ownerImage: 'url_to_owner_image', // Remplacez par l'URL de l'image du propriétaire
                    ownerRating: 4.5,  // Remplacez par la note du propriétaire
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
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (context, index) {
          // Passez context en tant que paramètre ici
          return _buildAnnouncementCard(context, ads[index]);
        },
      ),
    );
  }
}