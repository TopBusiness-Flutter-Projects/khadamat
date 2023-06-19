import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/config/routes/app_routes.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/post_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/my_posts_cubit.dart';
import 'my_post_widget.dart';

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
                      Expanded(
                        child: TextField(
                          onChanged: (value) async {
                          await  cubit.getMyPostsSearchList(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(
                cubit.modelList.length,
                    (index) => InkWell(
                      onTap: () {
                       // print(cubit.modelList[index].name);
                         Navigator.pushNamed(context, Routes.details1Route,arguments:cubit.modelList[index] );
                      },
                        child: MyPostWidget(model: cubit.modelList[index])),
              ),
            ],
          );
        },
      ),
    );
  }
}
