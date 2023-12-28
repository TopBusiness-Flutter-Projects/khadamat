class EndPoints {
  static const String baseUrl =
      'https://el-3mda.com/api/'; //khdamat.topbusiness.io  l-3mda.com
  static const String deepbaseUrl =
      'https://el-3mda.com/'; //khdamat.topbusiness.io  l-3mda.com
  static const String loginUrl = '${baseUrl}auth/login';
  static const String homeUrl = '${baseUrl}home';
  static const String getServiceDetailsUrl = '${baseUrl}services/get_service';
  static const String resetPasswordUrl = '${baseUrl}auth/resetPassword';
  static const String checkPhoneUrl = '${baseUrl}auth/checkPhone';
  static const String citiesUrl = '${baseUrl}cities';
  static const String servicesUrl = '${baseUrl}services/';
  static const String subServicesUrl = '${baseUrl}sub-categories/';
  static const String editServicesUrl = '${baseUrl}services/update/';
  static const String favoriteUrl = '${baseUrl}services/get-favourites';
  static const String myServicesUrl = '${baseUrl}services/my_services';
  static const String updateProfileUrl = '${baseUrl}client/auth/update-profile';
  static const String settingUrl = '${baseUrl}setting';
  static const String serviceStoreUrl = '${baseUrl}services/store';
  static const String categoriesUrl = '${baseUrl}categories';
  static const String rateUrl = '${baseUrl}services/add-rate';
  static const String addToFavouriteUrl =
      '${baseUrl}services/add-to-favourites';
  static const String deepLink = '${deepbaseUrl}service/';
  static const String searchUrl = '${baseUrl}search';
  static const String notificationUrl = '${baseUrl}notifications';
  static const String registerUrl = '${baseUrl}client/auth/register';

  ///checkToken
  static const String checkToken = '${baseUrl}checkToken';
}
