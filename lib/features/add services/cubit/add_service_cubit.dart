import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khadamat/core/models/categories_model.dart';
import 'package:khadamat/core/models/service_model.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/models/cities_model.dart';
import '../../../core/models/serviceToUpdate.dart';
import '../../../core/models/service_store_model.dart';
import '../../../core/models/servicemodel.dart';
import '../../../core/models/updated_model.dart';
import '../../../core/remote/service.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  Placemark? placeToBack;

  AddServiceCubit(this.api) : super(AddServiceInitial()) {
    getCategoriesData();
    getCities();
    getTheUserPermissionAndLocation();
  }

  bool isUpdate = false;
  final ImagePicker picker = ImagePicker();
  XFile? serviceLogoImage;
  String cityHint = "city";
  String categoryHint = "kind of Activity";

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
  late UpdatedModel updateServiceModel;
  late ServicesModel updatedItem;

  CategoriesDatum? currentCategory;
  City? currentCity;
  dynamic city_id = 0;

  changeCategoryName(CategoriesDatum? newValue) {
    currentCategory = newValue;
    emit(ChangeCategoriesState());
  }

  changeCityName(City? newValue) {
    currentCity = newValue;
    emit(ChangeCityState());
  }

  clearFields() {
    servicesController.text = "";
    nameController.text = "";
    locationController.text = "";
    categoryController.text = "";
    contact1Controller.text = "";
    contact2Controller.text = "";
    detailsController.text = "";
    serviceLogoImage = null;
    categoryHint = "Kind Of Activity";
    cityHint = "City";
    serviceImages.clear();
    emit(ClearService());
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

  getCities() async {
    emit(CitiesLoading());
    final response = await api.getCities();
    response.fold((l) => emit(CitiesFailure()), (r) {
      cities = r.data!;

      emit(CitiesSuccess());
    });
  }

  storeService() async {
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

  updateAd(int id, ServiceToUpdate serviceToUpdate) async {
    loadingDialog();
    final response = await api.edit(serviceToUpdate, id);
    response.fold((l) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      Get.back();

      emit(EditServiceFailure());
    }, (r) {
      emit(EditServiceSuccess());
      print("/////////////////////////////////////////////////");
      Get.back();
      updateServiceModel = r;
      updatedItem = r.data!;
    });
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

                    CroppedFile? croppedFile =
                        await ImageCropper.platform.cropImage(
                            sourcePath: serviceLogoImage!.path,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio7x5,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            cropStyle: CropStyle.circle,
                            compressFormat: ImageCompressFormat.png,
                            compressQuality: 90);

                    serviceLogoImage = XFile(croppedFile!.path);
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
                    CroppedFile? croppedFile =
                        await ImageCropper.platform.cropImage(
                            sourcePath: serviceLogoImage!.path,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio7x5,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            cropStyle: CropStyle.rectangle,
                            compressFormat: ImageCompressFormat.png,
                            compressQuality: 90);
                    serviceLogoImage = XFile(croppedFile!.path);
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


  removeImage(int index) {
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
                    List<Asset> resultList = await MultiImagePicker.pickImages(
                      maxImages:
                          10, // Set the maximum number of images to be selected
                    );

                    for (final asset in resultList) {
                 File image = await  getImageFileFromAssets(asset);
                 serviceImages.add(XFile(image.path));
                    }

                    emit(ServiceImageSuccess());
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                  onTap: () async {
                    var image =
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


  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
    File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }


  void setAddress(Placemark? place) {
    this.placeToBack = place;
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print("place to back = $placeToBack");
    emit(placeState());
  }

  //******************************************************************************
  bool isOpened = false;
  late GoogleMapController mapController;

  Position position = Position(longitude:31.189283 , latitude:  27.180134,
      timestamp: DateTime(Duration.millisecondsPerDay), accuracy: 1.5,
      altitude: 0.8, heading: 100, speed: 12, speedAccuracy: 1);

  LatLng selectedLocation = LatLng(31.189283, 27.180134);

  //this variable used in getMyLocation method
  // late Position myPosition ;

  String address = "";
  // String? currentAddress = "";

  PermissionStatus permissionStatus =PermissionStatus.denied ;
  // Completer<Placemark> resultCompleter = Completer<Placemark>();
   Placemark? place;

  getTheUserPermissionAndLocation() async {
    permissionStatus = await Permission.location.request();

    if (permissionStatus == PermissionStatus.granted) {
      // User granted location permission, get user's location
      await _getUserLocation();
      emit(LocationPermissionSuccess());
    } else {
      emit(LocationPermissionFailed());
      // User denied location permission, display error message
    }
  }

  _getUserLocation() async {
    try {
      // await  getTheUserPermission();
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      selectedLocation =  LatLng(position.latitude, position.longitude) ;
      moveCamera();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      place = placemarks[0];
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("place = $place");
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      // if (e is PermissionDeniedException) {
      //   print('User denied permission to access location');
      // }
      print('User denied permission to access location');
    }
  }

  moveCamera() async {
    //await getTheUserPermission();
    mapController.animateCamera(

        CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 15,
                // tilt: 60,
                // bearing: 100,
                target: LatLng(position.latitude, position.longitude))));
    emit(CameraMoveState());
  }

  moveCamera2(LatLng latLng) async {
    //await getTheUserPermission();
    mapController.animateCamera(

        CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 15,
                // tilt: 60,
                // bearing: 100,
                target: latLng)));
    emit(CameraMoveState());
  }

  // selectLocation(LatLng newLocation) {
  //   selectedLocation = newLocation;
  //   emit(NewLocationSelected());
  // }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      place = placemarks[0];
      address =
      '${place?.name},${place?.street}, ${place?.subLocality}, ${place?.subAdministrativeArea},}';
      // "${place.administrativeArea} , ${place.name} ${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
  }
}
