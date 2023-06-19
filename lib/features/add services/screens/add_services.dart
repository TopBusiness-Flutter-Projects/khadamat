import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat/core/models/categories_model.dart';
import 'package:khadamat/core/models/service_model.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/utils/assets_manager.dart';
import 'package:khadamat/core/widgets/custom_button.dart';
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import 'package:khadamat/features/add%20services/screens/category_drop_down.dart';
import 'package:khadamat/features/home/cubit/home_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/features/my_posts/cubit/my_posts_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/network_image.dart';
import '../../google_map/cubit/google_maps_cubit.dart';
import '../../google_map/screens/google_map.dart';

class AddServicesScreen extends StatelessWidget {
   AddServicesScreen({Key? key,this.isUpdate=false,this.id=0}) : super(key: key);
  bool? isUpdate ;
  int?id;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {
          if(state is StoreServiceSuccess){
            context.read<HomeCubit>().selectTap(0);
            context.read<HomeCubit>().getHomeData();
           // Navigator.pushNamed(context, Routes.homeRoute);
          }
        },
        builder: (context, state) {
          AddServiceCubit cubit = context.read<AddServiceCubit>();
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key:formKey ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 18),
                      child: Text(
                        "name".tr(),
                      ),
                    ),
                    CustomTextField(
                      title: 'name'.tr(),
                      backgroundColor: AppColors.white,
                      textInputType: TextInputType.text,
                      controller: cubit.nameController,
                      validatorMessage: 'name_valid'.tr(),
                    ),
                    Divider(
                      thickness: 2,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 18.0, ),
                      child: Text(
                        "location".tr(),
                      ),
                    ),
                    CustomTextField(
                      title: 'location'.tr(),
                      backgroundColor: AppColors.white,
                      textInputType: TextInputType.text,
                       controller:cubit.locationController ,
                      //validatorMessage: 'location_valid'.tr(),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: Text("activity_type".tr()),
                        ),

                        SizedBox(
                          width: size.width * 0.68,
                          child:
                          CategoryDropDown(
                            hint: "kind of activity",
                            dropdownValue: cubit.currentCategory,
                            items: cubit.categories,
                            onChanged: (CategoriesDatum? newValue) async {
                              cubit.changeCategoryName(newValue!);
                            },),

                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: Text("city".tr()),
                        ),

                        SizedBox(
                          width: size.width * 0.68,
                          child:
                          CitiesDropDown(
                            hint: "city",
                            dropdownValue: cubit.currentCity,
                            items: cubit.cities,
                            onChanged: ( newValue) async {
                              cubit.changeCityName(newValue!);
                            },),

                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 18.0,
                      ),
                      child: Text("contact_numbers".tr()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: Text("contact_number1".tr()),
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          child: CustomTextField(
                            title: 'contact_number1'.tr(),
                            backgroundColor: AppColors.white,
                            textInputType: TextInputType.number,
                             controller:cubit.contact1Controller ,
                            validatorMessage: 'contact_valid'.tr(),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: Text("contact_number2".tr()),
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          child: CustomTextField(
                            title: 'contact_number2'.tr(),
                            backgroundColor: AppColors.white,
                            textInputType: TextInputType.number,
                             controller: cubit.contact2Controller,
                            validatorMessage: 'contact_valid'.tr(),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 18.0,
                      ),
                      child: Text("Service_details".tr()),
                    ),
                    SizedBox(
                      child:
                      CustomTextField(
                        minLine: 13,
                        contentPadding: EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                        title: ' ',
                        backgroundColor: AppColors.white,
                        textInputType: TextInputType.text,
                         controller:cubit.detailsController ,
                        validatorMessage: 'details_valid'.tr(),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("download_service_logo".tr()),
                            ],
                          ),
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: InkWell(
                              onTap: () async {
                                await cubit.logoImagePicker(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                child:
                                ClipOval(
                                  child:
                                  ManageNetworkImage(
                                    imageUrl:cubit.serviceLogoImage!=null?
                                    cubit.serviceLogoImage!.path:"https://thumbs.dreamstime.com/z/businessman-presenting-word-service-against-glowing-swirl-black-background-39232296.jpg",
                                    width: 160,
                                    height: 160,
                                    borderRadius: 140,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("add_location".tr()),
                              Text("${cubit.placeToBack?.street} ,${cubit.placeToBack?.country}",style: TextStyle(color: Colors.black),),
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.gray)
                            ),
                            width: 100,
                            height:100,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.googleMapScreenRoute);
                              },
                                child: Image.asset(
                                    ImageAssets.mapImage,
                                fit: BoxFit.cover,))

                          )

                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 18.0,
                      ),
                      child: Text("download_service_photos".tr()),
                    ),

                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                           await  cubit.serviceImagePicker(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: size.height * 0.2,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.gray,
                                ),
                              ),
                               child: IconButton(icon: Icon(Icons.add),onPressed: () async {
                                 await  cubit.serviceImagePicker(context);
                               }),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.serviceImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      height: size.height * 0.2,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(cubit.serviceImages[index]!.path),
                                            ),fit: BoxFit.cover),
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColors.gray,
                                          ),
                                      ),

                                    ),
                                    IconButton(
                                        onPressed: (){
                                          cubit.removeImage(index);

                                    }, icon: Icon(Icons.close_rounded))
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CustomButton(
                          text: "add".tr(),
                          color: AppColors.primary,
                          onClick: () async {
                            if(cubit.serviceLogoImage==null){
                              Fluttertoast.showToast(
                                msg: "logo_validate".tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                            if(cubit.serviceImages.length==0){
                              Fluttertoast.showToast(
                                msg: "images_validate".tr(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          if(formKey.currentState!.validate()&&cubit.serviceLogoImage!=null&&cubit.serviceImages.length!=0){
                            cubit.serviceModel = ServiceModel(
                                name:cubit.nameController.text,
                            category_id: cubit.currentCategory!.id.toString(),
                            details: cubit.detailsController.text,
                            logo: cubit.serviceLogoImage!,
                            location: cubit.locationController.text,
                            images: cubit.serviceImages,
                            phones: [cubit.contact1Controller.text,cubit.contact2Controller.text]
                            );
                            //TODO--1) UPDATE OR STORE THE SERVICE
                            //TODO--2) CLEAR THE FIELDS AFTER THE API CALL AND BEFORE THE NAVIGATION
                          isUpdate!? await context.read<MyPostsCubit>().updateAd(id!) :
                          await cubit.storeService();
                          cubit.clearService();
                             Navigator.pushNamed(context, Routes.homeRoute);

                          }
                          },
                        paddingHorizontal: 100,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
