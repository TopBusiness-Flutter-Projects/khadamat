
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khadamat/core/models/categories_model.dart';
import 'package:khadamat/core/models/service_model.dart';
import 'package:meta/meta.dart';
import '../../../core/models/cities_model.dart';
import '../../../core/models/service_store_model.dart';
import '../../../core/remote/service.dart';
part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  Placemark? placeToBack;

  AddServiceCubit(this.api) : super(AddServiceInitial()){
    getCategoriesData();
    getCities();

  }

  final ImagePicker picker = ImagePicker();
  XFile? serviceLogoImage;

  List<XFile?> serviceImages = [];
  final ServiceApi api;
  TextEditingController servicesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController contact1Controller = TextEditingController();
  TextEditingController contact2Controller = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  late ServiceModel serviceModel;
  ServiceStoreModel? serviceStoreModel;
 // String selectedService = "";
  List<CategoriesDatum> categories = [];
  List<City> cities = [];
  CategoriesDatum? currentCategory;
  var currentCity;

  changeCategoryName(CategoriesDatum newValue) {
    currentCategory = newValue;
    emit(ChangeCategoriesState());
  }
  changeCityName( newValue) {
    currentCity = newValue;
    emit(ChangeCityState());
  }




  getCategoriesData() async {
    emit(CategoriesLoading());
    final response = await api.getCategoriesData();
    response.fold(
            (l) => emit(CategoriesFailure()),
            (r) {
              categories = r.data!;
              emit(CategoriesSuccess());
            },
    );
  }

getCities()async{
    emit(CitiesLoading());
    final response = await api.getCities();
    response.fold(
            (l) => emit(CitiesFailure()),
            (r) {
          cities = r.data!;
          emit(CitiesSuccess());
            });
}


  storeService() async {
    print("ssssssssssssssssssssssssssssssss store service");
    loadingDialog();
    final response = await api.postServiceStore(serviceModel);

    response.fold(
      (l) {

        Get.back();

        emit(StoreServiceFailure());
      },
      (r) {
    Get.back();

    serviceStoreModel = r;
        emit(StoreServiceSuccess());
      },
    );
  }
  loadingDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        insetAnimationCurve: Curves.bounceInOut,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'جارى التحميل'.tr,
                style: Get.textTheme.bodyText1!.copyWith(
                  color: Get.theme.primaryColor,
                ),
              ),
              const SizedBox(width: 5),
              // SpinKitCircle(),vx
              CircularProgressIndicator(color: Get.theme.colorScheme.secondary),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeInOutBack,
    );
  }

  clearService() {
    nameController.clear();
    contact1Controller.clear();
    contact2Controller.clear();
    locationController.clear();
    categoryController.clear();

    detailsController.clear();
     serviceLogoImage = null;
     serviceImages.clear();
    emit(ClearService());
  }

  logoImagePicker(BuildContext context) {
    emit(logoImageLoading());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Pick from gallery'),
                  onTap: () async {
                    serviceLogoImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    emit(logoImageSuccess());
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () async {
                    serviceLogoImage =
                        await picker.pickImage(source: ImageSource.camera);
                    emit(logoImageSuccess());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
   removeImage(int index){
     serviceImages.removeAt(index);
     emit(RemoveImageState());
   }
  serviceImagePicker(BuildContext context) {
    emit(ServiceImageLoading());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Pick from gallery'),
                  onTap: () async {
                    var image =
                        await picker.pickImage(source: ImageSource.gallery);
                    serviceImages.add(image);
                    emit(ServiceImageSuccess());
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () async {
                    var image = serviceLogoImage =
                        await picker.pickImage(source: ImageSource.camera);
                    serviceImages.add(image);
                    emit(ServiceImageSuccess());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setAddress(Placemark place) {
    this.placeToBack=place;
    emit(placeState());
  }
}
