import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:utg_flutter/Models/Game.dart';

import 'DetailView.dart';
import 'ReleasedView.dart';
import 'main.dart';


Future<List<Game>> fetchGames(http.Client client) async {
  final response =
  await client.get('https://ya-techno.com/gameApp/gameDataNow.php');

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseGames, response.body);
}

// A function that will convert a response body into a List<Photo>
List<Game> parseGames(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Game>((json) => Game.fromJson(json)).toList();
}

class ReleasedView extends StatelessWidget {



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
                  child: Text('UTG - Up To Game', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(50, 66, 80, 1.0),
                  ),
                ),
                ListTile(
                  title: Text("Upcoming Game", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),),
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
                  title: Text("Released Game", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReleasedView(),
                      ),
                    );
                  },
                ),
              ])
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Released Games"),
      ),


      body: FutureBuilder<List<Game>>(
        future: fetchGames(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GameList(games: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class GameList extends StatelessWidget {
  final List<Game> games;

  GameList({Key key, this.games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: new ListView.builder(
          itemCount: games == null ? 0 : games.length,
          itemBuilder:(BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailView(games: games[index]),
                  ),
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.black38),
                  borderRadius: const BorderRadius.all(const Radius.circular(8)),

                ),
                margin: const EdgeInsets.all(4),

                child: Column(



                  children: <Widget>[
                    Image.network("https://ya-techno.com/gamesImage/${games[index].image}"),


//                    Padding(
//                      padding: const EdgeInsets.all(0.0),
//                      child: ClipRRect(
//                        borderRadius: new BorderRadius.circular(8.0),
//                        child: Image.network("https://ya-techno.com/gamesImage/${games[index].image}",
//                        ),
//
//                      ),
//
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Text(games[index].gameName,
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 20
//                        ),
//                      ),
//
//                    )


                  ],
                ),

              ),

            );




          }


      ),
    );
  }
}


