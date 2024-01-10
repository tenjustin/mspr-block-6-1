// custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('A\'rosa-je', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.green,
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/'); // Replace with your route names
          },
          child: Text('Accueil'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/announcements'); // Replace with your route names
          },
          child: Text('Annonce'),
        ),
        IconButton(
          icon: Icon(Icons.message, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed('/messages'); // Replace with your route names
          },
        ),
        IconButton(
          icon: Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed('/user'); // Replace with your route names
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
