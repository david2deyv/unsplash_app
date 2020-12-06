import 'package:flutter/material.dart';
import 'package:unsplash_app/services/unsplash_image.dart';
import '../json/cards.dart';

class ImageDetailsPage extends StatelessWidget {
  final UnsplashCard card;

  ImageDetailsPage({@required this.card});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: card.toString(),
        child: UnsplashImage(url: card.urls.full),
      ),
    );
  }
}
