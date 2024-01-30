import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.grey, // Use a grey placeholder box
                // If using a map plugin, replace this with the map widget
              ),
              child: Center(
                child: Text('Map Placeholder'), // Replace this with your map or an image of the map
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.green, // Background color for the announcement section
              child: Column(
                children: [
                  Text(
                    'Annonce',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnnouncementCard(
                        context,
                        'Bernard Dupont',
                        'Besoin de garde',
                        'J\'ai besoin d\'un garde plante pour pouvoir garder mes plantes',
                      ),
                      _buildAnnouncementCard(
                        context,
                        'Sandrine Rossa',
                        'Besoin de garde',
                        'J\'ai besoin d\'un garde plante pour pouvoir garder mes plantes',
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Spacing before the button
                  ElevatedButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    child: Text(
                      'Déposer une annonce',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, String name, String title, String description) {
    return Card(
      child: Column(
        children: [
          Text(name, style: Theme.of(context).textTheme.headline6),
          Text(title, style: Theme.of(context).textTheme.subtitle1),
          Text(description),
          TextButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            child: Text('Voir l\'annonce'),
          ),
        ],
      ),
    );
  }
}
