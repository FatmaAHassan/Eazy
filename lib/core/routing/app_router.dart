import 'package:Easy/core/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return _animatedRoute(const SplashScreen(), settings);
      //   case Routes.onboardingWelcomeScreen:
      //   return _animatedRoute(const OnboardingWelcomeScreen(), settings);
      // case Routes.navScreen:
      //   return _animatedRoute(const NavScreen(), settings);
      // case Routes.onboardingScreen:
      //   return _animatedRoute(const OnboardingScreen(), settings);

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
