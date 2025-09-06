import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:flutter/material.dart';
import 'contactModel.dart';
import 'contactRepositry.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();

  final ContactRepository _repository = ContactRepository();

  Future<void> _sendMessage() async {
    // التحقق من المدخلات قبل الارسال
    if (_nameController.text.isEmpty ||
        _contactController.text.isEmpty ||
        _messageController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: const Text(
              "من فضلك املأ جميع الحقول",
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
                  Navigator.pop(context);
                },
                child: const Text(
                  "تم",
                  style: TextStyle(color: AppPalette.textLight),
                ),
              ),
            ],
          );
        },
      );
      return; // وقف هنا ومتبعتش للـ API
    }

    try {
      final CONTACT response = await _repository.sendContact(
        name: _nameController.text,
        emailOrPhone: _contactController.text, // عدلتها زي ما الريبو طالب
        message: _messageController.text,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text(
              response.message ?? "تم إرسال رسالتك",
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                  Navigator.pop(context);
                },
                child: const Text(
                  "تم",
                  style: TextStyle(color: AppPalette.textLight),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: const Text(
              "فشل إرسال الرسالة",
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
                  Navigator.pop(context);
                },
                child: const Text(
                  "تم",
                  style: TextStyle(color: AppPalette.textLight),
                ),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundLight,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
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
            const SizedBox(height: 35),
            _buildTextField("الاسم", controller: _nameController),
            const SizedBox(height: 12),
            _buildTextField("رقم الهاتف / البريد الإلكتروني",
                controller: _contactController),
            const SizedBox(height: 12),
            _buildTextField("ادخل المدخلات",
                controller: _messageController, maxLines: 4),
            const SizedBox(height: 55),
            const Center(
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
                Image.asset(ImagesManager.facebook, width: 60, height: 60),
                const SizedBox(width: 10),
                Image.asset(ImagesManager.twitter, width: 48, height: 48),
                const SizedBox(width: 6),
                Image.asset(ImagesManager.instagram, width: 68, height: 68),
                const SizedBox(width: 1),
                Image.asset(ImagesManager.whatsapp, width: 50, height: 50),
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
              onPressed: _sendMessage,
              child: const Text(
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

  static Widget _buildTextField(String hint,
      {TextEditingController? controller, int maxLines = 1}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
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
          fit: BoxFit.cover,
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
