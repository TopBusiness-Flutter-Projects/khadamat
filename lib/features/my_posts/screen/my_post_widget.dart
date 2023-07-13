
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import '../../../core/models/servicemodel.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/network_image.dart';
import '../../add services/screens/add_services.dart';
import '../cubit/my_posts_cubit.dart';


class MyPostWidget extends StatelessWidget {
  const MyPostWidget({Key? key, required this.model}) : super(key: key);

  final ServicesModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPostsCubit, MyPostsState>(
      builder: (context, state) {
        MyPostsCubit cubit = context.read<MyPostsCubit>();
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

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.star,
                                    size: 25,
                                    color: index + 1 <= model.rate!
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  //loadingDialog();
                                 cubit.setData(context,model);
                                 context.read<AddServiceCubit>().isUpdate = true;
                             // await cubit.updateAd(model.id!,);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                return AddServicesScreen(id: model.id,);
                              },));
                              },
                                icon: Icon(
                                  Icons.edit, color: AppColors.blueTextColor,),
                              ),

                            ],
                          ),
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
                        ],
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
                              imageUrl:
                              model.logo!,
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


  // // convert a List<String> to List<XFile?>
  // Future<List<XFile?>> convertStringListToXFileList(List<String>? stringList) async {
  //   if (stringList == null) return [];
  //
  //   List<XFile?> xFileList = [];
  //   for (String imageUrl in stringList) {
  //    var imagePath = await downloadAndSaveFile(imageUrl);
  //     XFile? xFile = XFile(imagePath!);
  //     xFileList.add(xFile);
  //   }
  //   return xFileList;
  // }
  // //Here's an example of how you can download a file from a URL and save it locally
  // Future<String?> downloadAndSaveFile(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //
  //   final file = File('${documentDirectory.path}/filename.png');
  //   await file.writeAsBytes(response.bodyBytes);
  //
  //   return file.path;
  // }
}