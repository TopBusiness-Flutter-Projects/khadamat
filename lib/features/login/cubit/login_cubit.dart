
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  String phoneCode = '';
  LoginModel? model;
  var responseCode;

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
      (r) async {
        Get.back();
        isLogin = true;
        if (r.code == 200) {
          responseCode = 200;
          print("r.code == 200");
          model = r;
          //this is home route

          Preferences.instance.setUser(r);
          await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          Get.toNamed( Routes.verificationScreenRoute);
          // sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
        }
        else if (r.code == 422) {
          responseCode = 422;
          print("r.code == 422");
         // errorGetBar('لا يوجد حساب مرتبط بهذا الهاتف');
         await sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
          Get.toNamed( Routes.verificationScreenRoute);

        } else {
          print("هناك خطئ حاول فى وقت لاحق");
          errorGetBar('هناك خطئ حاول فى وقت لاحق');
        }
        emit(LoginLoaded());
      },
    );
  }

  String smsCode = '';
  bool isLogin = true;
 late LoginModel registerModel ;
   final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verification_Id;
  int? resendToken;

  sendSmsCode({String? code, String? phoneNum}) async {
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
       timeout: Duration(seconds: 10),

      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        verification_Id = credential.verificationId;
        print("_____________________________________________ $verification_Id");
        print("verificationId=>$verification_Id");
        emit(OnSmsCodeSent(smsCode));
        // verifySmsCode(smsCode);
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
    print(verification_Id);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verification_Id!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) async {
      var model= await Preferences.instance.getUserModel();
     // emit(CheckCodeSuccessfully());
      if(model.data==null){
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(model.data);
        emit(ModelDoesNotExist());
       // Navigator.pushNamed(context, Routes.otpRoute);
      }else{
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(model.data!.user!.name);
        emit(ModelExistState());

      }


    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }

  // register() async {
  //   final response =await  api.postRegister(phoneController.text, phoneCode,nameController.text);
  //   response.fold(
  //           (l) => emit(RegisterFailedState()),
  //           (r) {
  //             if(r.code==200){
  //               registerModel = r ;
  //               Preferences.instance.setUser(registerModel);
  //               emit(RegisterSuccessState());
  //             }
  //             else if(r.code==409){
  //             //  registerModel = r ;
  //               emit(RegisterFailedUserExistState());
  //             }
  //
  //           });
  // }
}
