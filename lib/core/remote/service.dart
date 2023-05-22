
import '../api/base_api_consumer.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  // Future<Either<Failure, UserModel>> postUser(String code) async {
  //   String lan = await Preferences.instance.getSavedLang();
  //   try {
  //     final response = await dio.post(
  //       EndPoints.userUrl,
  //       body: {
  //         'code': code,
  //       },
  //       options: Options(
  //         headers: {'Accept-Language': lan},
  //       ),
  //     );
  //     print(response);
  //     return Right(UserModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

}
