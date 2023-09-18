import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:khadamat/core/widgets/my_svg_widget.dart';

import 'package:khadamat/features/register/cubit/register_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> form_key2 = GlobalKey<FormState>(debugLabel: 'registerScreenkey');

  @override
  Widget build(BuildContext context) {
    String lang = oo.EasyLocalization.of(context)!.locale.languageCode;
    return
      Form(

         key: form_key2,
      child:
    Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.introBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              // if (state is RegisterFailedUserExistState) {
              //   errorGetBar("Failed,phone number already exists");
              //   Navigator.pushNamed(context, Routes.loginRoute);
              // }
            },
            builder: (context, state) {
              RegisterCubit cubit = context.read<RegisterCubit>();
              return SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: MediaQuery.of(context).size.height / 4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Hero(
                              tag: 'logo',
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: Image.asset(
                                  ImageAssets.logoImage,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    MySvgWidget(
                                      path: ImageAssets.phoneIcon,
                                      imageColor: AppColors.primary,
                                      size: 35,
                                    ),
                                    SizedBox(width: 0),
                                    Expanded(
                                      child: InternationalPhoneNumberInput(
                                        // countries: ['SA', 'EG'],
                                        inputDecoration: InputDecoration(
                                          // contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 25),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          fillColor: AppColors.white,
                                          enabled: false,
                                          hintText: 'phone_number_text'.tr(),
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: TextStyle(
                                              color: AppColors.primary),
                                          filled: true,
                                        ),
                                        locale: lang,
                                        searchBoxDecoration: InputDecoration(
                                          labelText: 'search_country'.tr(),
                                        ),
                                        errorMessage: null,
                                        isEnabled: true,
                                        onInputChanged: (PhoneNumber number) {
                                          cubit.phoneCode = number.dialCode!;
                                        },
                                        autoFocusSearch: true,
                                        initialValue:
                                            PhoneNumber(isoCode: 'EG'),
                                        selectorConfig: SelectorConfig(
                                          selectorType: PhoneInputSelectorType
                                              .BOTTOM_SHEET,
                                          showFlags: false,
                                          setSelectorButtonAsPrefixIcon: false,
                                          useEmoji: true,
                                          trailingSpace: false,
                                          leadingPadding: 0,
                                        ),
                                        ignoreBlank: true,
                                        selectorTextStyle: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 16,
                                        ),
                                        textStyle:
                                            TextStyle(color: AppColors.primary),

                                        textAlign: TextAlign.end,
                                        formatInput: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'phone_validator_message'
                                                .tr();
                                          }
                                          return null;
                                        },
                                        textFieldController:
                                            cubit.phoneController,
                                        // spaceBetweenSelectorAndTextField: 20,
                                        keyboardType: TextInputType.phone,
                                        keyboardAction: TextInputAction.done,
                                        inputBorder: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: AppColors.primary,
                                      size: 35,
                                    ),
                                    SizedBox(width: 0),
                                    Expanded(
                                        child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: cubit.nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'username_valid'.tr();
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'username'.tr(),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: AppColors.white,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            CustomButton(
                              text: 'done_btn'.tr(),
                              color: AppColors.primary,
                              paddingHorizontal: 80,
                              borderRadius: 20,
                              onClick: () async {
                                //todo register
                               if (form_key2.currentState!.validate()) {
                                  await cubit.register(context);
                             //     Navigator.pushNamed(context, Routes.otpRoute);
                                }
                              },
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        ImageAssets.bottomImage,
                        height: MediaQuery.of(context).size.height / 3.2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      )
   );
  }
}
