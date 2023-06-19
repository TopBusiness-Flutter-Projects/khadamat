import 'package:bloc/bloc.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';
import '../../../core/models/cities_model.dart';
import '../../../core/models/favorite_model.dart';
import '../../../core/models/rate_response_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.api) : super(FavoriteInitial()) {
    getFavoriteList();
  }

  final ServiceApi api;
  List<FavoriteModelDatum> modelList = [];
  late FavoriteModel favoriteModel;
 List<City> cities = [];
  getFavoriteList() async {
    emit(FavoriteLoading());
    final response = await api.getFavoriteData();
    response.fold(
      (l) => emit(FavoriteError()),
      (r) {
        favoriteModel = r;
        modelList = r.data!;
        emit(Favoriteloaded());
      },
    );
  }

  getFavouriteSearchList(searchKey) async {
    emit(FavoriteSearchLoading());
    final response = await api.getFavoriteSearchData(searchKey);
    response.fold(
            (l) => emit(FavoriteSearchError()),
            (r) {
              modelList = r.data!;
              emit(FavoriteSearchSuccess());
            },
    );
  }

//  Future<String> getCityName(cityId) async {
//   final response = await api.getCities();
//   response.fold(
//           (l) => emit(GettingCitiesFailure()),
//           (r) {
//             cities = r.data!;
//             emit(GettingCitiesSuccess());
//           }
//   );
//  for(var city in cities){
//   if(city.id == cityId ){
//     return city.name!;
//   }
//  }
// return "";
//   }


}
