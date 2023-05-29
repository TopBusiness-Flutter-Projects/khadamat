import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khadamat/core/widgets/post_widget.dart';
import 'package:khadamat/core/widgets/show_loading_indicator.dart';
import 'package:khadamat/features/favorite/cubit/favorite_cubit.dart';
import 'package:khadamat/features/favorite/cubit/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          FavoriteCubit cubit = context.read<FavoriteCubit>();
          if(state is FavoriteLoading){
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
