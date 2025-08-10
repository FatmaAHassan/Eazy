import 'package:flutter/material.dart';

import '../../../constants.dart';


class CustomIconBar extends StatelessWidget {
  const CustomIconBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 46,
      width: 46,
      child: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24,),
    );
  }
}