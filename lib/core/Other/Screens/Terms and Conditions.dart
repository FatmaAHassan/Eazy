
import 'package:flutter/material.dart';

import '../../config/app_palette.dart';
import 'log out.dart';



class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "الشروط والأحكام",
            style: TextStyle(color:AppPalette.textBlack),
          ),
        ),
        backgroundColor: AppPalette.textLight,
        iconTheme: const IconThemeData(color: AppPalette.textBlack),
        elevation: 0,
        actions: [
      IconButton(
      icon: const Icon(Icons.arrow_forward_rounded),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogoutPage()),
        );
      },
    ),
    ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "  يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر  يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر   يوضع هنا نص الشروط والأحكام والذي عادة ما يتكون من عدة أسطر ",
              style: TextStyle(fontSize: 16, height: 1.5, color:AppPalette.textBlack),
            ),
          ),
        ),
      ),
    );
  }
}


