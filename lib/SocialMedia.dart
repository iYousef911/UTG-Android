import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ReleasedView.dart';
import 'main.dart';

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
            DrawerHeader(
              child: Text(
                'UTG - Up To Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://ya-techno.com/backgroundImage/tableViewHeader3.jpg"),
                  fit: BoxFit.cover,
                ),
                color: Color.fromRGBO(58, 66, 86, 1.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.gamepad),
              title: Text(
                "Upcoming Game",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                "Released Game",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReleasedView(),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: ListTile(
                leading: Icon(Icons.alternate_email),
                title: Text(
                  "Social Accounts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SocialMedia(),
                  ),
                );
              },
              ),
            ),
          ])),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Social Accounts"),
      ),
      body: SocialMediaIcons(),

    );
  }
}

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return new GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: FloatingActionButton(
                onPressed: () async {
                   if (await canLaunch("https://twitter.com/yad3v")) {
                await launch("https://twitter.com/yad3v");
              }
                },
              )
            );
          }),
        );
  }
}