import 'dart:async';
import 'package:flutter/material.dart';
import 'package:khadamat/core/utils/assets_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_routes.dart';
import '../../login/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    // Navigator.pushReplacement(
    //   context,
    //   PageTransition(
    //     type: PageTransitionType.fade,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 1300),
    //     child: NavigatorBar(),
    //   ),
    // );

    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(milliseconds: 1000),
      () {
        // Preferences.instance.clearAllData();
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
   //   print(prefs.getString('user'));
      Navigator.pushReplacementNamed(
        context,
        Routes.homeRoute
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.centerRight,
          duration: Duration(milliseconds: 1300),
          type: PageTransitionType.scale,
          child: LoginScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splash2),
            fit: BoxFit.cover,
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Hero(
        //       tag: 'logo',
        //       child: SizedBox(
        //         width: 300,
        //         height: 300,
        //         child: Image.asset(ImageAssets.logoImage),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}


