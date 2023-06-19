import 'package:flutter/material.dart';
import 'package:khadamat/core/models/categories_model.dart';

import '../../../core/models/cities_model.dart';
import '../../../core/utils/app_colors.dart';


class CategoryDropDown extends StatelessWidget {
  void Function(CategoriesDatum?)? onChanged ;
  void Function()? onTap;
  List<CategoriesDatum>? items=[];
  void Function(CategoriesDatum?)? onSaved;
  CategoriesDatum? dropdownValue;
  String? hint;

  CategoryDropDown({Key? key,
    required this.onChanged,
    this.onSaved,
    this.items,
    this.dropdownValue,
    required this.hint,
    this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: AppColors.gray),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        dropdownColor: AppColors.white,
        value: dropdownValue,
        onChanged: onChanged,
        onTap:onTap ,

        items:
        items?.map<DropdownMenuItem<CategoriesDatum>>((CategoriesDatum value) {
          return DropdownMenuItem<CategoriesDatum>(
            value: value,
            child: Text("${value.name}",
              style: TextStyle(fontSize: 16,color: AppColors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}




class CitiesDropDown extends StatelessWidget {
  void Function(City?)? onChanged ;
  void Function()? onTap;
  List<City>? items=[];
  void Function(CategoriesDatum?)? onSaved;
  City? dropdownValue;
  String? hint;

  CitiesDropDown({Key? key,
    required this.onChanged,
    this.onSaved,
    this.items,
    this.dropdownValue,
    required this.hint,
    this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: AppColors.gray),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        dropdownColor: AppColors.white,
        value: dropdownValue,
        onChanged: onChanged,
        onTap:onTap ,
        items:
        items?.map<DropdownMenuItem<City>>((value) {
          return DropdownMenuItem<City>(
            value: value,
            child: Text("${value.name}",
              style: TextStyle(fontSize: 16,color: AppColors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}