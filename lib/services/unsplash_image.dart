import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UnsplashImage extends StatelessWidget {
  const UnsplashImage({@required this.url, this.fit});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => Container(
        color: Colors.deepPurple[50],
        width: double.infinity,
        height: 200,
        child: Align(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
