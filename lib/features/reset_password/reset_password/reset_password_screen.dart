import 'package:easy_localization/easy_localization.dart'as oo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>(debugLabel: 'resetpasswordScreenkey');

  @override
  Widget build(BuildContext context) {
    String lang = oo.EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.introBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if(state is ModelExistState){
              Navigator.pushNamed(context, Routes.homeRoute);
            }
            if(state is ModelDoesNotExist){
              Navigator.pushNamed(context, Routes.registerScreenRoute);
            }
          },
          builder: (context, state) {
            ResetPasswordCubit cubit = context.read<ResetPasswordCubit>();
            return Form(
              key: formKey5,
              child: SafeArea(
                child: ListView(
                  children: [
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: SizedBox(
                            //  width: MediaQuery.of(context).size.width*0.7,
                            height: MediaQuery.of(context).size.height*0.32,
                            child: Image.asset(ImageAssets.logoImage),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),
                    //password 1
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.0,),
                      child: TextFormField(
                        controller: cubit.passwordController1,
                        obscureText: cubit.isObscureText,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_password'.tr();
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          hintText: "enter_new_password".tr(),
                          prefixIcon: InkWell(
                            onTap: () {
                              cubit.changePasswordIcon();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25.0,),
                              child: Icon(cubit.passwordIcon,color: AppColors.primary,size: 30,),
                            ),
                          ),
                          //   contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border:   OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                          fillColor: AppColors.white,
                          filled: true,
                          hintTextDirection: TextDirection.ltr,
                          hintStyle:
                          TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //password 2
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.0,),
                      child: TextFormField(
                        controller: cubit.passwordController2,
                        obscureText: cubit.isObscureText,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_password'.tr();
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          hintText: "confirm_new_password".tr(),
                          prefixIcon: InkWell(
                            onTap: () {
                              cubit.changePasswordIcon();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25.0,),
                              child: Icon(cubit.passwordIcon,color: AppColors.primary,size: 30,),
                            ),
                          ),
                          //   contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border:   OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                          fillColor: AppColors.white,
                          filled: true,
                          hintTextDirection: TextDirection.ltr,
                          hintStyle:
                          TextStyle(color: AppColors.primary),
                        ),

                      ),
                    ),


                    SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    CustomButton(
                      text: 'confirm'.tr(),
                      color: AppColors.secondPrimary,
                      paddingHorizontal: 40,
                      borderRadius: 30,
                      onClick: () async {
                        if(formKey5.currentState!.validate()){
                          await cubit.resetPassword();
                        }
                      },
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          ImageAssets.bottomImage,
                          height: MediaQuery.of(context).size.height / 3.89,
                          width: MediaQuery.of(context).size.width*0.99 ,
                          fit: BoxFit.cover,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
