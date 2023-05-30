import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/post_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/my_posts_cubit.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyPostsCubit, MyPostsState>(
        builder: (context, state) {
          MyPostsCubit cubit = context.read<MyPostsCubit>();
          if(state is MyPostsLoading){
            return ShowLoadingIndicator();
          }

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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                cubit.modelList.length,
                    (index) => PostWidget(model: cubit.modelList[index].service!),
              ),
            ],
          );
        },
      ),
    );
  }
}
