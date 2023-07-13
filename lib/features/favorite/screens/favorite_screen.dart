import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:khadamat/core/widgets/post_widget.dart';
import 'package:khadamat/core/widgets/show_loading_indicator.dart';
import 'package:khadamat/features/favorite/cubit/favorite_cubit.dart';
import 'package:khadamat/features/favorite/cubit/favorite_cubit.dart';

import '../../../config/routes/app_routes.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    context.read<FavoriteCubit>().getFavoriteList();
    super.initState();
  }



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
                    color: Colors.white,
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
                     // Text('search'.tr()),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintText: "search".tr()
                        ),
                        onChanged: (value) async {
                         await cubit.getFavouriteSearchList(value);
                        },
                      )),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(
                cubit.modelList.length,
                (index) => InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.detailsRoute,arguments:cubit.modelList[index].service );
                  },
                    child: PostWidget(model: cubit.modelList[index].service!)),
              ),
            ],
          );
        },
      ),
    );
  }
}
