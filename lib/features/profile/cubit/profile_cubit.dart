
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';
import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial()){
    getUserData();
  }
  final ServiceApi api;
  LoginModel? model ;
  TextEditingController nameController = TextEditingController();

  getUserData()async{
    emit(ProfileUserLoading());
    model =await Preferences.instance.getUserModel();
    emit(ProfileUserSuccess());
  }

  updateTheProfile( context) async {
    emit(EditProfileLoadingState());
    final response = await api.postEditProfile(nameController.text,);
    response.fold(
            (l) => emit(EditProfileFailedState()),
            (r) async {
          model = r;
          await Preferences.instance.setUser(model!);
           await getUserData();
          emit(EditProfileSuccessState());
          Get.back();
        });
  }


}
