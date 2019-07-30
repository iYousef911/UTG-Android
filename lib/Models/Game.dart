import 'dart:core';

class Game {

  final String gameName;
  final String image;

  Game({this.gameName, this.image});



  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameName: json['gameName'] as String,
      image: json['image'] as String,
    );
  }
}

