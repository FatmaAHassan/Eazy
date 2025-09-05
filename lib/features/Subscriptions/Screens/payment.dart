import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:eazy/features/Subscriptions/Screens/Subscriptions.dart';
import 'package:flutter/material.dart';
import 'Api UpgradeNow/upgradeNow_Model.dart';
import 'Api UpgradeNow/upgradenowRepositry.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const String routeName = 'PaymentScreen';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double price = 0; // السعر من الـ API
  double tax = 0;   // الضريبة
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrice();
  }

  Future<void> _fetchPrice() async {
    // هنا بتحطي كود الـ API اللي بيرجع الباكيدج
    // Example:
    await Future.delayed(const Duration(seconds: 1)); // مكان الكول بتاع API

  }

  @override
  Widget build(BuildContext context) {
    final repo = SubscriptionRepository();
    const String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2Vhc3kuc3ludGVjaGVnLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3NTY3NDA5MzEsImV4cCI6MTc1Njc0NDUzMSwibmJmIjoxNzU2NzQwOTMxLCJqdGkiOiJCd1E3N3U2T2VHbXg4eE00Iiwic3ViIjoiNjkiLCJwcnYiOiJhYmM4NDdmZjY0ZDA4OTQ3MTExZWU3NjNkZTEzMzY5MWRiNWEyNTgzIn0.Qy4rT0BX9R2G95Ccp8AWlvdW5ahh_R9yECONUrj7nZM";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppPalette.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppPalette.backgroundLight,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "بوابة الدفع",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPalette.textBlack,
            ),
          ),
        ),
        body:

    SafeArea(
    child: FutureBuilder<subscription?>(
    future: repo.getSubscription(token),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(color:  AppPalette.textLight));
    } else if (snapshot.hasError) {
    return Center(
    child: Text(
    "حصل خطأ: ${snapshot.error}",
    style: const TextStyle(color:  AppPalette.textLight),
    ),
    );
    } else if (!snapshot.hasData || snapshot.data?.package == null) {
    return const Center(
    child: Text(
    "لا توجد بيانات متاحة",
    style: TextStyle(color:  AppPalette.textLight),
    ),
    );
    }

    final package = snapshot.data!.package!;

       price = package.price?.toDouble() ?? 0;
         return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 470),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(ImagesManager.eazyPay, height: 130),
                  const SizedBox(height: 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Secure payment",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppPalette.textBlack,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.lock, color: AppPalette.textBlack),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _buildInputField(
                    label: "رقم البطاقة",
                    hint: "**** **** **** 1234",
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: "تاريخ الانتهاء",
                          hint: "MM/YY",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInputField(
                          label: "رمز الأمان",
                          hint: "CVV",
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    label: "اسم حامل البطاقة",
                    hint: "كما هو على البطاقة",
                  ),

                  const SizedBox(height: 50),

                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تكلفة الاشتراك",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // هنا هيظهر السعر اللي جاي من الـ API
                  _buildPaymentSummary(price, tax,package),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "تم الدفع بنجاح",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppPalette.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const SubscriptionScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "تم",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppPalette.textLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "اذهب للدفع",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppPalette.textLight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
      )

        ),
        )
    );
  }

  static Widget _buildInputField({
    required String label,
    required String hint,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppPalette.textBlackLight,
            )),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: AppPalette.textFiledEnabledBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppPalette.primary),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildPaymentSummary(double price, double tax,dynamic package) {
    double total = price + tax;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPalette.textFiledFocusedBorder,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSummaryRow("تكلفة الاشتراك", "${package.price ?? 0} د.ل"),
          const SizedBox(height: 6),
          _buildSummaryRow("الضريبة", "$tax د.ل"),
          const Divider(color: AppPalette.borderColor),
          _buildSummaryRow("المجموع", "$total د.ل", isBold: true),
        ],
      ),
    );
  }

  static Widget _buildSummaryRow(String title, String value,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
              color: AppPalette.textBlack,
            )),
        Text(value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
              color: AppPalette.textBlack,
            )),
      ],
    );
  }
}
