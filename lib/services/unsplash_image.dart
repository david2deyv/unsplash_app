import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UnsplashImage extends StatelessWidget {
  const UnsplashImage({@required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(
        color: Colors.white,
        width: double.infinity,
        height: 200,
        child: Align(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.grey[300]),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
