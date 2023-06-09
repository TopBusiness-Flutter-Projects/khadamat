import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/injector.dart' as injector;
import 'package:uni_links/uni_links.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';

// void main() {
//   runApp(const MyApp());
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
 await Firebase.initializeApp();
  await injector.setup();
  Bloc.observer = AppBlocObserver();

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


