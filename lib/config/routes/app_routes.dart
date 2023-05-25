import 'package:flutter/material.dart';
import 'package:khadamat/features/splash/screens/splash_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../features/home/screens/home.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String otpRoute = '/otp';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) =>  const SplashScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) =>  const HomeScreen(),
        );
      case Routes.otpRoute:
        return MaterialPageRoute(
          builder: (context) =>  const HomeScreen(),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) =>  const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
