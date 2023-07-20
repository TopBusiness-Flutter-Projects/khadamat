import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/core/widgets/full_screen_image.dart';
//import 'package:khadamat/features/all_services/screens/all_services.dart';
import 'package:khadamat/features/contact_us/screen/contact_us.dart';
import 'package:khadamat/features/details/screens/details.dart';
import 'package:khadamat/features/details/screens/google_map_details.dart';
import 'package:khadamat/features/google_map/screens/google_map.dart';
import 'package:khadamat/features/login/screens/login.dart';
import 'package:khadamat/features/login/screens/verfiication_screen.dart';
import 'package:khadamat/features/my_posts/screen/my_posts.dart';
import 'package:khadamat/features/notification_details/screens/notification_details.dart';
import 'package:khadamat/features/otp/screen/otp.dart';
import 'package:khadamat/features/register/screens/register_screen.dart';
import 'package:khadamat/features/splash/screens/splash_screen.dart';
import '../../core/models/catigoreis_services.dart';
import '../../core/models/home_model.dart';
import '../../core/models/my_services_model.dart';
import '../../core/models/notification_model.dart';
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
  static const String notificationDetailsRoute = '/notificationDetails';
  static const String registerScreenRoute = '/registerScreen';
  static const String otpScreenRoute = '/otpScreen';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String googleMapScreenRoute = '/googleMapScreen';
  static const String favoriteRoute = '/favorite';
  static const String fullScreenImageRoute = '/fullScreenImageRoute';
  static const String editProfileRoute = '/editProfile';
  static const String allServicesRoute = '/allServices';
  static const String privacyRoute = '/privacy_about';
  static const String myPostsRoute = '/my_posts';
  static const String detailsRoute = '/details';
  static const String contactUsRoute = '/contact_us';
  static const String googleMapDetailsRoute = '/google_map_details_screen';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        );
      case Routes.notificationDetailsRoute:
        final notificationModel = settings.arguments as NotificationDatum;
        return MaterialPageRoute(
          builder: (context) =>  NotificationDetails(notificationModel: notificationModel),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.registerScreenRoute:
        return MaterialPageRoute(
          builder: (context) =>  RegisterScreen(),
        );
      case Routes.verificationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
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
      case Routes.googleMapDetailsRoute:
        final latLng = settings.arguments as LatLng;
        return MaterialPageRoute(

        builder: (context) =>  GoogleMapDetailsScreen(latLng: latLng),
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
      case Routes.otpScreenRoute:
        return MaterialPageRoute(
          builder: (context) => OtpScreen(),
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
