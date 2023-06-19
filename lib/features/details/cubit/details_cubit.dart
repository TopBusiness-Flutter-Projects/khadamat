import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:khadamat/core/models/cities_model.dart';
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import 'package:meta/meta.dart';

import '../../../core/models/add_to_favourite_model.dart';
import '../../../core/models/rate_response_model.dart';
import '../../../core/remote/service.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.api) : super(DetailsInitial()){
    getCities();
  }
  late RateResponseModel rateResponseModel;
  final ServiceApi api;
  num rateValue = 0 ;
 late AddToFavouriteResponseModel addToFavouriteResponseModel;
 List<City> cities = [];


  setRate(serviceId)async{
    emit(AddingRateLoading());
    final response = await api.postRate(serviceId: serviceId, value: rateValue);
    response.fold(
          (l) => emit(AddingRateFailure()),
          (r) {
        rateResponseModel  = r;
        emit(AddingRateSuccess());
      },
    );

  }

 addToFavourite(serviceId) async {
    emit(AddingFavouriteLoading());
  final response = await api.addToFavourite(serviceId);
  response.fold(
          (l) => emit(AddingFavouriteFailure()),

          (r) {
            addToFavouriteResponseModel = r ;
            emit(AddingFavouriteSuccess());
          }
  );
 }

  String getCityName(cityId)  {
  print("____________________________________________");
    for(var city in cities){
      print(city.name);
      if(city.id == cityId ){

        return city.name!;
      }
    }
    return "";
  }


  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      print("______________________________");
      print(placemarks);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  getCities()async{

    final response = await api.getCities();
    response.fold(
            (l) => emit(GettingCitiesFailure()),
            (r) {
          cities = r.data!;
          emit(GettingCitiesSuccess());
        });
  }

}
