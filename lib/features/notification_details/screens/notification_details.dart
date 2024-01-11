import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/widgets/my_svg_widget.dart';
import 'package:khadamat/core/widgets/network_image.dart';
import 'package:khadamat/features/notification_details/cubit/notification_details_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/api/end_points.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/utils/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:share/share.dart';
import 'package:flutter/services.dart' show PlatformException, MethodChannel;

import '../../../core/utils/get_city_name_method.dart';

class NotificationDetailsScreen extends StatelessWidget {
  NotificationDatum? notificationModel;

  NotificationDetailsScreen({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationDetailsCubit, NotificationDetailsState>(
      listener: (context, state) {
        if (state is RateSuccess) {
          Fluttertoast.showToast(
            msg: "تم الاضافه التقيم بنجاح",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        if (state is AddFavouriteSuccess) {
          Fluttertoast.showToast(
            msg: "تم الاضافه للمفضله",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      },
      builder: (context, state) {
        NotificationDetailsCubit cubit =
            context.read<NotificationDetailsCubit>();
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                bottom: 0,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 61,
                        backgroundColor: AppColors.avatarColor,
                        child: CircleAvatar(
                          radius: 59,
                          backgroundColor: AppColors.avatarColor,
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: AppColors.white,
                            child: notificationModel!.service == null
                                ? Container()
                                : ClipOval(
                                    child: ManageNetworkImage(
                                      imageUrl:
                                          notificationModel!.service!.logo ??
                                              '',
                                      width: 116,
                                      height: 116,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      // Text(notificationModel.title!),
                      Text(
                        notificationModel!.body ?? "",
                        textAlign: TextAlign.center,
                      ),
                      //  Text(notificationModel.service?.cityName??" "),
                      notificationModel!.service == null
                          ? Container()
                          : SizedBox(
                              height: 30,
                              child: FutureBuilder(
                                future: getAddressFromLatLng(
                                    double.parse(
                                        notificationModel?.service?.latitude ??
                                            "37.773972"),
                                    double.parse(
                                        notificationModel?.service?.longitude ??
                                            "-122.431297")),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Text(
                                        "${snapshot.data}",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return Text("No Location Provided");
                                  }
                                },
                              ),
                            ),

                      notificationModel!.service == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await _showDialog(
                                        context,
                                        notificationModel
                                                ?.service!.phones?[0] ??
                                            "201099604045",
                                        notificationModel
                                                ?.service!.phones?[1] ??
                                            "201099604045");
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: MySvgWidget(
                                              path: ImageAssets.call2Icon,
                                              imageColor: AppColors.white,
                                              size: 25)),
                                      Text("call2".tr()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await cubit.addToFavourite(
                                        notificationModel?.serviceId);
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: MySvgWidget(
                                              path: ImageAssets.favouriteIcon,
                                              imageColor: AppColors.white,
                                              size: 25)),
                                      Text("favourite".tr()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    //  await cubit.shareDeepLink();
                                    cubit.shareApplication(
                                        notificationModel?.id);
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.blueAccent,
                                          child: MySvgWidget(
                                              path: ImageAssets.shareIcon,
                                              imageColor: AppColors.white,
                                              size: 25)),
                                      Text("share".tr()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.googleMapDetailsRoute,
                                        arguments: LatLng(
                                            double.parse(notificationModel
                                                    ?.service?.latitude ??
                                                '0'),
                                            double.parse(notificationModel
                                                    ?.service?.longitude ??
                                                '0')));
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.cyan,
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                          )),
                                      Text("location".tr()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: cubit.rateValue.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(1, 9),
                              ),
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            notificationModel!.service == null
                                ? Container()
                                : Column(
                                    children: [
                                      Text(
                                        notificationModel?.service?.reviews
                                                .toString() ??
                                            "10",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.blueAccent),
                                      ),
                                      Text(
                                        "reviews",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: AppColors.gray),
                                      )
                                    ],
                                  ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                            notificationModel!.service == null
                                ? Container()
                                : Column(
                                    children: [
                                      Text(
                                        notificationModel?.service?.followers
                                                .toString() ??
                                            "10",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.blueAccent),
                                      ),
                                      Text(
                                        "followers",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: AppColors.gray),
                                      )
                                    ],
                                  ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: 1,
                              height: 30,
                              color: Colors.grey,
                            ),
                            notificationModel!.service == null
                                ? Container()
                                : Column(
                                    children: [
                                      Text(
                                        notificationModel?.service?.following
                                                .toString() ??
                                            "10",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.blueAccent),
                                      ),
                                      Text(
                                        "following",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                            color: AppColors.gray),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      notificationModel!.service == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: Text(
                                notificationModel?.service?.details ?? " ",
                                // style: TextStyle(
                                //     fontSize: 23,
                                //     fontWeight: FontWeight.w400,
                                //     color: AppColors.gray),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                      notificationModel!.service == null
                          ? Container()
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    notificationModel?.service?.images?.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      //TODO
                                      Navigator.pushNamed(
                                          context, Routes.fullScreenImageRoute,
                                          arguments: notificationModel
                                              ?.service?.images![index]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ManageNetworkImage(
                                        width: 100,
                                        borderRadius: 10,
                                        imageUrl: notificationModel!
                                                .service!.images!.isNotEmpty
                                            ? notificationModel!
                                                .service!.images![index]
                                            : "https://picsum.photos/200",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('add_rate'.tr()),
                                content: RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    cubit.rateValue = rating;
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('close'.tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  notificationModel!.service == null
                                      ? Container()
                                      : TextButton(
                                          child: Text('rate'.tr()),
                                          onPressed: () async {
                                            await cubit.setRate(
                                                notificationModel!.serviceId);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 25, bottom: 10),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "service_evaluation".tr(),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "your_opinion_of_the_service".tr(),
                                  style: TextStyle(
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //first clip path with image
              notificationModel!.service == null
                  ? Container()
                  : Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: ClipPath(
                        clipper: BottomCurveClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: notificationModel!.service!.images!.isNotEmpty
                              ? ManageNetworkImage(
                                  imageUrl:
                                      notificationModel!.service!.images![0],
                                )
                              : Image.asset(
                                  ImageAssets.detailsPlaceholder,
                                ),
                        ),
                      ))
            ],
          ),
        );
      },
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var h = size.height;
    var w = size.width;
    path.lineTo(0, h); //points 1,2

    path.quadraticBezierTo(w * 0.25, h * 0.75, w * 0.4, h * 0.9); //points 3,4

    path.quadraticBezierTo(w * 0.5, h, w * 0.6, h * 0.9); //points 5,6

    path.quadraticBezierTo(w * 0.75, h * 0.75, w, h); //points 7,8

    path.lineTo(w, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Future<void> _showDialog(context, String number1, String number2) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose a number To Call'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('$number1'),
                onTap: () {
                  UrlLauncher.launch("tel://${number1}");
                  Navigator.of(context).pop();
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('$number2'),
                onTap: () {
                  UrlLauncher.launch("tel://${number2}");
                  Navigator.of(context).pop('option2');
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void shareDeepLink() {
  // Generate your deep link URL
  String deepLink = '${EndPoints.deepLink}://';

  // Share the deep link using the Share package
  Share.share(deepLink);
}
