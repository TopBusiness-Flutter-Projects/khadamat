import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:khadamat/features/profile/cubit/profile_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';


class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     String lang = oo.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.introBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              ProfileCubit cubit = context.read<ProfileCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'logo',
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(ImageAssets.logoImage),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: AppColors.primary,
                                size: 35,
                              ),
                              SizedBox(width: 0),
                              Expanded(
                                child: TextField(
                                  controller:cubit.nameController,
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: AppColors.secondPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'username'.tr(),
                                    fillColor: AppColors.white,

                                ),

                              ),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 120),
                      CustomButton(
                        text: 'done_btn'.tr(),
                        color: AppColors.primary,
                        paddingHorizontal: 80,
                        borderRadius: 20,
                        onClick: () async {
                      await cubit.updateTheProfile(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
