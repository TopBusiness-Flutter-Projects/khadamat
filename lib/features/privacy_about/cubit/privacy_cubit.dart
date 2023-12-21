import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:khadamat/core/models/setting_model.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/login_model.dart';
import '../../../core/remote/service.dart';

part 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit(this.api) : super(PrivacyInitial()) {
    getPrivacyData();
  }

  bool isPrivacy = true;
  final ServiceApi api;
  var soup;
  SettingModel? settingModel;
  String email = "";

  getPrivacyData() async {
    final response = await api.getSettingData();
    response.fold(
      (l) => emit(PrivacyError()),
      (r) {
        settingModel = r;
        // soup = BeautifulSoup(r.data!.aboutAr!);
        emit(PrivacyLoading());
      },
    );
  }

  toLaunchURL() async {
    final Email email = Email(
      subject: "message",
      recipients: [settingModel!.data!.email!],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
    // final url =
    // Uri.encodeFull('mailto:${settingModel!.data!.email}?subject=News&body=New plugin');
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   //throw 'Could not launch $url';
    // }
  }

  lanchUrlSocial({required String url}) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
