import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/posts_cubit.dart';
import 'services_of_categories.dart';

// ignore: must_be_immutable
class ServicesOfSubCategories extends StatefulWidget {
  ServicesOfSubCategories({super.key, required this.subCategoryId});
  int subCategoryId;
  @override
  State<ServicesOfSubCategories> createState() =>
      _ServicesOfSubCategoriesState();
}

class _ServicesOfSubCategoriesState extends State<ServicesOfSubCategories> {
  @override
  void initState() {
    BlocProvider.of<PostsCubit>(context)
        .searchSSubCategory(catId: widget.subCategoryId);
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is SubServicesLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<PostsCubit>();
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,
          body: isLoading
              ? ShowLoadingIndicator()
              : Stack(
                  children: [
                    Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView(
                          children: [
                            SizedBox(height: 20),
                            ...List.generate(
                              cubit.servicesList.length,
                              (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServicesOfCategories(
                                          catId: cubit.subCategories[index].id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ServicesOfCategories(
                                                catId: cubit
                                                    .subCategories[index]
                                                    .catId!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.primary),
                                            child: Text(cubit
                                                .subCategories[index].name!)),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )),
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
      },
    );
  }
}
//on tab nav to subCategory