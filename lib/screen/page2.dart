import 'package:flutter/material.dart';
import '../json/cards.dart';

class Page2 extends StatelessWidget {

  final Cards full;
  Page2({this.full});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Image'),
        centerTitle: true,
      ),
      body: Material(
        child: Image(
        image: NetworkImage(full.urls.full),
        ),
      ),
    );
  }
}
