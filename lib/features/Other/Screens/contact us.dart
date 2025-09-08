import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/Other/Screens/common%20questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "تواصل معنا",
          style: TextStyle(
            color: AppPalette.textBlack,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 35),
            _buildTextField("الاسم"),
            const SizedBox(height: 12),
            _buildTextField("رقم الهاتف / البريد الإلكتروني"),
            const SizedBox(height: 12),
            _buildTextField("ادخل المدخلات", maxLines: 4),
            const SizedBox(height: 55),
            Center(
              child: Text(
                "او تواصل معنا",
                style: TextStyle(color: AppPalette.textBlack, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Image.asset(ImagesManager.facebookk, width: 60, height: 60),
                const SizedBox(width: 10),
                Image.asset(ImagesManager.twitterr, width: 48, height: 48),
                const SizedBox(width: 6),
                Image.asset(ImagesManager.instagramm, width: 68, height: 68),
                const SizedBox(width: 1),
                Image.asset(ImagesManager.whatsappp, width: 50, height: 50),

                const SizedBox(width: 10),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: Text(
                        "تم إرسال رسالتك",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPalette.textBlack,
                          fontSize: 20,
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.primary,
                          ),
                          onPressed: () {
                            // Navigator.pop(context); // إغلاق الرسالة
                            Navigator.pop(context);
                          },
                          child: Text(
                            "تم",
                            style: TextStyle(color: AppPalette.textLight),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "أرسل",
                style: TextStyle(color: AppPalette.textLight, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildTextField(String hint, {int maxLines = 1}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppPalette.textSubtitleLight),
          filled: true,
          fillColor: AppPalette.foregroundLight,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppPalette.textFiledEnabledBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppPalette.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithName(String imagePath, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover, // علشان يملأ المساحة وما يبقاش شفاف
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
