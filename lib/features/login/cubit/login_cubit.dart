import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khadamat/core/models/login_model.dart';
import 'package:khadamat/core/remote/service.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/dialogs.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginInitial());
  final ServiceApi api;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String phoneCode = '';
  LoginModel? model;
  var responseCode;

  login(
    BuildContext context,
  ) async {
    print("___________________________________________________________");
    // isLogin = false;
    // loadingDialog();
    emit(LoginLoading());
    final response = await api.postLogin(
        phoneController.text, phoneCode, passwordController.text);
    response.fold(
      (l) {
        // Get.back();
        // isLogin = true;
        emit(LoginError());
      },
      (r) async {
        if (r.code == 200) {
          errorGetBar('تم تسجيل الدخول بنجاح', code: 1);
          responseCode = 200;
          model = r;
          Preferences.instance.setUser(r);
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
          phoneController.clear();
          nameController.clear();
        } else {
          errorGetBar(r.message ?? '');
        }
        emit(LoginLoaded());
      },
    );
  }

  String smsCode = '';
  // bool isLogin = true;
  late LoginModel registerModel;
  //  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verification_Id;
  int? resendToken;
  bool isObscureText = true;
  IconData passwordIcon = Icons.visibility;
  changePasswordIcon() {
    isObscureText = !isObscureText;
    if (isObscureText == true) {
      passwordIcon = Icons.visibility_off;
      emit(ChangePasswordIconState());
    } else {
      passwordIcon = Icons.visibility;
      emit(ChangePasswordIconState());
    }
    emit(ChangePasswordIconState());
  }

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
  //      timeout: Duration(seconds: 10),
  //
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       smsCode = credential.smsCode!;
  //       verification_Id = credential.verificationId;
  //       print("_____________________________________________ $verification_Id");
  //       print("verificationId=>$verification_Id");
  //       emit(OnSmsCodeSent(smsCode));
  //       // verifySmsCode(smsCode);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       emit(CheckCodeInvalidCode());
  //       print("Errrrorrrrr : ${e.message}");
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       this.resendToken = resendToken;
  //       this.verification_Id = verificationId;
  //
  //       print("verificationId=>${verificationId}");
  //       emit(OnSmsCodeSent(''));
  //     },
  //
  //
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //     },
  //   );
  // }
  //
  // verifySmsCode(String smsCode) async {
  //   print(verification_Id);
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: verification_Id!,
  //     smsCode: smsCode,
  //   );
  //   await _mAuth.signInWithCredential(credential).then((value) async {
  //     var model= await Preferences.instance.getUserModel();
  //    // emit(CheckCodeSuccessfully());
  //     if(model.data==null){
  //       print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
  //       print(model.data);
  //       emit(ModelDoesNotExist());
  //      // Navigator.pushNamed(context, Routes.otpRoute);
  //     }else{
  //       print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
  //       print(model.data!.user!.name);
  //       emit(ModelExistState());
  //
  //     }
  //
  //
  //   }).catchError((error) {
  //     print('phone auth =>${error.toString()}');
  //   });
  // }
}
