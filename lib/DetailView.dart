import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';




class DetailView extends StatelessWidget {
  final Game games;


  const DetailView({Key key, this.games}) : super(key: key);

  @override
  

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;
        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(games.gameName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Container(
            alignment: Alignment(0,1),
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
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: "https://ya-techno.com/gamesImage/${games.image}",
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






        ],



      ),
    );
  }
}


