import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';
import 'package:share/share.dart';

import '../../../core/api/end_points.dart';
import '../../../core/models/add_to_favourite_model.dart';
import '../../../core/models/rate_response_model.dart';
import '../../../core/models/service_details.dart';

part 'details_deeplink_state.dart';

class DetailsDeeplinkCubit extends Cubit<DetailsDeeplinkState> {
  DetailsDeeplinkCubit(this.api) : super(DetailsDeeplinkInitial());
  ServiceApi api ;
  ServiceDetails? serviceDetails;
  num rateValue = 0 ;
  late RateResponseModel rateResponseModel;
  late AddToFavouriteResponseModel addToFavouriteResponseModel;
  getServiceDetails(int serviceId)async{

    final response = await api.serviceDetails(serviceId);
    response.fold(
            (l) => emit(getServiceDetailsFailure()),
            (r) {
              emit(getServiceDetailsSuccess());
              serviceDetails = r;
            });
  }

  setRate(serviceId)async{
    emit(AddingRateLoadingState());
    final response = await api.postRate(serviceId: serviceId, value: rateValue);
    response.fold(
          (l) => emit(AddingRateFailureState()),
          (r) {
        rateResponseModel  = r;
        emit(AddingRateSuccessState());
      },
    );

  }

  addToFavourite(serviceId) async {
    emit(AddingFavouriteLoadingState());
    final response = await api.addToFavourite(serviceId);
    response.fold(
            (l) => emit(AddingFavouriteFailureState()),

            (r) {
          addToFavouriteResponseModel = r ;
          emit(AddingFavouriteSuccessState());
        }
    );
  }
  void shareApplication(int? id) {
    // Get the Google Play Store URL or App Store URL for your app
    //String appStoreUrl = 'https://apps.apple.com/your-app-store-url';
    String googlePlayUrl =EndPoints.deepLink+id!.toString();

    // Share the application using the Share package
    Share.share(' $googlePlayUrl');
  }
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);


      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return '${placemark.street}, ${placemark.country}';
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }
}
