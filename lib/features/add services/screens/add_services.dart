import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khadamat/core/utils/app_colors.dart';

import '../../../core/widgets/custom_textfield.dart';

class AddServicesScreen extends StatelessWidget {
  const AddServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
          CustomTextField(
            title: 'name'.tr(),
            backgroundColor: AppColors.white,
            textInputType: TextInputType.text,
            // controller: ,
            validatorMessage: 'name_valid'.tr(),
          ),
        ],
      ),
    );
  }
}
