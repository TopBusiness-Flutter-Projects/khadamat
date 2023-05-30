import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/dialogs.dart';
import '../../login/cubit/login_cubit.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.api) : super(EditProfileInitial()){
  getUserData();
  }

  final ServiceApi api;
  TextEditingController nameController = TextEditingController();

  LoginModel? model ;
  getUserData()async{
    model =await Preferences.instance.getUserModel();
  }

  updateProfile() async {

    emit(EditProfileLoadingState());
    final response = await api.postEditProfile(nameController.text,model!.data!.user!.phone!);
    response.fold(
          (l) {
        Get.back();

        emit(EditProfileFailedState());
      },
          (r) {
        Get.back();

        if (r.code == 200) {
          model = r;
          Get.toNamed( Routes.homeRoute);
          Preferences.instance.setUser(r);

          // sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
        }
        //todo
        else if (r.code == 422) {
          errorGetBar('لا يوجد حساب مرتبط بهذا الهاتف');
        } else {
          errorGetBar('هناك خطئ حاول فى وقت لاحق');
        }
        emit(EditProfileLoadingState());
      },
    );
  }
  // setUserNewName() async {
  //   emit(EditProfileLoadingState());
  //   model?.data?.user?.name = nameController.text;
  //   print("&&&&&&&&& ${model?.data?.user?.name}");
  //   final response = await api.postEditProfile(nameController.text);
  //   print("_____________________ $response");
  //   if(response.code==200){
  //     emit(EditProfileSuccessState());
  //     await Preferences.instance.setUser(model!);
  //   }
  //   else{
  //     emit(EditProfileFailedState());
  //   }
  //
  //
  //
  //
  // }
}
