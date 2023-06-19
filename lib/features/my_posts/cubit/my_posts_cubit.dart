import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/catigoreis_services.dart';
import '../../../core/models/favorite_model.dart';
import '../../../core/models/my_services_model.dart';
import '../../../core/models/serviceToUpdate.dart';
import '../../../core/models/servicemodel.dart';
import '../../../core/models/updated_model.dart';
import '../../../core/remote/service.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit(this.api) : super(MyPostsInitial()) {
    getMyPostsList();
  }


  final ServiceApi api;
  List<ServicesModel> modelList = [];
  late  MyServicesModel myServicesModel;

  late  UpdatedModel updateServiceModel;
  late ServicesModel updatedItem ;

  getMyPostsList() async {
    final response = await api.getMyServicesData();
    response.fold(
          (l) => emit(MyPostsError()),
          (r) {
        modelList = r.data!;
        myServicesModel = r;
        emit(MyPostsLoaded());
      },
    );
  }

  getMyPostsSearchList(searchKey) async {
    emit(MyPostsSearchLoading());
    final response = await api.getMyServicesSearchData(searchKey);
    response.fold(
          (l) => emit(MyPostsSearchError()),
          (r) {
            myServicesModel = r;
        modelList = r.data!;

        emit(MyPostsSearchSuccess());
      },
    );
  }

  updateAd(int id,) async {

    ServiceToUpdate serviceToUpdate = ServiceToUpdate(
    );
    emit(EditServiceLoading());
    final response = await api.editService(id,serviceToUpdate);
    response.fold(
            (l) => emit(EditServiceFailure()),
            (r) {
              updateServiceModel = r;
              updatedItem = r.data!;

              emit(EditServiceSuccess());
            });
  }

}