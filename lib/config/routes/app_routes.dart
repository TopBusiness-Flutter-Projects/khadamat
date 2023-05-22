import 'package:flutter/material.dart';
import 'package:khadamat/features/splash/screens/splash_screen.dart';

import '../../core/utils/app_strings.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) =>  const SplashScreen(),
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
