import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:khadamat/core/widgets/my_svg_widget.dart';
import 'package:khadamat/features/login/cubit/login_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey3 =
      GlobalKey<FormState>(debugLabel: 'loginScreenkey');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String lang = oo.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.introBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              isLoading = true;
            } else {
              isLoading = false;
            }
          },
          builder: (context, state) {
            LoginCubit cubit = context.read<LoginCubit>();
            return Form(
              key: formKey3,
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
                    SizedBox(
                      height: 20,
                    ),
                    //password
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 27.0,
                      ),
                      child: TextFormField(
                        controller: cubit.passwordController,
                        obscureText: cubit.isObscureText,
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 20),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_password'.tr();
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          hintText: "enter_password".tr(),
                          prefixIcon: InkWell(
                            onTap: () {
                              cubit.changePasswordIcon();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 25.0,
                              ),
                              child: Icon(
                                cubit.passwordIcon,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                          ),
                          //   contentPadding: EdgeInsets.symmetric(vertical: 20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                          fillColor: AppColors.white,
                          filled: true,
                          hintTextDirection: TextDirection.ltr,
                          hintStyle: TextStyle(color: AppColors.primary),
                        ),

                        // title: 'password'.tr(),
                        // isPassword: true,
                        // controller: cubit.passwordController,
                        // backgroundColor:AppColors.white ,
                        // textInputType: TextInputType.text,
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.forgotPasswordRoute);
                            },
                            child: Text(
                              "forgot_password",
                              style: TextStyle(
                                  color: AppColors.yellow,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ).tr()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : CustomButton(
                            text: 'login'.tr(),
                            color: AppColors.secondPrimary,
                            paddingHorizontal: 40,
                            borderRadius: 30,
                            onClick: () async {
                              if (formKey3.currentState!.validate()) {
                                await cubit.login(context);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.registerScreenRoute);
                                },
                                child: Text(
                                  "have_no_account",
                                  style: TextStyle(
                                      color: AppColors.yellow,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ).tr()),
                            //   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                          ],
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
