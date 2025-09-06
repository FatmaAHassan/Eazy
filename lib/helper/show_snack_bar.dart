import 'package:flutter/material.dart';

void showSnackBar(context, String message, MaterialColor red) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Center(child: Text(message, textAlign: TextAlign.center)),
    ),
  );
}