import 'dart:core';

class Game {

  final String gameName;
  final String image;
  final String gameDate;
  final String gameSite;
  final String gameVideo;

  Game({this.gameName, this.image, this.gameDate, this.gameSite, this.gameVideo});



  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameName: json['gameName'] as String,
      image: json['image'] as String,
      gameDate: json['gameDate'] as String,
      gameSite: json['gameSite'] as String,
      gameVideo: json['gameVideo'] as String,

    );
  }
}

