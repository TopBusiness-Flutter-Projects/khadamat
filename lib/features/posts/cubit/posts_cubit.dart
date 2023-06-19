import 'package:bloc/bloc.dart';
import 'package:khadamat/core/models/catigoreis_services.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/servicemodel.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.api) : super(PostsInitial());
  final ServiceApi api;
  List<ServicesModel> servicesList = [];

  getServicesPosts(int catId) async {
    emit(PostsServicesLoading());
    final response = await api.servicesData(catId);
    response.fold(
      (l) => emit(PostsServicesError()),
      (r) {
        servicesList = r.data!;
        emit(PostsServicesLoaded());
      },
    );
  }

  searchServices(catId,searchKey) async {
    emit(searchServicesLoading());
    final response = await api.servicesSearchData(catId,searchKey);
    response.fold((l) => emit(searchServicesError()),
            (r) {
              servicesList = r.data!;
      emit(searchServicesSuccess());
        });
  }
}
