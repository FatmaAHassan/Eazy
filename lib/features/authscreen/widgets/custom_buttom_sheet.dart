import 'package:flutter/material.dart';

class CustomButtonSheet extends StatelessWidget {
  const CustomButtonSheet({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold))),
    );
  }
}