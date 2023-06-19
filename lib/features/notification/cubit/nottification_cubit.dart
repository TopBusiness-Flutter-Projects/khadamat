import 'package:bloc/bloc.dart';
import 'package:khadamat/core/models/notification_model.dart';
import 'package:meta/meta.dart';

import '../../../core/remote/service.dart';

part 'nottification_state.dart';

class NottificationCubit extends Cubit<NottificationState> {
  NottificationCubit(this.api) : super(NottificationInitial()){
    getNotification();
  }
  final ServiceApi api;
 late NotificationModel notificationModel ;
 List<NotificationDatum> notificationList = [];
  getNotification() async {
    emit(NottificationLoading());
    final response =await api.getNotifications();
    response.fold(
            (l) => emit(NottificationFailure()),
            (r) {
              notificationModel = r;
              notificationList = r.data!;
              emit(NottificationSuccess());
            }
    );
  }


}
