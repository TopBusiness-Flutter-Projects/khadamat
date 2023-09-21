import 'package:geocoding/geocoding.dart';
import 'package:khadamat/core/models/cities_model.dart';

String getCityName(List<City> cities ,cityId)  {
  for(var city in cities){
    print(city.name);
    if(city.id == cityId ){

      return city.name!;
    }
  }
  return "";
}


// Future<String> getAddressFromLatLng(double latitude, double longitude) async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//
//     if (placemarks != null && placemarks.isNotEmpty) {
//       Placemark placemark = placemarks[0];
//       return '${placemark.street},pppppppppppppp';
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   return '';
// }

Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    print("***************************************************");
    print("latitude = $latitude");
    print("longitude = $longitude");
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address = '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
      print("address = $address");
      return address;
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'Error: ${e.toString()}';
  }
}

// getCities()async{
//
//   final response = await api.getCities();
//   response.fold(
//           (l) => emit(GettingCitiesFailure()),
//           (r) {
//         cities = r.data!;
//         emit(GettingCitiesSuccess());
//       });
// }