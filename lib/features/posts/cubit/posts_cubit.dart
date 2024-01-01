import 'package:bloc/bloc.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/servicemodel.dart';
import '../../../core/models/subcategorymodel.dart';

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

  searchServices(catId, searchKey) async {
    emit(searchServicesLoading());
    final response = await api.servicesSearchData(catId, searchKey);
    response.fold((l) => emit(searchServicesError()), (r) {
      servicesList = r.data!;
      emit(searchServicesSuccess());
    });
  }

  List<SubCategoryModeel> subCategories = [];

  searchSSubCategory({required int catId}) async {
    emit(SubServicesLoading());
    final response = await api.SubCategoryMethod(catId);
    response.fold((l) => emit(SubServicesError()), (r) {
      subCategories = r.data!;
      emit(SubServicesLoaded());
    });
  }

  List<ServicesModel> servicesSubList = [];
  servicesBySubCategory({required int catId, required String search}) async {
    emit(ServicesBySubLoading());
    final response = await api.servicesBySubCategory(catId, search);
    response.fold(
      (l) => emit(ServicesBySubFailure()),
      (r) {
        servicesSubList = r.data!;
        emit(ServicesBySubSuccess());
      },
    );
  }
}
