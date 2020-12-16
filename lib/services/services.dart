import 'dart:developer';

import 'package:http/http.dart' as http;

import '../json/cards.dart';
import 'dart:convert';

class Services {
  
   static const String url =
      'https://api.unsplash.com/photos?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

  static Future<UnsplashCardsResponse> getCards({int perPage = 30, int page = 1}) async {
    try {
      final response = await http.get('$url&per_page=$perPage&page=$page');
      if (response.statusCode == 200) {
        final List<UnsplashCard> cards = cardsFromJson(response.body);
        final int totalCount = int.tryParse(response.headers['x-total']);
        return UnsplashCardsResponse(totalCount, cards);
      } else {
        return Future.error(
          Exception(
            'Something went wrong. Response code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
