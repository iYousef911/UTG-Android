import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'main.dart';
import 'package:utg_flutter/Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
          FacebookAds(),
          FacebookNativeAd(
            placementId: "365255217325571_668274580356965",
            adType: NativeAdType.NATIVE_BANNER_AD,
            bannerAdSize: NativeBannerAdSize.HEIGHT_100,
            width: double.infinity,
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            descriptionColor: Colors.white,
            buttonColor: Colors.deepPurple,
            buttonTitleColor: Colors.white,
            buttonBorderColor: Colors.white,
            listener: (result, value) {
              print("Native Ad: $result --> $value");
            },
          ),
        ],
      ),
    );
  }
}

class FacebookAds extends StatefulWidget {
  final Game game;

  const FacebookAds({Key key, this.game}) : super(key: key);

  @override
  _FacebookAdsState createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<FacebookAds> {
  Widget _currentAd = SizedBox(
    height: 0.0,
    width: 0.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _currentAd = FacebookBannerAd(
        placementId: "365255217325571_668274580356965",
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("bannerAd: $result --> $value");
        },
      );
    });
    FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.5, 1),
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
    );
  }
}
