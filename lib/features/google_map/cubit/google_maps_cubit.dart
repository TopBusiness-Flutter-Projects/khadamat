import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
part 'google_maps_state.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsState> {
  GoogleMapsCubit() : super(GoogleMapsInitial()) {
    getTheUserPermissionAndLocation();
  }

  late GoogleMapController mapController;
  late Position position;
  LatLng selectedLocation = LatLng(31, 31);

  //this variable used in getMyLocation method
  late Position myPosition;

  String address = "";
  String? currentAddress = "";

  late PermissionStatus permissionStatus;
 // Completer<Placemark> resultCompleter = Completer<Placemark>();
  late Placemark place;

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
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      if (e is PermissionDeniedException) {
        print('User denied permission to access location');
      }
    }
  }

  moveCamera() async {
    //await getTheUserPermission();
    mapController.animateCamera(

        CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 15,
                tilt: 60,
                bearing: 100,
                target: LatLng(position.latitude, position.longitude))));
  }

  selectLocation(LatLng newLocation) {
    selectedLocation = newLocation;
    emit(NewLocationSelected());
  }

//unused method
  getMyLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) return Future.error("No Gps Adapter");

    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      //ask for permission if the default is denied
      locationPermission = await Geolocator.requestPermission();
      //check the user response and if it denied exit  from method
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Permission Denied");
      }
    }
    // the user allowed
    myPosition = await Geolocator.getCurrentPosition();
    return Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      place = placemarks[0];
      address =
      '${place.name},${place.street}, ${place.subLocality}, ${place
          .subAdministrativeArea}, ${place.postalCode}';
      // "${place.administrativeArea} , ${place.name} ${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

    } catch (e) {
      print(e);
    }
  }

//unused method
  Future<void> getAddressFromLatLng2() async {
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // setState(() {
      currentAddress =
      '${place.street}, ${place.subLocality}, ${place
          .subAdministrativeArea}, ${place.postalCode}';
      emit(CurrentAddressState());
      print(currentAddress);
      // });
    }).catchError((e) {
      print(e);
    });
  }
}
