import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/dialogs.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.api) : super(ResetPasswordInitial());
  ServiceApi api;
  String phoneCode = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController codecontrol = TextEditingController();
  LoginModel? model;
  LoginModel? model2;
  var responseCode;
  bool isObscureText = true;
  IconData passwordIcon = Icons.visibility;
  changePasswordIcon() {
    isObscureText = !isObscureText;
    if (isObscureText == true) {
      passwordIcon = Icons.visibility_off;
      emit(ChangePasswordIconStat());
    } else {
      passwordIcon = Icons.visibility;
      emit(ChangePasswordIconStat());
    }
    emit(ChangePasswordIconStat());
  }

  checkPhone() async {
    loadingDialog();
    // emit(LoginLoading());
    final response = await api.checkPhone(phoneController.text, phoneCode);
    response.fold(
      (l) {
        Get.back();
        emit(CheckPhoneError());
      },
      (r) async {
        Get.back();

        if (r.code == 200) {
          emit(CheckPhoneLoaded());
          responseCode = 200;
          print("r.code == 200");
          model = r;

          // Get.offAllNamed( Routes.verificationScreenRoute);
          await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          Get.toNamed(Routes.verificationScreenRoute);
        } else if (r.code == 422) {
          responseCode = 422;
          print("r.code == 422");
          errorGetBar('لا يوجد حساب مرتبط بهذا الهاتف');
          // await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          //  Get.toNamed( Routes.verificationScreenRoute);
        } else if (r.code == 406) {
          responseCode = 406;
          print("r.code == 422");
          errorGetBar('لا يوجد حساب مرتبط بهذا الهاتف');
          // await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          //  Get.toNamed( Routes.verificationScreenRoute);
        } else {
          print("هناك خطئ حاول فى وقت لاحق");
          errorGetBar('هناك خطئ حاول فى وقت لاحق');
        }
      },
    );
  }

  int? resendToken;
  String smsCode = '';
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verification_Id;

  sendSmsCode({String? code, String? phoneNum}) async {
    if (phoneNum!.startsWith("0")) {
      phoneNum = phoneNum.substring(1, 11);
      print("phone = $phoneNum");
    }
    print('================================================');
    print(code);
    print(phoneNum);
    print('================================================');
    emit(SendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber:
          '${code ?? phoneCode}' + "${phoneNum ?? phoneController.text}",
      timeout: Duration(seconds: 25),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        print("sms code = $smsCode");
        verification_Id = credential.verificationId;
        print("_____________________________________________ $verification_Id");
        print("verificationId=$verification_Id");
        if (codecontrol.hasListeners) {
          codecontrol.text = smsCode.toString();
        }
        verifySmsCode(smsCode);
        emit(OnSmsCodeSent(smsCode));
        //  verifySmsCode(smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(CheckCodeInvalidCode());
        print("Errrrorrrrr : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.resendToken = resendToken;
        this.verification_Id = verificationId;

        print("verificationId=>${verificationId}");

        emit(OnSmsCodeSent(''));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode) async {
    print(smsCode);
    print(verification_Id);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verification_Id!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) async {
      // var model= await Preferences.instance.getUserModel();
      Get.offAndToNamed(Routes.resetPasswordRoute);

      emit(CheckCodeSuccessfully());
      //  if(model.data==null){
      //    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      //    print(model.data);
      //    emit(ModelDoesNotExist());
      //
      //  }else{
      //    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      //    print(model.data!.user!.name);
      //    emit(ModelExistState());
      //    Get.offAndToNamed(Routes.homeRoute);
      //
      // }
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }

  resetPassword(BuildContext context) async {
    final response = await api.resetPassword(phoneController.text,
        passwordController1.text, passwordController2.text);
    response.fold(
      (l) {
        Get.back();
        emit(resetPasswordError());
      },
      (r) async {
        Get.back();

        if (r.code == 200) {
          emit(resetPasswordLoaded());
          responseCode = 200;
          print("r.code == 200");
          model2 = r;
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.loginRoute, (route) => false);
          //  var model= await Preferences.instance.getUserModel();

          //Get.offAndToNamed(Routes.resetPasswordRoute);
          // if(model.data==null){
          //   print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
          //   print(model.data);
          //   emit(ModelDoesNotExist());
          //
          //
          // }else{
          //   print("111111111111111111111111111111111111");
          //   print(model.data!.user!.name);
          //   emit(ModelExistState());
          //  // Get.offAndToNamed(Routes.homeRoute);
          //
          // }
        } else if (r.code == 408) {
          responseCode = 408;
          print("r.code == 408");
          errorGetBar('password already reset');
          // await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          //  Get.toNamed( Routes.verificationScreenRoute);
        } else {
          print("هناك خطئ حاول فى وقت لاحق");
          errorGetBar('هناك خطئ حاول فى وقت لاحق');
        }
      },
    );
  }
}
