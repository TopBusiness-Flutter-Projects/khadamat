import 'package:bloc/bloc.dart';
import 'package:khadamat/core/models/setting_model.dart';
import 'package:meta/meta.dart';

import '../../../core/models/login_model.dart';
import '../../../core/remote/service.dart';

part 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit(this.api) : super(PrivacyInitial()){

    getPrivacyData();
  }

  bool isPrivacy = true;
  final ServiceApi api;

  SettingModel? settingModel;

  getPrivacyData() async {
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    final response = await api.getSettingData();
    response.fold(
          (l) => emit(PrivacyError()),
          (r) {
            settingModel = r;
        print("__________________________");
        print("${r.data}");
        emit(PrivacyLoading());
      },
    );
  }



  getAboutData(){}

}
