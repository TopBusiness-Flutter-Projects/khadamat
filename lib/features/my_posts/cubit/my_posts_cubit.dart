import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/favorite_model.dart';
import '../../../core/remote/service.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit(this.api) : super(MyPostsInitial()) {
    getMyPostsList();
  }


  final ServiceApi api;
  List<FavoriteModelDatum> modelList = [];

  getMyPostsList() async {
    final response = await api.getFavoriteData();
    response.fold(
          (l) => emit(MyPostsError()),
          (r) {
        modelList = r.data!;
        print("__________________________");
        print("${r.data}");
        emit(MyPostsLoaded());
      },
    );
  }
}