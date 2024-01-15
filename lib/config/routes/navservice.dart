import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/screens/home.dart';
import '../../features/notification/cubit/nottification_cubit.dart';
import '../../features/notification/screens/notification_screen.dart';
import '../../injector.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement({bool isBack = false}) {
    print("navigateToReplacement");
    if (isBack) {
      return navigationKey.currentState!
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      return navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => NottificationCubit(serviceLocator()),
                child: NotificationScreen(),
              )));
    }
  }

  // goback() {
  //   return navigationKey.currentState!.pop();
  // }
}
