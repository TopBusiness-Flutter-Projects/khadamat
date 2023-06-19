
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khadamat/core/utils/app_colors.dart';
import 'package:khadamat/core/utils/assets_manager.dart';
import 'package:khadamat/core/widgets/my_svg_widget.dart';


class PhoneWidget extends StatelessWidget {
  String? phone;
   PhoneWidget({Key? key, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: [
         MySvgWidget(path: ImageAssets.call2Icon, imageColor:Colors.black, size: 20),
         // Icon(Icons.phone),
          SizedBox(width: 5,),
          Text(phone??"010")
        ],
      ),
    );
  }
}
