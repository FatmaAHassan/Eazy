import 'contactModel.dart';

class ContactRepository {
  Future<CONTACT> sendContact({
    required String name,
    required String emailOrPhone,
    required String message,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // عشان تحسها API

    // تحقق من الحقول الفاضية
    if (name.trim().isEmpty || emailOrPhone.trim().isEmpty || message.trim().isEmpty) {
      return CONTACT(
        success: false,
        message: "فشل الإرسال: يجب ملء جميع الحقول",
      );
    }

    // تحقق من صحة الإيميل أو رقم الموبايل
    final isEmail = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(emailOrPhone);
    final isPhone = RegExp(r"^[0-9]{8,15}$").hasMatch(emailOrPhone);

    if (!isEmail && !isPhone) {
      return CONTACT(
        success: false,
        message: "فشل الإرسال: البريد الإلكتروني أو رقم الهاتف غير صحيح",
      );
    }

    // تحقق من عدد كلمات الرسالة
    final words = message.trim().split(RegExp(r"\s+"));
    if (words.length < 20) {
      return CONTACT(
        success: false,
        message: "فشل الإرسال: يجب أن تحتوي الرسالة على 20 كلمة على الأقل",
      );
    }

    // لو كله تمام
    return CONTACT(
      success: true,
      message: "تم إرسال رسالتك",
    );
  }
}
