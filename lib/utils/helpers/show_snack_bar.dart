import 'package:flutter/material.dart';

void showSnackBar(String message, Color backgroundColor, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: backgroundColor),
  );
  Navigator.of(context).pop();
}