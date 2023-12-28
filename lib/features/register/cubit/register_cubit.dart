import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khadamat/core/remote/service.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/dialogs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial());

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ServiceApi api;
  late LoginModel registerModel;
  String phoneCode = '';
  bool isObscureText = true;
  IconData passwordIcon = Icons.visibility;
  changePasswordIcon() {
    isObscureText = !isObscureText;
    if (isObscureText == true) {
      passwordIcon = Icons.visibility_off;
      emit(ChangePasswordIcon());
    } else {
      passwordIcon = Icons.visibility;
      emit(ChangePasswordIcon());
    }
    emit(ChangePasswordIcon());
  }

  register(BuildContext context) async {
    loadingDialog();
    final response = await api.postRegister(phoneController.text, phoneCode,
        nameController.text, passwordController.text);
    response.fold((l) => {Get.back(), emit(RegisterFailedState())}, (r) {
      // Get.back();
      if (r.code == 200) {
        registerModel = r;
        errorGetBar(r.message ?? '');

        Preferences.instance.setUser(registerModel).then((value) =>
            {Navigator.pushReplacementNamed(context, Routes.homeRoute)});
        emit(RegisterSuccessState());
      } else if (r.code == 409) {
        //  registerModel = r ;
        emit(RegisterFailedUserExistState());
        errorGetBar('المستخدم موجود بالفعل');
      } else {
        errorGetBar(r.message ?? '');
      }
    });
  }

  checkToken(String deviceToken) async {
    final response = await api.checkToken(deviceToken);
    response.fold((l) => emit(CheckTokenFailedState()), (r) {
      if (r.code == 200) {
        registerModel = r;
        emit(CheckTokenSuccessState());
      } else if (r.code == 409) {
        emit(CheckTokenFailedState());
      } else {
        emit(CheckTokenFailedState());
      }
    });
  }
}
