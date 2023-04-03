import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, String massage, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: color,
      content: Center(
          child: Text(
        massage,
        style: TextStyle(
          fontSize: 15,
        ),
      )),
    ),
  );
}
