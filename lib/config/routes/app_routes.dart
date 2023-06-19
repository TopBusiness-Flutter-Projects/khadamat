import 'package:flutter/material.dart';
import 'package:khadamat/core/widgets/full_screen_image.dart';
//import 'package:khadamat/features/all_services/screens/all_services.dart';
import 'package:khadamat/features/contact_us/screen/contact_us.dart';
import 'package:khadamat/features/details/screens/details.dart';
import 'package:khadamat/features/google_map/screens/google_map.dart';
import 'package:khadamat/features/my_posts/screen/my_posts.dart';
import 'package:khadamat/features/splash/screens/splash_screen.dart';
import '../../core/models/catigoreis_services.dart';
import '../../core/models/home_model.dart';
import '../../core/models/my_services_model.dart';
import '../../core/models/servicemodel.dart';
import '../../core/utils/app_strings.dart';
import '../../features/edit_profile/screen/edit_profile.dart';
import '../../features/favorite/screens/favorite_screen.dart';
import '../../features/home/screens/home.dart';
import '../../features/privacy_about/screen/privacy_about.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String otpRoute = '/otp';
  static const String googleMapScreenRoute = '/googleMapScreen';
  static const String favoriteRoute = '/favorite';
  static const String fullScreenImageRoute = '/fullScreenImageRoute';
  static const String editProfileRoute = '/editProfile';
  static const String allServicesRoute = '/allServices';
  static const String privacyRoute = '/privacy_about';
  static const String myPostsRoute = '/my_posts';
  static const String detailsRoute = '/details';
  static const String details1Route = '/details1';
  static const String details2Route = '/details2';
  static const String contactUsRoute = '/contact_us';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.googleMapScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const GoogleMapScreen(),
        );
      case Routes.fullScreenImageRoute:
        final imageUrl = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>  FullScreenImage(imageUrl: imageUrl),
        );

      // case Routes.allServicesRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => const AllServices(),
      //   );
      case Routes.contactUsRoute:
        return MaterialPageRoute(
          builder: (context) => const ContactUs(),
        );
      case Routes.otpRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.favoriteRoute:
        return MaterialPageRoute(
          builder: (context) => const FavoriteScreen(),
        );
      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
        );
      case Routes.privacyRoute:
        return MaterialPageRoute(
          builder: (context) => PrivacyAbout(),
        );
      case Routes.myPostsRoute:
        return MaterialPageRoute(
          builder: (context) => MyPosts(),
        );
      case Routes.detailsRoute:
        final service = settings.arguments as ServicesModel;
        return MaterialPageRoute(
          // Extract the service model argument from the settings arguments map

          builder: (context) => Details(service: service),
        );



      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
