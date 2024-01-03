import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:khadamat/config/routes/app_routes.dart';
import 'package:khadamat/core/preferences/preferences.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/widgets/show_loading_indicator.dart';
import 'package:khadamat/features/contact_us/screen/contact_us.dart';
import 'package:khadamat/features/my_posts/cubit/my_posts_cubit.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../home/cubit/home_cubit.dart';
import '../../privacy_about/cubit/privacy_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_list_tail_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //  Navigator.pop(context);
        context.read<HomeCubit>().selectTap(0);
        context.read<HomeCubit>().tabController.animateTo(0); //
        await Navigator.pushNamed(context, Routes.homeRoute);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            ProfileCubit cubit = context.read<ProfileCubit>();
            if (state is ProfileUserLoading) {
              return ShowLoadingIndicator();
            }
            return Column(
              children: [
                Expanded(
                  // flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                        ),
                        // IconButton(onPressed: (){
                        //   cubit.clearShared();
                        // }, icon: Icon(Icons.remove)),
                        IconButton(
                          onPressed: () {
                            context.read<HomeCubit>().selectTap(0);
                            context
                                .read<HomeCubit>()
                                .tabController
                                .animateTo(0);
                          },
                          icon: Icon(
                            Icons.home,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                        ),
                        // cubit.model?.data?.user?.image!=null ?
                        // ManageNetworkImage(
                        //   imageUrl: cubit.model!.data!.user!.image!,
                        //   height: 130,
                        //   width: 130,
                        //   borderRadius: 130,
                        // ):
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(ImageAssets.profile22Icon)),
                        Text(
                          cubit.model?.data?.user?.name ?? "name",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cubit.model?.data?.user?.phone ?? "phone",
                          style: TextStyle(
                            color: AppColors.gray2,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 25),
                        ProfileListTailWidget(
                          title: 'my_posts'.tr(),
                          onclick: () async {
                            await context.read<MyPostsCubit>().getMyPostsList();
                            Navigator.pushNamed(context, Routes.myPostsRoute);
                          },
                          image: ImageAssets.postImageIcon,
                          imageColor: AppColors.black,
                        ),
                        ProfileListTailWidget(
                          title: 'profile'.tr(),
                          onclick: () {
                            Navigator.pushNamed(
                                context, Routes.editProfileRoute);
                          },
                          image: ImageAssets.profilesImageIcon,
                          imageColor: AppColors.black,
                        ),
                        ProfileListTailWidget(
                          title: 'terms_conditions'.tr(),
                          onclick: () {
                            context.read<PrivacyCubit>().isPrivacy = true;
                            Navigator.pushNamed(
                              context,
                              Routes.privacyRoute,
                            );
                          },
                          image: ImageAssets.settingImageIcon,
                          imageColor: AppColors.black,
                        ),
                        ProfileListTailWidget(
                          title: 'call'.tr(),
                          onclick: () {
                            Navigator.pushNamed(context, Routes.contactUsRoute);
                     
                            // var dialNumber = context.read<PrivacyCubit>().settingModel!.data!.whatsapp??0100000000;
                            //    UrlLauncher.launch("tel://${dialNumber}");
                          },
                          image: ImageAssets.callsImageIcon,
                          imageColor: AppColors.black,
                        ),
                        ProfileListTailWidget(
                          title: 'about_app'.tr(),
                          onclick: () {
                            context.read<PrivacyCubit>().isPrivacy = false;
                            Navigator.pushNamed(
                              context,
                              Routes.privacyRoute,
                            );
                          },
                          image: ImageAssets.aboutImageIcon,
                          imageColor: AppColors.black,
                        ),
                        ProfileListTailWidget(
                          title: 'logout'.tr(),
                          onclick: () async {
                            await Preferences.instance.clearShared();

                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          image: ImageAssets.profilesImageIcon,
                          imageColor: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Image.asset(ImageAssets.bottomCurve2), //todo------->

                    // Positioned(
                    //     bottom: 50,
                    //     top: 50,
                    //     right: 50,
                    //     left: 50,
                    //     child: Image.asset(ImageAssets.logoImage,)),
                  ],
                )
                // Expanded(
                //   flex: 2,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Stack(
                //           children: [
                //             Positioned(
                //               top: 0,
                //               bottom: 0,
                //               right: 0,
                //               left: 0,
                //               child: Image.asset(
                //                 ImageAssets.introBackgroundImage,
                //                 fit: BoxFit.cover,
                //                 width: MediaQuery.of(context).size.width,
                //               ),
                //             ),
                //             Positioned(
                //               top: 0,
                //               bottom: 0,
                //               right: 0,
                //               left: 0,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Image.asset(ImageAssets.logoImage,height: 100,width: 100,),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
