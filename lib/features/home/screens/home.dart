import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/assets_manager.dart';
import 'package:khadamat/core/widgets/network_image.dart';
import 'package:khadamat/features/home/cubit/home_cubit.dart';
import 'package:khadamat/features/home/cubit/home_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../add services/screens/add_services.dart';
import '../../favorite/screens/favorite_screen.dart';
import '../../notification/screens/notification_screen.dart';
import '../../posts/screens/services_of_categories.dart';
import '../../profile/screens/profile_screen.dart';
import '../widgets/home_page_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<String> titles = [];

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().tabController = TabController(length: 5, vsync: this);
    context.read<HomeCubit>().tabController.animateTo(context.read<HomeCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: SizedBox(),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = context.read<HomeCubit>();

          return Stack(
            children: [
              Positioned(
                top: 0,
                bottom:cubit.currentIndex==4?0: 25,
                left: 0,
                right: 0,
                child: TabBarView(
                  controller: cubit.tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePageWidget(),
                    FavoriteScreen(),
                    AddServicesScreen(),
                    NotificationScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: cubit.currentIndex!=4,
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                        color: AppColors.transparent,
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.topStatusBarImage),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: cubit.currentIndex!=4,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: Container(
                      height: 90,
                      padding: EdgeInsets.only(top: 8, right: 16, left: 16),
                      decoration: BoxDecoration(
                        color: AppColors.transparent,
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.topStatusBarImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.selectTap(0);
                                  // _tabController.animateTo(0);
                                },
                                child: Icon(
                                  Icons.home,
                                  color: cubit.currentIndex == 0
                                      ? AppColors.secondPrimary
                                      : AppColors.gray1,
                                  size: 36,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.selectTap(1);
                                  cubit.tabController.animateTo(1);
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: cubit.currentIndex == 1
                                      ? AppColors.secondPrimary
                                      : AppColors.gray1,
                                  size: 36,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      cubit.selectTap(2);
                                      cubit.tabController.animateTo(2);
                                    },
                                    child: Icon(Icons.add),
                                    elevation: 12,
                                  ),
                                ],
                              ),
                              SizedBox(width: 1),
                              // InkWell(
                              //   onTap: () {
                              //     cubit.selectTap(3);
                              //     cubit.tabController.animateTo(3);
                              //   },
                              //   child: Icon(
                              //     Icons.notifications,
                              //     color: cubit.currentIndex == 3
                              //         ? AppColors.secondPrimary
                              //         : AppColors.gray1,
                              //     size: 36,
                              //   ),
                              // ),
                              InkWell(
                                onTap: () {
                                  cubit.selectTap(4);
                                  cubit.tabController.animateTo(4);
                                },
                                child: Icon(
                                  Icons.person,
                                  color: cubit.currentIndex == 4
                                      ? AppColors.secondPrimary
                                      : AppColors.gray1,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
