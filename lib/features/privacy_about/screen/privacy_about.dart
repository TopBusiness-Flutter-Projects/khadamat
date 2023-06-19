import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/utils/assets_manager.dart';
import '../cubit/privacy_cubit.dart';

class PrivacyAbout extends StatefulWidget {
  PrivacyAbout({
    Key? key,
  }) : super(key: key);

  @override
  State<PrivacyAbout> createState() => _PrivacyAboutState();
}

class _PrivacyAboutState extends State<PrivacyAbout> {

  @override
  void initState() {
    context.read<PrivacyCubit>().getPrivacyData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: SizedBox(),
      ),
      body: BlocBuilder<PrivacyCubit, PrivacyState>(
        builder: (context, state) {
          PrivacyCubit cubit = context.read<PrivacyCubit>();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.topStatusBarImage),
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    width: 150,
                      child: Image.asset(ImageAssets.khadamatImage)),
                  SizedBox(height: 15,),
                  cubit.isPrivacy
                      ? Text(
                          "privacy",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                        ).tr()
                      : Text(
                          "about",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                        ).tr(),
                  cubit.isPrivacy?
                  Text("${cubit.settingModel?.data?.privacyAr}",textAlign: TextAlign.center,):
                  Text("${cubit.settingModel?.data?.aboutAr}",textAlign: TextAlign.center,),
                  Image.asset(ImageAssets.privacyImage)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
