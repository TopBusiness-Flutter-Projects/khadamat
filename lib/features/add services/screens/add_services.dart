import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khadamat/core/utils/app_colors.dart';

import '../../../core/widgets/custom_textfield.dart';

class AddServicesScreen extends StatelessWidget {
  const AddServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 18),
              child: Text(
                "name".tr(),
              ),
            ),
            CustomTextField(
              title: 'name'.tr(),
              backgroundColor: AppColors.white,
              textInputType: TextInputType.text,
              // controller: ,
              validatorMessage: 'name_valid'.tr(),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, ),
                  child: Text("activity_type".tr()),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.arrow_drop_down_outlined,size: 30,),
                ),
                SizedBox(
                  width: size.width * 0.68,
                  child: CustomTextField(
                    title: 'activity_type'.tr(),
                    backgroundColor: AppColors.white,
                    textInputType: TextInputType.text,
                    // controller: ,
                    validatorMessage: 'name_valid'.tr(),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, ),
              child: Text("contact_numbers".tr()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, ),
                  child: Text("contact_number1".tr()),
                ),

                SizedBox(
                  width: size.width * 0.7,
                  child: CustomTextField(
                    title: 'contact_number1'.tr(),
                    backgroundColor: AppColors.white,
                    textInputType: TextInputType.number,
                    // controller: ,
                    validatorMessage: 'name_valid'.tr(),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, ),
                  child: Text("contact_number2".tr()),
                ),

                SizedBox(
                  width: size.width * 0.7,
                  child: CustomTextField(
                    title: 'contact_number2'.tr(),
                    backgroundColor: AppColors.white,
                    textInputType: TextInputType.number,
                    // controller: ,
                    validatorMessage: 'name_valid'.tr(),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, ),
              child: Text("Service_details".tr()),
            ),
            SizedBox(
             // width: size.width * 0.7,
              child: CustomTextField(
                contentPadding: EdgeInsets.all(70),
                title: ' ',
                backgroundColor: AppColors.white,
                textInputType: TextInputType.text,
                // controller: ,
                validatorMessage: 'name_valid'.tr(),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("download_service_logo".tr()),
                      Text("geographical_location".tr()),

                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.gray,
                    child: CircleAvatar(
                      radius: 49,
                      backgroundColor: AppColors.white,
                    ),

                  ),

                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0, ),
              child: Text("download_service_photos".tr()),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  height: size.height*0.2,
                  width: size.width*0.3,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.gray,
                      
                    )
                  ),
                );
              },),
            ),
            SizedBox(height: 80,),


          ],
        ),
      ),
    );
  }
}
