import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:countdown/countdown.dart';



class DetailView extends StatelessWidget {
  final Game games;

  const DetailView({Key key, this.games}) : super(key: key);



  main() {

    CountDown cd = CountDown(Duration(seconds : 10));
    var sub = cd.stream.listen(null);

    sub.onData((Duration d) {
      print(d);
    });

    sub.onDone(() {
      print("done");
    });

    /// the countdown will have 500ms delay
    Timer(Duration(milliseconds: 4000), () {
      sub.pause();
    });
    Timer(Duration(milliseconds: 4500), () {
      sub.resume();
    });

  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(games.gameName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: Image.network("https://ya-techno.com/gamesImage/${games.image}",
              ),
          ),

           ),
          Text(games.gameName, style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),),
          Text(games.gameDate, style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),),





          InkWell(
              child: Text("${games.gameSite} Website",style: TextStyle(

               decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () async{
                if(await canLaunch(games.gameSite)) {
                  await launch(games.gameSite);
                }

            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: YoutubePlayer(
              context: context,
              videoId: games.gameVideo,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                showVideoProgressIndicator: true,
              ),
              videoProgressIndicatorColor: Colors.amber,
            ),
          ),

        ],


      ),
    );
  }
}

