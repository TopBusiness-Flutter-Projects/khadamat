import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.api) : super(EditProfileInitial()){
  getUserData();
  }

  final ServiceApi api;
  TextEditingController nameController = TextEditingController();

  LoginModel? model ;
  getUserData()async{
    emit(EditProfileLoadingState());
    model =await Preferences.instance.getUserModel();
    emit(EditProfileSuccessState());
  }
  setUserNewName() async {
    model?.data?.user?.name = nameController.text;
    await Preferences.instance.setUser(model!);
  }
}
