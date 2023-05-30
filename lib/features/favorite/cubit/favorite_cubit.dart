import 'package:bloc/bloc.dart';
import 'package:khadamat/core/models/catigoreis_services.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../core/models/favorite_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.api) : super(FavoriteInitial()) {
    getFavoriteList();
  }

  final ServiceApi api;
  List<FavoriteModelDatum> modelList = [];

  getFavoriteList() async {
    final response = await api.getFavoriteData();
    response.fold(
      (l) => emit(FavoriteError()),
      (r) {
        modelList = r.data!;
        print("__________________________");
        print("${r.data}");
        emit(Favoriteloaded());
      },
    );
  }
}
