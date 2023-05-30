import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/login_model.dart';
import '../../../core/preferences/preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()){
    getUserData();
  }

  LoginModel? model ;

  getUserData()async{
    emit(ProfileUserLoading());
    model =await Preferences.instance.getUserModel();
    emit(ProfileUserSuccess());
  }

}
