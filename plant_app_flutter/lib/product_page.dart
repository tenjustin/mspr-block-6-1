import 'package:flutter/material.dart';
import 'package:plant_app_flutter/models/annoucement.dart';
import 'custom_app_bar.dart';
import 'chat.dart';

class ProductPage extends StatelessWidget {
  final Announcement announcement;
  final String ownerImage = 'url-to-image';
  final double ownerRating = 4.5;

  ProductPage({
    required this.announcement
});


  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    var contentStyle = TextStyle(fontSize: 18);
    var buttonStyle = ElevatedButton.styleFrom(primary: Colors.green);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              'url_to_product_image', // Replace with your image URL
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(ownerImage), // Use the owner's image URL
                    radius: 30,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(announcement.name, style: titleStyle),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star, color: Colors.yellow, size: 20),
                          Icon(Icons.star_half, color: Colors.yellow, size: 20),
                          Text(' ($ownerRating)', style: contentStyle),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => ChatPage(conversation:Conversation(
                            id: 1,
                            title: 'John Doe',
                            messages: [
                              Message(content: 'Salut, comment ça va ?', isMe: true),
                              Message(content: 'Ça va bien, merci ! Et toi ?', isMe: false),
                            ],
                          ),
                          ),
                          )
                      );
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
                  Text(announcement.title, style: titleStyle),
                  Text(announcement.location, style: contentStyle),
                  Text(announcement.price.toString(), style: titleStyle),
                  SizedBox(height: 16.0),
                  Text(announcement.description, style: contentStyle),
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