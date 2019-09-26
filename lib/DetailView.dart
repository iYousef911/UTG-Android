import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'main.dart';
import 'package:utg_flutter/Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'androidx.multidex.MultiDex';

const String AD_MOB_TEST_DEVICE = 'test_device_id - run ad then check device logs for value';
class DetailView extends StatelessWidget {
  final Game games;


  const DetailView({Key key, this.games}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-3298644446787962~3632605599");
    myBanner..load()..show();
    myInterstitial..load()..show();

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(games.gameName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Text(
            games.gameName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Text(
                "Release Date: ",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                games.gameDate,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
            ],
          ),
          InkWell(
            child: Text("${games.gameSite} Website",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () async {
              if (await canLaunch(games.gameSite)) {
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

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['UTG - Up To Game', 'Video game tracker'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-3298644446787962/9974652663",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-3298644446787962/3553548696",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);


