import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/preferences/preferences.dart';
import 'package:khadamat/core/utils/assets_manager.dart';
import 'package:khadamat/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import '../../../config/routes/app_routes.dart';
import '../../details_from_deeplink/details_deeplink/details_deeplink_cubit.dart';
import '../../login/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;

  StreamSubscription? _streamSubscription;
  late Timer _timer;

  // _goNext() {
  //   _getStoreUser();
  // }

  _startDelay() async {
    _timer = Timer(
      const Duration(milliseconds: 1000),
      () {
        print("🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳🥳");
        getStoreUser();
        // Preferences.instance.clearAllData();
       // _goNext();
      },
    );
  }

  Future<void> getStoreUser() async {
    print("(((((((((((((((((((((((((((((((((((((((((((((((((((((((");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
  int? serviceId = await Preferences.instance.getServiceId();

  if(_initialURI!=null&&serviceId==null){

    print(_initialURI.toString());
serviceId=int.parse(_initialURI!.path.split("/").last);
  }
  print("kkkkkSSSS");
print(serviceId.toString());
if(serviceId==null){
  Navigator.pushReplacementNamed(
      context,
      Routes.homeRoute
  );
}
 else if(serviceId>0){
        print("kkkkkSSSS");
        Preferences.instance.setServiceId(0);
      //  await context.read<DetailsDeeplinkCubit>().getServiceDetails(serviceId);

        Navigator.pushReplacementNamed(context, Routes.detailsFromDeepLinkRoute,arguments:serviceId );
         context.read<DetailsDeeplinkCubit>().getServiceDetails(serviceId);
      }
    else{
        Navigator.pushReplacementNamed(
            context,
            Routes.homeRoute
        );
      }
    }
    //go to login
    else {
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
    _initURIHandler();
    _incomingLinkHandler();
    _startDelay();


  }

  @override
  void dispose() {
    _timer.cancel();
    _streamSubscription?.cancel();
    super.dispose();
  }


  Future<void> _initURIHandler() async {
    // 1
    // print("dddd");
    //  print(_initialURI);
    //  if(_initialURI!=null){
    //    setState(() {
    //      _initialURI=null;
    //      _initURIHandler();
    //    });
    //
    //  }
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      // 2
      // /  Fluttertoast.showToast(
      //       msg: "Invoked _initURIHandler",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white);
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          // debugPrint("Initial URI received $initialURI");
          //  print("ddkdkkdkdkdkdkfjgjgjhg");
          //print(initialURI);
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
        } else {
          //   debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        // 5
        //debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        // 6
        if (!mounted) {
          return;
        }
        //debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }

  void _incomingLinkHandler() {
    // 1
    if (!kIsWeb) {
      // 2
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        // debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          // print("llllkkoii");
          //print(_currentURI);
          _err = null;
        });
        // 3
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        //  debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
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


