import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:khadamat/features/reset_password/cubit/reset_password_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/my_svg_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final GlobalKey<FormState> formKey4 =
      GlobalKey<FormState>(debugLabel: 'forgotpasswordScreenkey');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String lang = oo.EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.introBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is LoadingCheckPhone) {
              isLoading = true;
            } else {
              isLoading = false;
            }
          },
          builder: (context, state) {
            ResetPasswordCubit cubit = context.read<ResetPasswordCubit>();
            return Form(
              key: formKey4,
              child: SafeArea(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     SizedBox(width: 16),
                    //     TextButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           PageTransition(
                    //             type: PageTransitionType.topToBottomJoined,
                    //             alignment: Alignment.topCenter,
                    //             duration: const Duration(milliseconds: 500),
                    //             reverseDuration:
                    //                 const Duration(milliseconds: 500),
                    //             child: RegisterScreen(),
                    //             childCurrent: widget,
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         'register'.tr(),
                    //         style: TextStyle(
                    //           fontSize: 25,
                    //           fontWeight: FontWeight.bold,
                    //           color: AppColors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: SizedBox(
                            //  width: MediaQuery.of(context).size.width*0.7,
                            height: MediaQuery.of(context).size.height * 0.32,
                            child: Image.asset(ImageAssets.logoImage),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "فضلا ادخل رقم تليفونك لنعيد لك كلمة المرور الخاصة بك !",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //phone
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            MySvgWidget(
                              path: ImageAssets.phoneIcon,
                              imageColor: AppColors.primary,
                              size: 35,
                            ),
                            SizedBox(width: 0),
                            //InternationalPhoneNumberInput
                            Expanded(
                              child: InternationalPhoneNumberInput(
                                // countries: ['SA', 'EG'],
                                inputDecoration: InputDecoration(
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 25),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  fillColor: AppColors.white,
                                  hintText: 'phone_number_text'.tr(),
                                  hintTextDirection: TextDirection.ltr,
                                  hintStyle:
                                      TextStyle(color: AppColors.primary),
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
                                initialValue: PhoneNumber(isoCode: 'EG'),
                                selectorConfig: SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
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
                                textStyle: TextStyle(color: AppColors.primary),

                                textAlign: TextAlign.end,
                                formatInput: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'phone_validator_message'.tr();
                                  }
                                  return null;
                                },
                                textFieldController: cubit.phoneController,
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
                    SizedBox(height: 20),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    isLoading
                        ? Container(
                            // height: 5,
                            // width: 5,
                            child: Center(child: CircularProgressIndicator()))
                        : CustomButton(
                            text: 'send'.tr(),
                            color: AppColors.secondPrimary,
                            paddingHorizontal: 40,
                            borderRadius: 30,
                            onClick: () async {
                              if (formKey4.currentState!.validate()) {
                                await cubit.checkPhone(context);
                              }
                            },
                          ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          ImageAssets.bottomImage,
                          height: MediaQuery.of(context).size.height / 3.89,
                          width: MediaQuery.of(context).size.width * 0.99,
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
