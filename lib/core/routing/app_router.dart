import 'package:eazy/features/Questionsafterlesson/first%20question.dart';
import 'package:eazy/features/Subscriptions/Screens/Api%20UpgradeNow/Upgrade%20now.dart';
import 'package:eazy/features/Subscriptions/Screens/payment.dart';
import 'package:eazy/features/home/presentation/Screens/home.dart';
import 'package:eazy/features/home/presentation/Screens/section_screen.dart';
import 'package:eazy/features/lessons/presentation/screens/lessons.dart';
import 'package:eazy/features/lessons/presentation/screens/lessons_details.dart';
import 'package:eazy/features/myLessons/presentation/screens/Api_Mylesson/myLessons_screen.dart';
import 'package:eazy/features/onboarding/presentation/onboarding.dart';
import 'package:eazy/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/routing/routes.dart';
import 'package:eazy/features/authscreen/login_screen.dart';
import 'package:eazy/features/authscreen/otp_screen.dart';
import 'package:eazy/features/authscreen/register_screen.dart';
import 'package:eazy/features/authscreen/reset_password.dart';
import 'package:eazy/features/authscreen/update_password_screen.dart';
import 'package:eazy/features/profile/presentation/screen/personalDetailsScreen.dart';
import 'package:eazy/features/profile/presentation/screen/profileScreen.dart';
import 'package:eazy/notification/presentation/screen/no_notification_body.dart';
import 'package:eazy/features/authscreen/forget_password_screen.dart';
import 'package:eazy/notification/presentation/screen/notification_screen.dart';
import 'package:eazy/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return _animatedRoute(const SplashScreen(), settings);
      case Routes.LoginScreen:
        return _animatedRoute(const LoginScreen(), settings);
      case Routes.RegisterScreen:
        return _animatedRoute(const RegisterScreen(), settings);
      case Routes.ForgetPasswordScreen:
        return _animatedRoute(const ForgetPasswordScreen(), settings);
      case Routes.OtpScreen:
        return _animatedRoute(const OtpScreen(), settings);
      case Routes.ResetPassword:
        return _animatedRoute(const ResetPassword(), settings);
      case Routes.UpdatePasswordScreen:
        return _animatedRoute(const UpdatePasswordScreen(), settings);
      case Routes.CustomNavBar:
        return _animatedRoute(const CustomNavBar(), settings);
      case Routes.HomeScreen:
        return _animatedRoute(const HomeScreen(), settings);
      case Routes.ProfileScreen:
        return _animatedRoute(const ProfileScreen(), settings);
      case Routes.PersonalDetailsScreen:
        return _animatedRoute(const PersonalDetailsScreen(), settings);
      case Routes.NotificationScreen:
        return _animatedRoute(const NotificationScreen(), settings);
      case Routes.NoNotificationBody:
        return _animatedRoute(const NoNotificationBody(), settings);
      case Routes.SectionScreen:
        return _animatedRoute(const SectionScreen(), settings);
      case Routes.LessonsDetails:
        return _animatedRoute(const LessonsDetails(), settings);
      case Routes.LessonsScreen:
        return _animatedRoute(const LessonsScreen(), settings);
      case Routes.MyLessonsScreen:
        return _animatedRoute(const MyLessonsScreen(), settings);
      case Routes.UpgradeNowScreen:
        return _animatedRoute(const UpgradeNowScreen(), settings);
      case Routes.PaymentScreen:
        return _animatedRoute(const PaymentScreen(), settings);
      case Routes.FirstQuestionScreen:
        return _animatedRoute(const FirstQuestionScreen(), settings);
      case Routes.onboardingScreen:
        return _animatedRoute(const OnboardingScreen(), settings);

      default:
        return _animatedRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  PageRouteBuilder _animatedRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
