import 'package:bloc/bloc.dart';
import 'package:khadamat/core/models/catigoreis_services.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

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
}
