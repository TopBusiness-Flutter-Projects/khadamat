import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart' as gt;
import 'package:khadamat/injector.dart' as injector;
import 'package:rxdart/rxdart.dart';
import 'app.dart';
import 'app_bloc_observer.dart';
import 'config/routes/navservice.dart';
import 'core/models/login_model.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/restart_app_class.dart';
import 'features/notif/notification.dart';
import 'firebase_options.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

///Cloud messaging step 1

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher'));
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LoginModel userModel = await Preferences.instance.getUserModel();

  NotificationSettings settings = await messaging.requestPermission(
      alert: true, badge: true, provisional: true, sound: true);

  print('User granted permission: ${settings.authorizationStatus}');
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await setupLocator();
  getToken();

  // FirebaseMessaging.instance.getInitialMessage().then((value) {
  //   navigatorKey.currentState?.pushNamed(Routes.homeRoute);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen(
  //     (event) => navigatorKey.currentState?.pushNamed(Routes.homeRoute));

  await injector.setup();
  Bloc.observer = AppBlocObserver();
//!
  // if (userModel.data!.user!.email != null) {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler2);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await pushNotificationService!.initialise();
  // }

//!
  // Call the function to initialize the uni_links packages
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

Future setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
}

//*******************************************************************
getToken() async {
  String? token = await messaging.getToken();
  print("token =  $token");
  return token;
}

AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_notielse_khadamat", // id
  "high_importance_channel_khadamat", // title
  description: "this notification khadamat",
  importance: Importance.high,
  enableVibration: true,
  playSound: true,
  enableLights: true,
);

Future<void> _firebaseMessagingBackgroundHandler2(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: await ondidnotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: notificationTapBackground,
  );

  if (message.data.isNotEmpty) {
    checkData(message);

    print("Handling a background message: ${message.data}");
  }
}

void showNotification(RemoteMessage message) async {
  String paylod = "notification";
  if (message.data["note_type"] == "notification") {
    behaviorchat.add('notification');
    paylod = message.data['note_type'];
  } else {
    message.data['note_type'];
  }

  LoginModel userModel = await Preferences.instance.getUserModel();

  // if (userModel.data!.user!.email != null) {
  await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      payload: paylod,
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              icon: '@mipmap/ic_launcher')));
  // }
}

void checkData(RemoteMessage message) {
  if (message.data['note_type'].toString().contains("notification")) {
    behaviorchat.add('notification');
    showNotification(message);
  } else {
    showNotification(message);
  }
}

Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  if (payload!.contains("notification")) {
    locator<NavigationService>().navigateToReplacement();
  } else if (payload == "service_request") {}
}

Future notificationTapBackground(NotificationResponse details) async {
  print('notification payload: ${details.payload}');
  if (details.payload!.contains("notification")) {
    locator<NavigationService>().navigateToReplacement();
  }
}

Future onNotification(String payload) async {
  print(payload);
  if (payload.contains("notification")) {
    locator<NavigationService>().navigateToReplacement();
  }
}

void runWhileAppIsTerminated() async {
  await flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) => {
            if (value != null &&
                value.notificationResponse != null &&
                value.notificationResponse!.payload!.isNotEmpty)
              {}
          });
}

PushNotificationService? pushNotificationService =
    new PushNotificationService();
final locator = gt.GetIt.instance;
final BehaviorSubject<String> behaviorchat = BehaviorSubject();
