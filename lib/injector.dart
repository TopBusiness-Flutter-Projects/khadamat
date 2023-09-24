import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:khadamat/features/add%20services/cubit/add_service_cubit.dart';
import 'package:khadamat/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:khadamat/features/details/cubit/details_cubit.dart';
import 'package:khadamat/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:khadamat/features/google_map/cubit/google_maps_cubit.dart';
import 'package:khadamat/features/my_posts/cubit/my_posts_cubit.dart';
import 'package:khadamat/features/notification/cubit/nottification_cubit.dart';
import 'package:khadamat/features/register/cubit/register_cubit.dart';
import 'package:khadamat/features/reset_password/cubit/reset_password_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'features/favorite/cubit/favorite_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/notification_details/cubit/notification_details_cubit.dart';
import 'features/posts/cubit/posts_cubit.dart';
import 'features/privacy_about/cubit/privacy_cubit.dart';
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
        () => GoogleMapsCubit(
     // serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(
       serviceLocator(),
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
        () => MyPostsCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => AddServiceCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => DetailsCubit(
      serviceLocator(),
    ),

  );

  serviceLocator.registerFactory(
        () => PrivacyCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => ContactUsCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => NottificationCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => RegisterCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => NotificationDetailsCubit(
      serviceLocator(),
    ),

  );
  serviceLocator.registerFactory(
        () => ResetPasswordCubit(
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
