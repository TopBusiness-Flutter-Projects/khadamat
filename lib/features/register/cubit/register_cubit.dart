import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial());

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  ServiceApi api;
  late LoginModel registerModel ;
  String phoneCode = '';

  register() async {
    final response =await  api.postRegister(phoneController.text, phoneCode,nameController.text);
    response.fold(
            (l) => emit(RegisterFailedState()),
            (r) {
          if(r.code==200){
            registerModel = r ;
            Preferences.instance.setUser(registerModel);
            emit(RegisterSuccessState());
          }
          else if(r.code==409){
            //  registerModel = r ;
            emit(RegisterFailedUserExistState());
          }

        });
  }
}
