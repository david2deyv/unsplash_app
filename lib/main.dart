import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_app/provider/unsplash_provider.dart';
import 'package:unsplash_app/screen/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash App',
      home: ChangeNotifierProvider<UnsplashProvider>.value(
        value: UnsplashProvider(),
        child: HomePage(),
      ),
    );
  }
}
