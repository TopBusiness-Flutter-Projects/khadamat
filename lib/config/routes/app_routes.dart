import 'package:flutter/material.dart';
import 'package:khadamat/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:khadamat/features/splash/screens/splash_screen.dart';

import '../../core/utils/app_strings.dart';
import '../../features/edit_profile/screen/edit_profile.dart';
import '../../features/favorite/screens/favorite_screen.dart';
import '../../features/home/screens/home.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String otpRoute = '/otp';
  static const String favoriteRoute = '/favorite';
  static const String editProfileRoute = '/editProfile';
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
      case Routes.favoriteRoute:
        return MaterialPageRoute(
          builder: (context) =>  const FavoriteScreen(),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) =>  const EditProfile(),
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
