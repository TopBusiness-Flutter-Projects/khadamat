import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';

class ProfileListTailWidget extends StatelessWidget {
  const ProfileListTailWidget({
    Key? key,
    required this.title,
    required this.onclick,
    required this.image,
    required this.imageColor,
    this.widget,
  }) : super(key: key);

  final String title;
  final VoidCallback onclick;
  final String image;
  final Color imageColor;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onclick,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        image,
                        // colorFilter: ColorFilter.mode(imageColor, BlendMode.srcIn),
                        color: imageColor,
                        height: 28,
                        width: 28,
                      ),
                      SizedBox(width: 22),
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: widget ?? SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
