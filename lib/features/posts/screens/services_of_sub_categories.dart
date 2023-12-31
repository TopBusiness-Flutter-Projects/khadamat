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
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServicesOfCategories(
                                      catId: cubit.subCategories[index].catId!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: Offset(3, 4))
                                    ],
                                    border: Border.all(
                                        color: Colors.grey.shade50, width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    cubit.subCategories[index].name ?? '',
                                    style: TextStyle(color: AppColors.primary),
                                  )),
                            );
                          },
                          itemCount: cubit.subCategories.length,
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