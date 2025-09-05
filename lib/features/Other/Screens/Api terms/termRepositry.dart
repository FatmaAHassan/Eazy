import 'dart:convert';
import 'package:http/http.dart' as http;
import 'termsmodel.dart';  // ده الملف اللي فيه الكلاس Terms و Data

class TermsRepository {
  final String baseUrl = "https://easy.syntecheg.com/api"; // غيّريها بالرابط الصحيح

  Future<terms> fetchTerms() async {
    final response = await http.get(Uri.parse("$baseUrl/terms"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return terms.fromJson(jsonData);
    } else {
      throw Exception("فشل تحميل الشروط والأحكام");
    }
  }
}
