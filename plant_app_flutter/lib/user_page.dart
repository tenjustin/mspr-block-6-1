// user_page.dart
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Reusable custom app bar
      body: SingleChildScrollView(
        child: Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0), // Adjust spacing as needed
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 52, // White border size
                child: CircleAvatar(
                  backgroundImage: NetworkImage('url_to_profile_picture'), // Replace with your image URL
                  radius: 50,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'Nom du compte',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(Icons.star, color: Colors.yellow, size: 30);
                }),
              ),
              SizedBox(height: 16.0),
              SectionBubble(title: 'Plantes gardées', content: 'Bernard\nParfaitement fiable je recommande'),
              SizedBox(height: 16.0),
              SectionBubble(title: 'Plantes à garder', content: 'Besoin de garde\nPetite description de l\'annonce'),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionBubble extends StatelessWidget {
  final String title;
  final String content;

  SectionBubble({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // Adjust width as necessary
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFF38E10E),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black54),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
