import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/catigoreis_services.dart';
import '../../../core/models/home_model.dart';
import '../../../core/models/search_model.dart';
import '../../../core/models/servicemodel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial()) {
    getHomeData();
  }
  final ServiceApi api;
  late TabController tabController;
  late SearchModel searchModel;
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;

  List<Category> categories = [];
  List<ServicesModel> lastAddServices = [];
  List<ServicesModel> servicesList = [];
  selectTap(int index) {
    currentIndex = index;
    emit(HomeChangeCurrentIndexTap());
  }

  getHomeData() async {
    emit(HomeLoading());
    final response = await api.homeData();
    response.fold(
      (l) => emit(HomeError()),
      (r) {
        categories = r.data!.categories!;
        lastAddServices = r.data!.servicesModels!;
        emit(HomeLoaded());
      },
    );
  }

  getServicesPosts(int catId) async {
    // emit(PostsServicesLoading());
    final response = await api.servicesData(catId);
    response.fold(
      (l) => null,
      //emit(PostsServicesError()),
      (r) {
        servicesList = r.data!;
        //  emit(PostsServicesLoaded());
      },
    );
  }
}
