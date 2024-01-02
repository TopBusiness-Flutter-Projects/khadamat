import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "الاتصال بإدارة تطبيق خدمات",
                    // "contact_management".tr,
                    style: TextStyle(
                        color: AppColors.blue4,
                        fontWeight: FontWeight.w500,
                        fontSize: 35),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "يمكنك الاتصال مع إدارة تطبيق خدمات لتقديم الدعم والمساعدة والاقتراحات من خلال بيانات الاتصال التالية",
                    // 'you_can_contact'.tr,
                    style: TextStyle(
                        color: AppColors.blue4,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: MediaQuery.of(context).size.width / 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.settingModel?.data?.phones?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              UrlLauncher.launchUrl(Uri.parse(
                                  "tel://${cubit.settingModel?.data?.phones?[index]}"));
                            },
                            child: PhoneWidget(
                                phone:
                                    cubit.settingModel?.data?.phones?[index]));
                      },
                    ),
                  ),
                ),
                Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cubit.settingModel?.data?.facebook == null
                          ? ContactUs()
                          : IconButton(
                              onPressed: () async {
                                await cubit.lanchUrlSocial(
                                    url: cubit.settingModel?.data?.facebook);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              )),
                      cubit.settingModel?.data?.youtube == null
                          ? ContactUs()
                          : IconButton(
                              onPressed: () async {
                                await cubit.lanchUrlSocial(
                                    url: cubit.settingModel?.data?.youtube);
                              },
                              icon: FaIcon(FontAwesomeIcons.youtube,
                                  color: Colors.red)),
                      cubit.settingModel?.data?.instagram == null
                          ? ContactUs()
                          : IconButton(
                              onPressed: () async {
                                await cubit.lanchUrlSocial(
                                    url: cubit.settingModel?.data?.instagram);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Color(0xffc13584),
                              )),
                      cubit.settingModel?.data?.whatsapp == null
                          ? ContactUs()
                          : IconButton(
                              onPressed: () async {
                                await cubit.lanchUrlSocial(
                                    url: cubit.settingModel?.data?.whatsapp);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                              ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("كما يمكنك مراسلتنا على الايميل الرسمي للإدارة"),
                ),
                InkWell(
                    onTap: () async {
                      print("******************************");
                      print("${cubit.settingModel?.data?.email}");
                      //TODO
                      await cubit.toLaunchURL();
                      // UrlLauncher.launchUrl(Uri.parse('mailto:${cubit.settingModel?.data?.email}?subject=Hello%20World&body=I%20just%20wanted%20to%20say%20hi!'));
                    },
                    child: Text("${cubit.settingModel?.data?.email}")),
                Image.asset(ImageAssets.bottomCurve2)
              ],
            ),
          ),
        );
      },
    );
  }
}
