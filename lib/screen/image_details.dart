import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:unsplash_app/services/unsplash_image.dart';

import '../json/cards.dart';

class ImageDetailsPage extends StatelessWidget {
  final UnsplashCard card;

  ImageDetailsPage({@required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Zoom to see more'),
      ),
      body: Hero(
        tag: card.toString(),
        child: PinchZoom(
          zoomedBackgroundColor: Colors.transparent,
          // I use regular image size here for fancy Hero animation.
          // I think it's unnecessary to show full image here, it's too heavy
          image: UnsplashImage(url: card.urls.regular),
        ),
      ),
    );
  }
}
