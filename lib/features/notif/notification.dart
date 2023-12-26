import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../config/routes/navservice.dart';
import '../../core/models/login_model.dart';
import '../../core/preferences/preferences.dart';
import '../../firebase_options.dart';
import 'notificationlisten.dart';

class PushNotificationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // StreamController<String> streamController = StreamController<String>.broadcast();
  final locator = GetIt.instance;
  late AndroidNotificationChannel channel;
  // NotificationDatum? chatModel;
  // MessageModel? messageDataModel;
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  final BehaviorSubject<String> behaviorchat = BehaviorSubject();
  RemoteMessage? initialMessage;

  late BuildContext context;

  // final BehaviorSubject<MessageModel> behaviormessage = BehaviorSubject();

  Future initialise() async {
    initialMessage =
        await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        // chatModel = NotificationDatum.fromJson(jsonDecode(value.data['room']));
        locator<NavigationService>().navigateToReplacement();
      }
    });
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: await ondidnotification);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      checkData(message);
      //showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Got a message whilstt in the foreground!');
      print('Message data: ${message.data}');

//  showNotification(message);
      checkData(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Handling a background message:");

    if (message.data.isNotEmpty) {
      print("Handling a background message: ${message.data}");
      checkData(message);
    }
    // showNotification(message);
  }

  Future<void> showNotification(RemoteMessage message) async {
    //chatModel = ChatModel.fromJson(jsonDecode(message.data['room']));
    String paylod = message.data['room'] + message.data['note_type'];
    behaviorchat.add('notification');
    LoginModel userModel = await Preferences.instance.getUserModel();
    if (userModel.data!.user!.email != null) {
      flutterLocalNotificationsPlugin.show(
          message.data.hashCode,
          message.data['title'],
          message.data['body'],
          payload: paylod,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  importance: Importance.max,
                  icon: '@mipmap/ic_launcher')));
    }
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    print("dldldk${didNotificationLaunchApp}");
  }

  void checkData(RemoteMessage message) {
    if (message.data['note_type'].toString().contains("notification")) {
      //  if(navigatorKey.currentState!.widget.initialRoute!=AppConstant.pageChatRoute){

      // chatModel = NotificationDatum.fromJson(jsonDecode(message.data['room']));
      var notification;
      notification = LocalNotification("data", message.data);

      behaviorchat.add('notification');

      NotificationsBloc.instance.newNotification(notification);

      showNotification(message);
    } else {
      var notification = LocalNotification("data", message.data);
      NotificationsBloc.instance.newNotification(notification);

      showNotification(message);
    }
  }

  Future notificationTapBackground(NotificationResponse details) async {
    print('notification payload: ${details.payload}');
    if (details.payload!.contains("notification")) {
      behaviorchat.add('notification');
      behaviorSubject.add("notification");
    }
  }

  Future ondidnotification(
      int id, String? title, String? body, String? payload) async {
    print("object");
    print('notification payload: ${payload}');
    if (payload!.contains("notification")) {
      behaviorchat.add('notification');
      behaviorSubject.add("notification");
    }
  }
}
