import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/preferences/preferences.dart';
import 'package:khadamat/injector.dart' as injector;
import 'package:uni_links/uni_links.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException, MethodChannel;


// void main() {
//   runApp(const MyApp());
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
 await Firebase.initializeApp();
  await injector.setup();
  Bloc.observer = AppBlocObserver();
  // Call the function to initialize the uni_links package
  initUniLinks2();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/lang',
      saveLocale: true,
      startLocale: const Locale('ar', ''),
      fallbackLocale: const Locale('ar', ''),
      child: HotRestartController(child: const Khadamat()),
    ),
  );


}

//
// void initUniLinks() async {
//   try {
//     // Request initial link on application startup
//     String? initialLink = await getInitialLink();
//
//     // Handle the initial link if available
//     handleLink(initialLink);
//
//     // Listen for incoming links
//     uriLinkStream.listen((Uri? uri) {
//       // Handle the incoming link
//       handleLink(uri?.toString());
//     }, onError: (err) {
//       // Handle any errors that occur while listening for links
//       print('Error listening to incoming links: $err');
//     });
//   } on PlatformException {
//     // Handle any exceptions that occur during initialization
//     print('Error initializing uni_links');
//   }
// }
//
// void handleLink(String? link) {
//   // Handle the deep link URL
//   if (link != null) {
//     print(link);
//     // Add your custom logic to handle the deep link
//     print('Received deep link: $link');
//   }
// }

//*******************************************************************
void initUniLinks2() async {
  try {
    // Request permission to handle incoming links if needed
    await uriLinkStream.listen((Uri? uri) {
      // Handle the received deep link
      handleDeepLink(uri);
    }, onError: (err) {
      print("Error handling deep link: $err");
    });

    // Get the initial deep link if the app was opened from a deep link
    Uri? initialUri = await getInitialUri();
    if (initialUri != null) {
      // Handle the initial deep link
      handleDeepLink(initialUri);
    }
  } on PlatformException {
    print('Error initializing deep link handling.');
  }
}
void handleDeepLink(Uri? uri) {
  // Parse the deep link and extract the relevant data

print(uri.toString());
  // Navigate to the appropriate screen based on the extracted data
  // For example, you can use a Navigator.push() method to navigate to the details screen
  if (uri != null) {
    String? serviceId = uri.toString().split("/").last;
    int id = int.parse(serviceId);
    Preferences.instance.setServiceId(id);

  }
}

