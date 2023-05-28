import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial()){
    getHomeData();
  }
  final ServiceApi api;
  late TabController tabController;

  int currentIndex = 0;

  List<Category> categories = [];
  List<LastAddService> lastAddServices = [];

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
        lastAddServices = r.data!.lastAddServices!;
        emit(HomeLoaded());
      },
    );
  }
}
