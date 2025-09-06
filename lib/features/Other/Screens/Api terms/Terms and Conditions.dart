import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/Other/Screens/Api%20terms/termRepositry.dart';
import 'package:eazy/features/Other/Screens/Api%20terms/termsmodel.dart';
import 'package:flutter/material.dart';


class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final TermsRepository _termsRepository = TermsRepository();
  terms? _terms;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTerms();
  }

  Future<void> _loadTerms() async {
    try {
      final result = await _termsRepository.fetchTerms();
      setState(() {
        _terms = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "فشل تحميل البيانات";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "الشروط والأحكام",
            style: TextStyle(color: AppPalette.textBlack),
          ),
        ),
        backgroundColor: AppPalette.textLight,
        iconTheme: const IconThemeData(color: AppPalette.textBlack),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? Center(
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
          ),
        )
            : SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              _terms?.data?.content ?? "لا يوجد بيانات",
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppPalette.textBlack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
