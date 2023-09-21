import 'package:flutter/material.dart';

class DetailsFromDeepLink extends StatelessWidget {
  final int? id ;
  const DetailsFromDeepLink({super.key,this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: id==null?
      Center(child: Text("no details"),):
      Column(
        children: [],
      ),
    );
  }
}
