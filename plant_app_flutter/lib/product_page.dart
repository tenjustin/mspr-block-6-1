// product_page.dart
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define your TextStyle, BoxDecoration, and other reusable properties here
    var titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    var contentStyle = TextStyle(fontSize: 18);
    var buttonStyle = ElevatedButton.styleFrom(primary: Colors.green);

    return Scaffold(
      appBar: CustomAppBar(), // Reusable custom app bar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              'url_to_product_image', // Replace with your image URL
              height: 250, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage('url_to_user_image'), // Replace with your image URL
                    radius: 30,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('user9564882', style: titleStyle),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star_half, color: Colors.yellow, size: 20), // Half star for example
                          Text(' (2)', style: contentStyle),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    child: Text('Message'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('[Titre de l\'annonce]', style: titleStyle),
                  Text('[Localisation]', style: contentStyle),
                  Text('[Prix]', style: titleStyle),
                  SizedBox(height: 16.0),
                  Text('[Description]', style: contentStyle),
                  SizedBox(height: 16.0),
                  Text('[Habitudes du propriétaire]', style: contentStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
