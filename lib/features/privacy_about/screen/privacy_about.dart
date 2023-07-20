import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter_html/flutter_html.dart';
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
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height/2.8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Image.asset(ImageAssets.khadamatImage)),//todo-->
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
                        cubit.settingModel?.data?.aboutAr==null?CircularProgressIndicator():   Html(data:cubit.settingModel?.data?.aboutAr ),


                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:    Image.asset(ImageAssets.bottomCurve2),)
            ],
          );
        },
      ),
    );
  }
}
