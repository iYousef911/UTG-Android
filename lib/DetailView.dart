import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'main.dart';
import 'Models/Game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class DetailView extends StatelessWidget {
  final Game games;
  

  const DetailView({Key key, this.games}) : super(key: key);

  
void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
    
        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            value["invalidated"] == true) {
         
          _loadRewardedVideoAd();
        }
      },
    );
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
          Container(
                height: 50,              
                // child: FacebookBannerAd(
                //       placementId: "365255217325571_668274580356965",
                //       adType: NativeAdType.NATIVE_BANNER_AD,
                //       width: double.infinity,
                //       height: 300,
                //       backgroundColor: Colors.blue,
                //       titleColor: Colors.white,
                //       descriptionColor: Colors.white,
                //       buttonColor: Colors.deepPurple,
                //       buttonTitleColor: Colors.white,
                //       buttonBorderColor: Colors.white,
                //       listener: (result, value) {
                //         print("Native Ad: $result --> $value");
                //       },
                //     ),
                 
            
            
            child: FacebookBannerAd(
                   placementId: "365255217325571_668274580356965", 
                   bannerSize: BannerSize.STANDARD,
                   keepAlive: true,

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
          Row(
            children: <Widget>[
              Spacer(),
              Text("Release Date: ",
                style: TextStyle(
                color: Colors.white24,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),),
              
              Text(games.gameDate, 
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
              child: Text("${games.gameSite} Website",style: TextStyle(

               decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () async{
                if(await canLaunch(games.gameSite)) {
                  await launch(games.gameSite);
                }
                    //          FacebookInterstitialAd.loadInterstitialAd(
                    //   placementId: "365255217325571_668275130356910",
                    //   listener: (result, value) {
                    //     if (result == InterstitialAdResult.LOADED)
                    //       FacebookInterstitialAd.showInterstitialAd(delay: 5000);
                    //   },
                    // );
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
 
         


                
                
              // FlutterYoutube.playYoutubeVideoById(
              //   apiKey: "AIzaSyAoFA4MZSqtqKkxVbtiP4XORLzkZX5gEBM",
              //   videoId: games.gameVideo,
              //   autoPlay: false, //default falase
              //   fullScreen: false //default false
              // ),
              // FlutterYoutube.playYoutubeVideoByUrl(
              //   apiKey: "AIzaSyADzf8sBxEHO7enNBYLwhtAqlKRpROPj6Q",
              //   videoUrl: "https://www.youtube.com/watch?v=-ICZM2CUe9k"              // ),
              


      
        ],
        
      ),
      
      
    );
    
  }
  
  
}class AdsPage extends StatefulWidget {
  @override
  AdsPageState createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  bool _isRewardedVideoComplete = false;

  /// All widget ads are stored in this variable. When a button is pressed, its
  /// respective ad widget is set to this variable and the view is rebuilt using
  /// setState().
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
      testingId: "35e92a63-8102-46a4-b0f5-4fd269e6a13c",
    );

    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "365255217325571_668275130356910",
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

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "365255217325571_668275130356910",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
          _isRewardedVideoComplete = true;
        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            value["invalidated"] == true) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Align(
            alignment: Alignment(0, -1.0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _getAllButtons(),
            ),
          ),
          fit: FlexFit.tight,
          flex: 2,
        ),
        Flexible(
          child: Align(
            alignment: Alignment(0, 1.0),
            child: _currentAd,
          ),
          fit: FlexFit.tight,
          flex: 3,
        )
      ],
    );
  }

  Widget _getAllButtons() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: <Widget>[
        _getRaisedButton(title: "Banner Ad", onPressed: _showBannerAd),
        _getRaisedButton(title: "Native Ad", onPressed: _showNativeAd),
        _getRaisedButton(title: "Native Banner Ad", onPressed: _showNativeBannerAd),
        _getRaisedButton(
            title: "Intestitial Ad", onPressed: _showInterstitialAd),
        _getRaisedButton(title: "Rewarded Ad", onPressed: _showRewardedAd),
        _getRaisedButton(title: "InStream Ad", onPressed: _showInStreamAd),
      ],
    );
  }

  Widget _getRaisedButton({String title, void Function() onPressed}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else
      print("Rewarded Ad not yet loaded!");
  }

  _showInStreamAd() {
    setState(() {
      _currentAd = FacebookInStreamVideoAd(
        height: 300,
        listener: (result, value) {
          print("In-Stream Ad: $result -->  $value");
          if (result == InStreamVideoAdResult.VIDEO_COMPLETE) {
            setState(() {
              _currentAd = SizedBox(
                height: 0,
                width: 0,
              );
            });
          }
        },
      );
    });
  }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = FacebookNativeAd(
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
          print("Native Banner Ad: $result --> $value");
        },
      );
    });
  }

  _showNativeAd() {
    setState(() {
      _currentAd = FacebookNativeAd(
        adType: NativeAdType.NATIVE_AD,
        width: double.infinity,
        height: 300,
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        descriptionColor: Colors.white,
        buttonColor: Colors.deepPurple,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.white,
        listener: (result, value) {
          print("Native Ad: $result --> $value");
        },
      );
    });
  }
}




