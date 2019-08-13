import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter_youtube/flutter_youtube.dart';


class DetailView extends StatelessWidget {
  final Game games;


  const DetailView({Key key, this.games}) : super(key: key);

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
              child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: "https://ya-techno.com/gamesImage/${games.image}",
              ),
          ),

           ),
          Text(games.gameName, style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),),
          Text("Release Date: " + games.gameDate,
            style: TextStyle(
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
          
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: YoutubePlayer(
//              context: context,
//              videoId: games.gameVideo,
//              flags: YoutubePlayerFlags(
//                autoPlay: false,
//                showVideoProgressIndicator: true,
//              ),
//              videoProgressIndicatorColor: Colors.amber,
//            ),
//          ),
              // FlutterYoutube.playYoutubeVideoById(
              //   apiKey: "AIzaSyAoFA4MZSqtqKkxVbtiP4XORLzkZX5gEBM",
              //   videoId: games.gameVideo,
              //   autoPlay: false, //default falase
              //   fullScreen: false //default false
              // ),
              FlutterYoutube.playYoutubeVideoByUrl(
                apiKey: "AIzaSyADzf8sBxEHO7enNBYLwhtAqlKRpROPj6Q",
                videoUrl: "https://www.youtube.com/watch?v=-ICZM2CUe9k",

              ),



Container(
            alignment: Alignment(0.5, 1.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FacebookBannerAd(
                placementId: "365255217325571_668274580356965",
                bannerSize: BannerSize.STANDARD,
                listener: (result, value) {
                  switch (result) {
                    case BannerAdResult.ERROR:
                      print("Error: $value");
                      break;
                    case BannerAdResult.LOADED:
                      print("Loaded: $value");
                      break;
                    case BannerAdResult.CLICKED:
                      print("Clicked: $value");
                      break;
                    case BannerAdResult.LOGGING_IMPRESSION:
                      print("Logging Impression: $value");
                      break;
                  }
                },

              ),
              
            ),
            
            
            
          ),
      
        ],
      ),
    );
  }
}


