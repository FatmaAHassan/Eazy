import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/profile/presentation/presentation/screen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SharePage extends StatelessWidget {
  const SharePage({super.key});

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppPalette.textLight,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // شريط السحب
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppPalette.textSubtitleLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // AirDrop
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.wifi_tethering,
                          size: 50,
                          color: AppPalette.selectedIconLight,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppPalette.textBlack,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'AirDrop',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                  '. Share instantly with people nearby If they turn on AirDrop from Control Center on iOS or from Finder on the Mac, you\'ll see their names here. Just tap to share.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Divider(color: AppPalette.textFiledEnabledBorder),
                    const SizedBox(height: 4),

                    // الصف الأول
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _shareIcon(
                          Image.asset(
                            'assets/images/message.jpg', // 🖼 ضع هنا مسار صورة الرسائل
                            width: 55,
                            height: 55,
                          ),
                          "Message",
                              () async {
                            final Uri smsUri = Uri(scheme: 'sms', path: '');
                            if (await canLaunchUrl(smsUri)) {
                              await launchUrl(smsUri);
                            }
                          },
                        ),
                        _shareIcon(
                          Image.asset(
                            'assets/images/ايميل.png', // 🖼 ضع هنا مسار صورة البريد
                            width: 55,
                            height: 55,
                          ),
                          "Mail",
                              () async {
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: 'example@example.com',
                              query: 'subject=Hello&body=How are you?',
                            );
                            if (await canLaunchUrl(emailUri)) {
                              await launchUrl(emailUri);
                            }
                          },
                        ),
                        _shareIcon(
                          Image.asset(
                            'assets/images/تويتتر.jpg', // 🖼 ضع هنا مسار صورة تويتر
                            width: 55,
                            height: 55,
                          ),
                          "Twitter",
                              () async {
                            final Uri twitterUri = Uri.parse(
                              'https://twitter.com/',
                            );
                            if (await canLaunchUrl(twitterUri)) {
                              await launchUrl(
                                twitterUri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        _shareIcon(
                          Image.asset(
                            'assets/images/فيسبوك.jpg', // 🖼 ضع هنا مسار صورة فيسبوك
                            width: 55,
                            height: 55,
                          ),
                          "Facebook",
                              () async {
                            final Uri fbUri = Uri.parse(
                              'https://facebook.com/',
                            );
                            if (await canLaunchUrl(fbUri)) {
                              await launchUrl(
                                fbUri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Divider(color: AppPalette.textFiledEnabledBorder),
                    const SizedBox(height: 4),

                    // الصف الثاني
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _shareIcon(Icon(Icons.copy), "Copy", () {
                          // أكشن النسخ
                        }),
                        _shareIcon(Icon(Icons.sticky_note_2), "Notes", () {
                          // أكشن الملاحظات
                        }),
                        _shareIcon(Icon(Icons.print), "Print", () {
                          // أكشن الطباعة
                        }),
                        _shareIcon(Icon(Icons.more_horiz), "More", () {
                          // أكشن المزيد
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 7),

              // زر Cancel
              Container(
                decoration: BoxDecoration(
                  color: AppPalette.textLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.textLight,
                      foregroundColor: AppPalette.textOrange,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _shareIcon(
      Widget iconWidget,
      String label,
      VoidCallback onTap, {
        Color? color,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppPalette.textLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: iconWidget is Icon
                ? Icon(
              iconWidget.icon,
              size: 28,
              color: color ?? AppPalette.textSubtitleLight,
            )
                : iconWidget,
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("iOS Style Share Sheet"),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () => _showShareSheet(context),
          child: const Text("Open Share Sheet"),

        ),
      ),
    );
  }
}