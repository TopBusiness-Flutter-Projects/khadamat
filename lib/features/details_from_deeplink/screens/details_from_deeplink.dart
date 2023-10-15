import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/config/routes/app_routes.dart';
import 'package:khadamat/features/details_from_deeplink/details_deeplink/details_deeplink_cubit.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/show_loading_indicator.dart';

class DetailsFromDeepLink extends StatefulWidget {
  final int? id;

// final ServiceDetails? serviceDetails;

  const DetailsFromDeepLink({super.key, this.id});

  @override
  State<DetailsFromDeepLink> createState() => _DetailsFromDeepLinkState();
}

class _DetailsFromDeepLinkState extends State<DetailsFromDeepLink> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DetailsDeeplinkCubit>().getServiceDetails(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, Routes.homeRoute);
        return true;
      },
      child: BlocConsumer<DetailsDeeplinkCubit, DetailsDeeplinkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          DetailsDeeplinkCubit cubit = context.read<DetailsDeeplinkCubit>();
          return Scaffold(
              body: state is LoadingServiceDetails
                  ? Center(child: ShowLoadingIndicator())
                  : widget.id == 0 && cubit.serviceDetails == null
                      ? Center(
                          child: Text("no details"),
                        )
                      : Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.4,
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
                                            child: ClipOval(
                                              child: ManageNetworkImage(
                                                imageUrl: cubit.serviceDetails!
                                                    .data!.logo!,
                                                width: 116,
                                                height: 116,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Text(cubit.serviceDetails!.data!.name!),
                                    //  Text(cubit.serviceDetails!.data!.categoryId ?? " "),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Text("${cubit.getCityName(service.cityId)}"),
                                          // Text("${ cubit.getAddressFromLatLng(double.parse(service.latitude??"30.0459"), double.parse(service.latitude??"31.2243"))}",),
                                          FutureBuilder(
                                            future: cubit.getAddressFromLatLng(
                                                double.parse(cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .latitude ??
                                                    "30.0459"),
                                                double.parse(cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .latitude ??
                                                    "31.2243")),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: Text(
                                                      "${snapshot.data}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ));
                                              } else {
                                                return Text(
                                                    "No Location Provided");
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await _showDialog(
                                                context,
                                                cubit.serviceDetails!.data!
                                                    .phones![0],
                                                cubit.serviceDetails!.data!
                                                    .phones![1]);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  child: MySvgWidget(
                                                      path:
                                                          ImageAssets.call2Icon,
                                                      imageColor:
                                                          AppColors.white,
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
                                                cubit.serviceDetails!.data!.id);
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child: MySvgWidget(
                                                      path: ImageAssets
                                                          .favouriteIcon,
                                                      imageColor:
                                                          AppColors.white,
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
                                            cubit.shareApplication(
                                                cubit.serviceDetails!.data!.id);
                                            // await Share.share(
                                            //     EndPoints.deepLink + service.id.toString());
                                          },
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                  child: MySvgWidget(
                                                      path:
                                                          ImageAssets.shareIcon,
                                                      imageColor:
                                                          AppColors.white,
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
                                            Navigator.pushNamed(context,
                                                Routes.googleMapDetailsRoute,
                                                arguments: LatLng(
                                                    double.parse(cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .latitude!),
                                                    double.parse(cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .longitude!)));
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
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (double value) {},
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 7),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(1, 9),
                                            ),
                                          ],
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                // "10",
                                                //todo=> return this value from api
                                                cubit.serviceDetails!.data!
                                                        .reviews
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: 1,
                                            height: 30,
                                            color: Colors.grey,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                //todo=> return this value from api
                                                // "20",
                                                cubit.serviceDetails!.data!
                                                        .followers
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            width: 1,
                                            height: 30,
                                            color: Colors.grey,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                // "30",
                                                cubit.serviceDetails!.data!
                                                    .following
                                                    .toString(),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16),
                                      child: Text(
                                        cubit.serviceDetails!.data!.details ??
                                            " ",
                                        // style: TextStyle(
                                        //     fontSize: 23,
                                        //     fontWeight: FontWeight.w400,
                                        //     color: AppColors.gray),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cubit.serviceDetails!.data!
                                            .images?.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              //TODO
                                              Navigator.pushNamed(context,
                                                  Routes.fullScreenImageRoute,
                                                  arguments: cubit
                                                      .serviceDetails!
                                                      .data!
                                                      .images![index]);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: ManageNetworkImage(
                                                width: 100,
                                                borderRadius: 10,
                                                imageUrl: cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .images!
                                                        .isNotEmpty
                                                    ? cubit.serviceDetails!
                                                        .data!.images![index]
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
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
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
                                                TextButton(
                                                  child: Text('rate'.tr()),
                                                  onPressed: () async {
                                                    await cubit.setRate(cubit
                                                        .serviceDetails!
                                                        .data!
                                                        .id);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 25, bottom: 10),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                            color: AppColors.red,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomLeft:
                                                    Radius.circular(25))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                "your_opinion_of_the_service"
                                                    .tr(),
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
                            Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: ClipPath(
                                  clipper: BottomCurveClipper(),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: cubit.serviceDetails!.data!.images!
                                            .isNotEmpty
                                        ? ManageNetworkImage(
                                            imageUrl: cubit.serviceDetails!
                                                .data!.images![0],
                                          )
                                        : Image.asset(
                                            ImageAssets.detailsPlaceholder,
                                          ),
                                  ),
                                ))
                          ],
                        ));
        },
      ),
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
                  // Navigator.of(context).pop();
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('$number2'),
                onTap: () {
                  UrlLauncher.launch("tel://${number2}");
                  // Navigator.of(context).pop('option2');
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
