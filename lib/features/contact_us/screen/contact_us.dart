import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:khadamat/features/edit_profile/screen/widget/phone_widget.dart';
import 'package:khadamat/features/privacy_about/cubit/privacy_cubit.dart';
import 'package:khadamat/features/privacy_about/cubit/privacy_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyCubit, PrivacyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        PrivacyCubit cubit = context.read<PrivacyCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 7),
              child: Column(
                children: [
                  Text(
                    "الاتصال بإدارة تطبيق خدمات",
                    // "contact_management".tr,
                    style: TextStyle(
                        color: AppColors.blue4,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "يمكنك الاتصال مع إدارة تطبيق خدمات لتقديم الدعم والمساعدة والاقتراحات من خلال بيانات الاتصال التالية",
                    // 'you_can_contact'.tr,
                    style: TextStyle(
                        color: AppColors.blue4,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: cubit.settingModel?.data?.phones?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            UrlLauncher.launchUrl(Uri.parse("tel://${cubit.settingModel?.data?.phones?[index]}"));
                          },
                          child: PhoneWidget(
                              phone: cubit.settingModel?.data?.phones?[index]));
                    },
                  )),
                  Text("كما يمكنك مراسلتنا على الايميل الرسمي للإدارة"),
                  InkWell(
                    onTap: () async {
                      print("******************************");
                      print("${cubit.settingModel?.data?.email}");
                      //TODO
                    await  cubit.toLaunchURL();
                     // UrlLauncher.launchUrl(Uri.parse('mailto:${cubit.settingModel?.data?.email}?subject=Hello%20World&body=I%20just%20wanted%20to%20say%20hi!'));
                    },
                      child: Text("${cubit.settingModel?.data?.email}")),
                  Stack(
                    children: [
                      Image.asset(ImageAssets.bottomCurveImage),

                      Positioned(
                          bottom: 50,
                          top: 50,
                          right: 50,
                          left: 50,
                          child: Image.asset(ImageAssets.logoImage,)),
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
