import 'package:flutter/material.dart';

Widget lastCard() {
  return Card(
    child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
      ),
    ),
  );
}