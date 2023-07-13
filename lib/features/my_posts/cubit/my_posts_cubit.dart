import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../core/models/catigoreis_services.dart';
import '../../../core/models/favorite_model.dart';
import '../../../core/models/my_services_model.dart';
import '../../../core/models/serviceToUpdate.dart';
import '../../../core/models/servicemodel.dart';
import '../../../core/models/updated_model.dart';
import '../../../core/remote/service.dart';
import '../../add services/cubit/add_service_cubit.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit(this.api) : super(MyPostsInitial()) {
    getMyPostsList();
  }


  final ServiceApi api;
  List<ServicesModel> modelList = [];
  late  MyServicesModel myServicesModel;

  // late  UpdatedModel updateServiceModel;
  // late ServicesModel updatedItem ;

  getMyPostsList() async {
    modelList.clear();//todo
    // emit(MyPostsLoaded());

    final response = await api.getMyServicesData();
    response.fold(
          (l) => emit(MyPostsError()),
          (r) {
        modelList = r.data!;
       // myServicesModel = r;
        emit(MyPostsLoaded());
      },
    );
  }

  getMyPostsSearchList(searchKey) async {
    emit(MyPostsSearchLoading());
    final response = await api.getMyServicesSearchData(searchKey);
    response.fold(
          (l) => emit(MyPostsSearchError()),
          (r) {
            myServicesModel = r;
        modelList = r.data!;

        emit(MyPostsSearchSuccess());
      },
    );
  }

  // updateAd(int id,  ServiceToUpdate serviceToUpdate) async {
  //
  //
  //   emit(EditServiceLoading());
  //   final response = await api.editService(id,serviceToUpdate);
  //   response.fold(
  //           (l) => emit(EditServiceFailure()),
  //           (r) {
  //             updateServiceModel = r;
  //             updatedItem = r.data!;
  //
  //             emit(EditServiceSuccess());
  //           });
  // }

  Future<void> setData(BuildContext context, ServicesModel model) async {
    context.read<AddServiceCubit>().isUpdate = true;
    context.read<AddServiceCubit>().nameController.text = model.name!;
    context.read<AddServiceCubit>().locationController.text = model.location!;
    context.read<AddServiceCubit>().contact1Controller.text =model.phones?[0];
    context.read<AddServiceCubit>().contact2Controller.text = model.phones?[1];
    context.read<AddServiceCubit>().detailsController.text = model.details!;
    context.read<AddServiceCubit>().currentCategory?.name = model.category;
   // context.read<AddServiceCubit>().city_id = model.cityId;
    context.read<AddServiceCubit>().serviceLogoImage= XFile(model.logo!);
    context.read<AddServiceCubit>().cityHint = model.cityName??"Abha";
    context.read<AddServiceCubit>().categoryHint = model.category??"Gym";
    context.read<AddServiceCubit>().serviceImages= await convertStringListToXFileList(model.images);
   // context.read<AddServiceCubit>().getCities();
  }
  // convert a List<String> to List<XFile?>
  Future<List<XFile?>> convertStringListToXFileList(List<String>? stringList) async {
    if (stringList == null) return [];

    List<XFile?> xFileList = [];
    for (String imageUrl in stringList) {
      var imagePath = await downloadAndSaveFile(imageUrl);
      XFile? xFile = XFile(imagePath!);
      xFileList.add(xFile);
    }
    return xFileList;
  }

  //Here's an example of how you can download a file from a URL and save it locally
  Future<String?> downloadAndSaveFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File('${documentDirectory.path}/filename.png');
    await file.writeAsBytes(response.bodyBytes);

    return file.path;
  }
}