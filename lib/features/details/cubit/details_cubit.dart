import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/models/add_to_favourite_model.dart';
import '../../../core/models/rate_response_model.dart';
import '../../../core/remote/service.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.api) : super(DetailsInitial()){

  }
  late RateResponseModel rateResponseModel;
  final ServiceApi api;
  num rateValue = 0 ;
 late AddToFavouriteResponseModel addToFavouriteResponseModel;


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

}
