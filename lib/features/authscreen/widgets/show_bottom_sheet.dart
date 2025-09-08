import 'package:eazy/constants.dart';
import 'package:flutter/material.dart';

import 'custom_buttom_sheet.dart';


class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({
    super.key,
    required this.title,
    required this.firstLine,
    required this.secondLine,
  });
  final String title;
  final String firstLine;
  final String secondLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              firstLine,
              style: TextStyle(color: kSecondaryColor, fontSize: 14),
            ),
            Text(
              secondLine,
              textAlign: TextAlign.center,
              style: TextStyle(color: kSecondaryColor, fontSize: 14),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonSheet(text: 'تراجع', color: kSecondaryColor),
                SizedBox(width: 30),
                CustomButtonSheet(text: 'نعم', color: kPrimaryColor),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}