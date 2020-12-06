import 'dart:developer';

import 'package:http/http.dart' as http;

import '../json/cards.dart';

class Services {
  static const String url = 'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

  static Future<List<UnsplashCard>> getCards() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<UnsplashCard> listCards = cardsFromJson(response.body);
        log(listCards.toString());
        return listCards;
      } else {
        return List<UnsplashCard>();
      }
    } catch (e) {
      return List<UnsplashCard>();
    }
  }
}