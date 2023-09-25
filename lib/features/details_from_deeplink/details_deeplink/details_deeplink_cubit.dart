import 'package:bloc/bloc.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/service_details.dart';

part 'details_deeplink_state.dart';

class DetailsDeeplinkCubit extends Cubit<DetailsDeeplinkState> {
  DetailsDeeplinkCubit(this.api) : super(DetailsDeeplinkInitial());
  ServiceApi api ;
  ServiceDetails? serviceDetails;

  getServiceDetails(int serviceId)async{

    final response = await api.serviceDetails(serviceId);
    response.fold(
            (l) => emit(getServiceDetailsFailure()),
            (r) {
              emit(getServiceDetailsSuccess());
              serviceDetails = r;
            });
  }
}
