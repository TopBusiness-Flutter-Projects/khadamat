import 'package:bloc/bloc.dart';
import 'package:khadamat/core/api/end_points.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';
import 'package:share/share.dart';

import '../../../core/models/add_to_favourite_model.dart';
import '../../../core/models/rate_response_model.dart';

part 'notification_details_state.dart';

class NotificationDetailsCubit extends Cubit<NotificationDetailsState> {
  NotificationDetailsCubit(this.api) : super(NotificationDetailsInitial());
  final ServiceApi api;
  num rateValue = 0 ;
   RateResponseModel? rateResponseModel;
  late AddToFavouriteResponseModel addToFavouriteResponseModel;


  setRate(serviceId)async{
    emit(RateLoading());
    final response = await api.postRate(serviceId: serviceId, value: rateValue);
    response.fold(
          (l) => emit(RateFailure()),
          (r) {
        rateResponseModel  = r;
        emit(RateSuccess());
      },
    );

  }

  addToFavourite(serviceId) async {
    emit(AddFavouriteLoading());
    final response = await api.addToFavourite(serviceId);
    response.fold(
            (l) => emit(AddFavouriteFailure()),

            (r) {
          addToFavouriteResponseModel = r ;
          emit(AddFavouriteSuccess());
        }
    );
  }

  //  shareDeepLink() async {
  //   // Generate your deep link URL
  //
  //   String deepLink = 'yourdeeplink://';
  //
  //   // Share the deep link using the Share package
  //   await Share.share(deepLink);
  // }

  void shareApplication(int? id) {
    // Get the Google Play Store URL or App Store URL for your app
    //String appStoreUrl = 'https://apps.apple.com/your-app-store-url';
    String googlePlayUrl =EndPoints.deepLink+id!.toString();

    // Share the application using the Share package
    Share.share(' $googlePlayUrl');
  }
}
