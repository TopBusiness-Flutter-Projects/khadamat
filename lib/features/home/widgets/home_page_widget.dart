import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/features/home/cubit/home_cubit.dart';
import 'package:khadamat/features/home/cubit/home_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/network_image.dart';
import '../../posts/screens/services_of_categories.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = context.read<HomeCubit>();
        return ListView(
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.gray,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('search'.tr()),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'last_added'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          state is HomeLoading
                              ? 5
                              : cubit.lastAddServices.length,
                              (index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: state is HomeLoading
                                    ? SizedBox(
                                  height: 130,
                                  width: 130,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color:
                                        AppColors.secondPrimary,
                                      ),
                                    ],
                                  ),
                                )
                                    : ManageNetworkImage(
                                  imageUrl: cubit
                                      .lastAddServices[index].logo!,
                                  height: 130,
                                  width: 130,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'choose_services'.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 12),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      mainAxisSpacing: 1,
                      crossAxisCount: 3,
                    ),
                    itemCount: state is HomeLoading
                        ? 5
                        : cubit.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                              borderRadius: BorderRadius.circular(12)),
                          child: state is HomeLoading
                              ? SizedBox(
                            height: 90,
                            width: 90,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.secondPrimary,
                                ),
                              ],
                            ),
                          )
                              : InkWell(
                            onTap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ServicesOfCategories(
                                          catId:
                                          cubit.categories[index].id!,
                                        ),
                                  ),
                                ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 5,
                                  bottom: 5,
                                  left: 5,
                                  right: 5,
                                  child: ManageNetworkImage(
                                    imageUrl: cubit
                                        .categories[index].image!,
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(12),
                                        bottomRight:
                                        Radius.circular(12),
                                      ),
                                      color: AppColors.gray4,
                                    ),
                                    child: Center(
                                      child: Text(
                                        cubit.categories[index]
                                            .name!,
                                        style: TextStyle(
                                            color:
                                            AppColors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
