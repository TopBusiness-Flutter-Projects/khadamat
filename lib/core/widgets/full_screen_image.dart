import 'package:flutter/material.dart';

import 'network_image.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child:ManageNetworkImage(
            imageUrl: imageUrl,
            boxFit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

          )
         // Image.network(imageUrl),
        ),
      ),
    );
  }
}