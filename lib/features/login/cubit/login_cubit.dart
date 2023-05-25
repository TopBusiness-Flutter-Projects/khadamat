import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khadamat/core/models/login_model.dart';
import 'package:khadamat/core/remote/service.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/dialogs.dart';
import 'package:khadamat/features/home/screens/home.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());
  final ServiceApi api;

  TextEditingController phoneController = TextEditingController();
  String phoneCode = '';
  LoginModel? model;

  login() async {
    isLogin = false;
    loadingDialog();
    emit(LoginLoading());
    final response = await api.postLogin(phoneController.text, phoneCode);
    response.fold(
      (l) {
        Get.back();
        isLogin = true;
        emit(LoginError());
      },
      (r) {
        Get.back();
        isLogin = true;
        if (r.code == 200) {
          model = r;
          Get.toNamed( Routes.otpRoute);
          // sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
        } else if (r.code == 422) {
          errorGetBar('لا يوجد حساب مرتبط بهذا الهاتف');
        } else {
          errorGetBar('هناك خطئ حاول فى وقت لاحق');
        }
        emit(LoginLoaded());
      },
    );
  }

  String smsCode = '';
  bool isLogin = true;

  // final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  // sendSmsCode({String? code, String? phoneNum}) async {
  //   print('================================================');
  //   print(code);
  //   print(phoneNum);
  //   print('================================================');
  //   emit(SendCodeLoading());
  //   _mAuth.setSettings(forceRecaptchaFlow: true);
  //   _mAuth.verifyPhoneNumber(
  //     forceResendingToken: resendToken,
  //     phoneNumber:
  //         '${code ?? phoneCode}' + "${phoneNum ?? phoneController.text}",
  //     // timeout: Duration(seconds: 1),
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       smsCode = credential.smsCode!;
  //       verificationId = credential.verificationId;
  //       print("verificationId=>$verificationId");
  //       emit(OnSmsCodeSent(smsCode));
  //       // verifySmsCode(smsCode);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       emit(CheckCodeInvalidCode());
  //       print("Errrrorrrrr : ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       resendToken = resendToken;
  //       verificationId = verificationId;
  //       print("verificationId=>${verificationId}");
  //       emit(OnSmsCodeSent(''));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //     },
  //   );
  // }

  // verifySmsCode(String smsCode) async {
  //   print(verificationId);
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId!,
  //     smsCode: smsCode,
  //   );
  //   await _mAuth.signInWithCredential(credential).then((value) {
  //     Preferences.instance.setUser(model!);
  //     Get.offNamedUntil(Routes.homeRoute, (route) => false);
  //     emit(CheckCodeSuccessfully());
  //   }).catchError((error) {
  //     print('phone auth =>${error.toString()}');
  //   });
  // }
}
