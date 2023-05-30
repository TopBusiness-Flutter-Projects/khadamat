import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/config/routes/app_routes.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/widgets/show_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../home/cubit/home_cubit.dart';
import '../../privacy_about/cubit/privacy_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_list_tail_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          ProfileCubit cubit = context.read<ProfileCubit>();
          if (state is ProfileUserLoading) {
            return ShowLoadingIndicator();
          }
          return Column(
            children: [
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                      ),
                      IconButton(onPressed: (){
                        context.read<HomeCubit>().selectTap(0);
                        context.read<HomeCubit>().tabController.animateTo(0);
                      }, icon: Icon(Icons.home,color: AppColors.primary,size: 40,),),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 10,
                      ),
                      ManageNetworkImage(
                        imageUrl: cubit.model!.data!.user!.image!,
                        height: 130,
                        width: 130,
                        borderRadius: 130,
                      ),
                      Text(
                        cubit.model!.data!.user!.name!,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cubit.model!.data!.user!.email!,
                        style: TextStyle(
                          color: AppColors.gray2,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 25),
                      ProfileListTailWidget(
                        title: 'my_posts'.tr(),
                        onclick: () {
                          Navigator.pushNamed(context, Routes.myPostsRoute);
                        },
                        image: ImageAssets.postImageIcon,
                        imageColor: AppColors.black,
                      ),
                      ProfileListTailWidget(
                        title: 'profile'.tr(),
                        onclick: () {
                          Navigator.pushNamed(context, Routes.editProfileRoute);
                        },
                        image: ImageAssets.profilesImageIcon,
                        imageColor: AppColors.black,
                      ),
                      ProfileListTailWidget(
                        title: 'setting'.tr(),
                        onclick: () {
                          context.read<PrivacyCubit>().isPrivacy = true;
                          Navigator.pushNamed(context, Routes.privacyRoute,);
                        },
                        image: ImageAssets.settingImageIcon,
                        imageColor: AppColors.black,
                      ),
                      ProfileListTailWidget(
                        title: 'call'.tr(),
                        onclick: () {
                          //todo
                       var dialNumber = context.read<PrivacyCubit>().settingModel!.data!.whatsapp??0100000000;
                          UrlLauncher.launch("tel://${dialNumber}");
                        },
                        image: ImageAssets.callsImageIcon,
                        imageColor: AppColors.black,
                      ),
                      ProfileListTailWidget(
                        title: 'about_app'.tr(),
                        onclick: () {
                          context.read<PrivacyCubit>().isPrivacy = false;
                          Navigator.pushNamed(context, Routes.privacyRoute,);
                        },
                        image: ImageAssets.aboutImageIcon,
                        imageColor: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Image.asset(
                              ImageAssets.introBackgroundImage,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImageAssets.logoImage,height: 100,width: 100,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
