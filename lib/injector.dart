import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:khadamat/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:khadamat/features/privacy/cubit/privacy_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'features/favorite/cubit/favorite_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/posts/cubit/posts_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/splash/cubit/splash_cubit.dart';

// import 'features/downloads_videos/cubit/downloads_videos_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => SplashCubit(
        // serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(
      // serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FavoriteCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => PostsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
        () => EditProfileCubit(
      serviceLocator(),
    ),

  );

  serviceLocator.registerFactory(
        () => PrivacyCubit(
      serviceLocator(),
    ),

  );

  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
