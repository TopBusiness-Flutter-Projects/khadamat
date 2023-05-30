import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../core/utils/assets_manager.dart';
import '../cubit/privacy_cubit.dart';

class PrivacyAbout extends StatelessWidget {
  PrivacyAbout({
    Key? key,
  }) : super(key: key);

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
                  cubit.isPrivacy
                      ? Text(
                          "privacy_about",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "about",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                  cubit.isPrivacy?
                  Text(cubit.settingModel!.data!.privacyAr.toString(),textAlign: TextAlign.center,):
                  Text(cubit.settingModel!.data!.aboutAr.toString(),textAlign: TextAlign.center,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
