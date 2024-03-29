import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/features/favorite/cubit/favorite_cubit.dart';
import '../models/servicemodel.dart';
import '../utils/app_colors.dart';
import 'network_image.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key, required this.model}) : super(key: key);

  final ServicesModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        FavoriteCubit cubit = context.read<FavoriteCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppColors.black,
                width: 1,
              ),
              color: AppColors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              model.name!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ...List.generate(
                              5,
                              (index) {
                                print(index);
                                print(model.rate);
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.star,
                                    size: 25,
                                    color: model.rate != null &&
                                            index + 1 <= model.rate!
                                        ? AppColors.goldStarColor
                                        : AppColors.hint,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Column(
                          //   children: [
                          //     Text(
                          //       model.following.toString(),
                          //       style: TextStyle(
                          //         color: AppColors.blueTextColor,
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     Text(
                          //       'following'.tr(),
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         color: AppColors.grayTextColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Column(
                            children: [
                              Text(
                                model.followers.toString(),
                                style: TextStyle(
                                  color: AppColors.blueTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'followers'.tr(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.grayTextColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                model.reviews.toString(),
                                style: TextStyle(
                                  color: AppColors.blueTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'reviews'.tr(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.grayTextColor,
                                ),
                              ),
                            ],
                          ),

                          //!
                        ],
                      ),
                      model.cityName == null
                          ? Container()
                          : Container(
                              width: double.infinity,
                              child: Text(
                                "المدينه : ${model.cityName!}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: ClipOval(
                            child: ManageNetworkImage(
                              imageUrl: model.logo!,
                              width: 160,
                              height: 160,
                              borderRadius: 140,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
