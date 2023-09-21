import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import 'package:khadamat/features/google_map/cubit/google_maps_cubit.dart';

import '../../../config/routes/app_routes.dart';

class GoogleMapDetailsScreen extends StatefulWidget {
  final LatLng latLng;
   GoogleMapDetailsScreen({Key? key,required this.latLng}) : super(key: key);

  @override
  State<GoogleMapDetailsScreen> createState() => _GoogleMapDetailsScreenState();
}

class _GoogleMapDetailsScreenState extends State<GoogleMapDetailsScreen> {
  Future<bool> onWillPop()async{
    return true;
  }
  @override
  // void initState() {
  //   //context.read<GoogleMapsCubit>().getMyLocation();
  //  // context.read<GoogleMapsCubit>().getAddressFromLatLng();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {


     // GoogleMapsCubit cubit = context.read<GoogleMapsCubit>();
      return WillPopScope(
        onWillPop: () async {
         // context.read<AddServiceCubit>().setAddress(cubit.place);
          return true;
        },

        child: Scaffold(
         // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton(
          //    onPressed: () async {
          //   //   cubit.getTheUserPermissionAndLocation();
          //   //   await cubit.moveCamera2(cubit.selectedLocation);
          //    },
          //   child: Icon(Icons.directions),
          // ),
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                 // cubit.mapController = controller;

                },
                onTap: (LatLng location) {
               // cubit.selectedLocation =  location;
               //   cubit.position = Position(longitude:location.longitude ,
               //       latitude:  location.latitude,
               //       timestamp: DateTime(Duration.millisecondsPerDay), accuracy: 1.5,
               //       altitude: 0.8, heading: 100, speed: 12, speedAccuracy: 1);
               //   cubit.getAddressFromLatLng();
               //   cubit.moveCamera2(location);
                },
                   onCameraMove: (position) {

                   },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target:
                  //cubit.selectedLocation,
                  LatLng(widget.latLng.latitude,widget.latLng.longitude),
                  zoom: 15,
                  // bearing: 100,
                  // tilt: 90,
                ),
                markers:

                          {
                            Marker(
                              markerId: MarkerId('selected_location'),
                              position: LatLng(widget.latLng.latitude,widget.latLng.longitude),
                              // infoWindow: InfoWindow(
                              //   title: 'Egypt',
                              // ),
                            ),
                          }

              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    child: Text("confirm").tr(),
                    onPressed: () {
                     // context.read<AddServiceCubit>().setAddress(cubit.place);
                      Navigator.pop(context);
                  },),
                ),
              )
            ],
          ),
        ),
      );
    ;
  }
}
