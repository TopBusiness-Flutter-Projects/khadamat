import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khadamat/core/models/notification_model.dart';
import 'package:khadamat/core/models/service_details.dart';
import 'package:khadamat/core/models/service_model.dart';
import 'package:khadamat/core/network/error_message_model.dart';
import 'package:path_provider/path_provider.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/add_to_favourite_model.dart';
import '../models/categories_model.dart';
import '../models/catigoreis_services.dart';
import '../models/cities_model.dart';
import '../models/favorite_model.dart';
import '../models/home_model.dart';
import '../models/login_model.dart';
import '../models/my_services_model.dart';
import '../models/rate_response_model.dart';
import '../models/search_model.dart';
import '../models/serviceToUpdate.dart';
import '../models/service_store_model.dart';
import '../models/servicemodel.dart';
import '../models/setting_model.dart';
import '../models/updated_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, LoginModel>> postRegister(
      String phone, String phoneCode, String name, String password) async {
    try {
      var response = await dio.post(
        EndPoints.registerUrl,
        body: {
          'phone': phone,
          'phone_code': phoneCode,
          'name': name,
          'password': password
          //'role_id': 1,
        },
      );

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> checkToken(String deviceToken) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
      var response = await dio.post(
        EndPoints.checkToken,
        formDataIsEnabled: true,
        body: {
          'device_token': deviceToken,
          'phone_type': Platform.isAndroid ? 'android' : 'ios',
          'user_id': loginModel.data!.user!.id!
        },
      );

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> checkPhone(
      String phone, String phoneCode) async {
    try {
      var response = await dio.post(
        EndPoints.checkPhoneUrl,
        body: {
          'phone': phone,
          'phone_code': phoneCode,
        },
      );

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> resetPassword(
      String phone, String password1, String password2) async {
    print("phone = $phone pass1 = $password1 , pass2 = $password2");
    try {
      var response = await dio.post(
        EndPoints.resetPasswordUrl,
        body: {
          'phone': phone,
          'password': password1,
          'password_confirmation': password2,
        },
      );
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa");
      print(response);
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ServiceStoreModel>> postServiceStore(
      ServiceModel serviceModel) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
      List<MultipartFile> images = [];
      for (int i = 0; i < serviceModel.images.length; i++) {
        var image = await MultipartFile.fromFile(serviceModel.images[i]!.path);
        images.add(image);
      }
      List phones = [];
      for (int i = 0; i < serviceModel.phones.length; i++) {
        phones.add(serviceModel.phones[i]);
      }
      final response = await dio.post(
        EndPoints.serviceStoreUrl,
        formDataIsEnabled: true,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        body: {
          'name': serviceModel.name,
          "category_id": serviceModel.category_id,
          "sub_category_id": serviceModel.sub_category_id,
          "city_id": serviceModel.cityId,
          "phones[]": phones,
          "details": serviceModel.details,
          "logo": await MultipartFile.fromFile(serviceModel.logo.path),
          "location": serviceModel.location,
          "images[]": images,
          "longitude": serviceModel.longitude,
          "latitude": serviceModel.latitude,
        },
      );
      return Right(ServiceStoreModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UpdatedModel>> edit(
      ServiceToUpdate serviceToUpdate, catId) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
      List<MultipartFile> images = [];
      for (int i = 0; i < serviceToUpdate.images!.length; i++) {
        var image =
            await MultipartFile.fromFile(serviceToUpdate.images?[i]!.path);
        images.add(image);
      }
      List phones = [];
      for (int i = 0; i < serviceToUpdate.phones!.length; i++) {
        phones.add(serviceToUpdate.phones?[i]);
      }
      final response = await dio.post(
        EndPoints.editServicesUrl + catId.toString(),
        formDataIsEnabled: true,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        body: {
          'name': serviceToUpdate.name,
          "category_id": serviceToUpdate.categoryId,
          // "sub_category_id":1,
          "phones[]": phones,
          "details": serviceToUpdate.details,
          "city_id": serviceToUpdate.cityId,
          "longitude": serviceToUpdate.longitude,
          "latitude": serviceToUpdate.latitude,
          "logo": serviceToUpdate.logo,
          "location": serviceToUpdate.location,
          "images[]": images,
        },
      );
      return Right(UpdatedModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, RateResponseModel>> postRate(
      {required serviceId, required value, comment}) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.rateUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        body: {'service_id': serviceId, "value": value, "comment": comment},
      );
      return Right(RateResponseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> postEditProfile(String name) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
      final response = await dio.post(
        EndPoints.updateProfileUrl,
        options:
            Options(headers: {"Authorization": loginModel.data!.accessToken!}),
        body: {
          'name': name,
          "phone": loginModel.data?.user?.phone,
        },
      );

      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LoginModel>> postLogin(
      String phone, String phoneCode, String password) async {
    try {
      print("******************************************");
      print(password);
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {'phone': phone, "password": password},
      );

      print(response);
      return Right(LoginModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, HomeModel>> homeData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.homeUrl,
        options: Options(
          headers: {'Authorization': loginModel.data?.accessToken!},
        ),
      );
      return Right(HomeModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CategoriesServicesModel>> servicesData(
      int catId) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.servicesUrl + catId.toString(),
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      return Right(CategoriesServicesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ServiceDetails>> serviceDetails(int serviceId) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.getServiceDetailsUrl,
        queryParameters: {"service_id": serviceId},
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print("🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓🤓");
      print(response);
      return Right(ServiceDetails.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UpdatedModel>> editService(
      int catId, ServiceToUpdate serviceToUpdate) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();

    try {
      List<MultipartFile> images = [];
      for (int i = 0; i < serviceToUpdate.images!.length; i++) {
        var imageFile = serviceToUpdate.images![i];
        if (imageFile.path.startsWith('http')) {
          // This is a remote URL, so we need to download the image and save it locally before uploading it
          var response = await http.get(Uri.parse(imageFile.path));
          var bytes = response.bodyBytes;
          var tempDir = await getTemporaryDirectory();
          var filePath =
              '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
          await File(filePath).writeAsBytes(bytes);
          var image = await MultipartFile.fromFile(filePath);
          images.add(image);
        } else {
          // This is a local file, so we can create a MultipartFile object from it
          var image = await MultipartFile.fromFile(imageFile.path);
          images.add(image);
        }
      }
      final response =
          await dio.post(EndPoints.editServicesUrl + catId.toString(),
              options: Options(
                headers: {'Authorization': loginModel.data!.accessToken!},
              ),
              body: {
            "name": serviceToUpdate.name,
            "category_id": serviceToUpdate.categoryId,
            "sub_category_id": serviceToUpdate.subCategoryId,
            "phones[0]": serviceToUpdate.phones?[0],
            "phones[1]": serviceToUpdate.phones?[1],
            "details": serviceToUpdate.details,
            // "logo":serviceToUpdate.logo,
            //"logo": await MultipartFile.fromFile(serviceToUpdate.logo!),
            "logo": !serviceToUpdate.logo!.path.startsWith("http")
                ? await MultipartFile.fromFile(serviceToUpdate.logo!.path)
                : null,
            "location": serviceToUpdate.location,
            "images[]": images,
          });
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(response);
      return Right(UpdatedModel.fromJson(response));
    } on ServerException {
      print("erroooooor");
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CategoriesServicesModel>> servicesSearchData(
      int catId, searchKey) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.servicesUrl + catId.toString(),
          options: Options(
            headers: {'Authorization': loginModel.data!.accessToken!},
          ),
          queryParameters: {"search_key": searchKey});
      return Right(CategoriesServicesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FavoriteModel>> getFavoriteData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.favoriteUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      return Right(FavoriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CitiesModel>> getCities() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.citiesUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      return Right(CitiesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, FavoriteModel>> getFavoriteSearchData(
      searchKey) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.favoriteUrl,
          options: Options(
            headers: {'Authorization': loginModel.data!.accessToken!},
          ),
          queryParameters: {"search_key": searchKey});

      return Right(FavoriteModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MyServicesModel>> getMyServicesData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.myServicesUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      return Right(MyServicesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, MyServicesModel>> getMyServicesSearchData(
      searchKey) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.myServicesUrl,
          options: Options(
            headers: {'Authorization': loginModel.data!.accessToken!},
          ),
          queryParameters: {"search_key": searchKey});

      return Right(MyServicesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NotificationModel>> getNotifications() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.notificationUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );

      return Right(NotificationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CategoriesModel>> getCategoriesData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.categoriesUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      return Right(CategoriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SettingModel>> getSettingData() async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(
        EndPoints.settingUrl,
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );

      return Right(SettingModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AddToFavouriteResponseModel>> addToFavourite(
      serviceId) async {
    LoginModel loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(EndPoints.addToFavouriteUrl,
          options: Options(
            headers: {"Authorization": loginModel.data!.accessToken},
          ),
          body: {"service_id": serviceId});
      return Right(AddToFavouriteResponseModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // Future<Either<Failure, SearchModel>> search(searchKey) async {
  //   LoginModel loginModel = await Preferences.instance.getUserModel();
  //
  //   try {
  //     final response = await dio.get(
  //       EndPoints.searchUrl+searchKey,
  //       options: Options(
  //         headers: {'Authorization': loginModel.data!.accessToken!},
  //       ),
  //     );
  //     return Right(SearchModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
}
