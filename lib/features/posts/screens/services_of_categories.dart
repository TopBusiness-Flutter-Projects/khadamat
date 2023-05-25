import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/widgets/post_widget.dart';
import 'package:khadamat/core/widgets/show_loading_indicator.dart';
import 'package:khadamat/features/posts/cubit/posts_cubit.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';

class ServicesOfCategories extends StatefulWidget {
  const ServicesOfCategories({Key? key, required this.catId}) : super(key: key);
  final int catId;

  @override
  State<ServicesOfCategories> createState() => _ServicesOfCategoriesState();
}

class _ServicesOfCategoriesState extends State<ServicesOfCategories> {
  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().getServicesPosts(widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                PostsCubit cubit = context.read<PostsCubit>();
                if (state is PostsServicesLoading) {
                  return ShowLoadingIndicator();
                }
                return ListView(
                  children: [
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
                    SizedBox(height: 20),
                    ...List.generate(
                      cubit.servicesList.length,
                      (index) => PostWidget(model: cubit.servicesList[index]),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
        ],
      ),
    );
  }
}
