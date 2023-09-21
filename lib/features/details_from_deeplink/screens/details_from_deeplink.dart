import 'package:flutter/material.dart';
import 'package:khadamat/config/routes/app_routes.dart';

class DetailsFromDeepLink extends StatelessWidget {
  final int? id ;
  const DetailsFromDeepLink({super.key,this.id});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        Navigator.pushNamed(context, Routes.homeRoute);
        return true;
      },
      child: Scaffold(
        body: id!=0?
        Center(child: Text("no details"),):
        Column(
          children: [],
        ),
      ),
    );
  }
}
