import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/catigoreis_services.dart';
import '../models/favorite_model.dart';
import '../models/home_model.dart';
import '../models/login_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postLogin(
      String phone, String phoneCode) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'phone': phone,
        },
      );
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomeModel>> homeData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    // String lan = await Preferences.in!stance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.homeUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print(response);
      return Right(HomeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CategoriesServicesModel>> servicesData(
      int catId) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    // String lan = await Preferences.in!stance.getSavedLang();
    try {
      final response = await dio.get(
        EndPoints.servicesUrl + catId.toString(),
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print(response);
      return Right(CategoriesServicesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FavoriteModel>>getFavoriteData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.favoriteUrl ,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print(response);
      return Right(FavoriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
