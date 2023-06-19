import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import 'package:khadamat/features/google_map/cubit/google_maps_cubit.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Future<bool> onWillPop()async{
    return true;
  }
  @override
  void initState() {
    //context.read<GoogleMapsCubit>().getMyLocation();
   // context.read<GoogleMapsCubit>().getAddressFromLatLng();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapsCubit, GoogleMapsState>(
        builder: (context, state) {
      GoogleMapsCubit cubit = context.read<GoogleMapsCubit>();
      return WillPopScope(
        onWillPop: () async {
          context.read<AddServiceCubit>().setAddress(cubit.place);
          return true;
        },

        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await cubit.moveCamera();
            },
            child: Icon(Icons.directions),
          ),
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  cubit.mapController = controller;

                },
                onTap: (LatLng location) {
                 cubit.selectLocation(location);
                 cubit.getAddressFromLatLng();
                },
                   onCameraMove: (position) {

                   },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(30.0450, 31.2242),
                  zoom: 18,
                  bearing: 100,
                  tilt: 90,
                ),
                markers:
                  cubit.selectedLocation==null?
                      {}:
                          {
                            Marker(
                              markerId: MarkerId('selected_location'),
                              position: cubit.selectedLocation,
                              infoWindow: InfoWindow(
                                title: 'Egypt',
                              ),
                            ),
                          }

              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    context.read<AddServiceCubit>().setAddress(cubit.place);
                    Navigator.pop(context);
                },),
              )
            ],
          ),
        ),
      );
    });
  }
}
