import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:khadamat/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:khadamat/features/details/cubit/details_cubit.dart';
import 'package:khadamat/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:khadamat/features/google_map/cubit/google_maps_cubit.dart';
import 'package:khadamat/features/my_posts/cubit/my_posts_cubit.dart';
import 'package:khadamat/features/notification/cubit/nottification_cubit.dart';
import 'package:khadamat/features/register/cubit/register_cubit.dart';


import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'package:khadamat/injector.dart' as injector;

import 'features/add services/cubit/add_service_cubit.dart';
import 'features/details_from_deeplink/details_deeplink/details_deeplink_cubit.dart';
import 'features/favorite/cubit/favorite_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/notification_details/cubit/notification_details_cubit.dart';
import 'features/posts/cubit/posts_cubit.dart';
import 'features/privacy_about/cubit/privacy_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/reset_password/cubit/reset_password_cubit.dart';
import 'features/splash/cubit/splash_cubit.dart';

class Khadamat extends StatefulWidget {
  const Khadamat({Key? key}) : super(key: key);

  @override
  State<Khadamat> createState() => _KhadamatState();
}

class _KhadamatState extends State<Khadamat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(text);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector.serviceLocator<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PostsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<FavoriteCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<EditProfileCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<PrivacyCubit>(),
        ),

        BlocProvider(
          create: (_) => injector.serviceLocator<MyPostsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<AddServiceCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<DetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ContactUsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NottificationCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<GoogleMapsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<RegisterCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<NotificationDetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => injector.serviceLocator<ResetPasswordCubit>(),
        ),

        BlocProvider(
          create: (_) => injector.serviceLocator<DetailsDeeplinkCubit>(),
        ),


      ],
      child: GetMaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: appTheme(),
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        // standard dark theme
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
