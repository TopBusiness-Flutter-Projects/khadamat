import 'package:easy_localization/easy_localization.dart' as oo;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:khadamat/core/widgets/my_svg_widget.dart';
import 'package:khadamat/features/login/cubit/login_cubit.dart';
import 'package:page_transition/page_transition.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../register/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'loginScreenkey');


  @override
  Widget build(BuildContext context) {
    String lang = oo.EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.introBackgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            LoginCubit cubit = context.read<LoginCubit>();
            return Form(
              key: formKey,
              child: SafeArea(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 16),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.topToBottomJoined,
                                        alignment: Alignment.topCenter,
                                        duration: const Duration(milliseconds: 500),
                                        reverseDuration:
                                            const Duration(milliseconds: 500),
                                        child: RegisterScreen(),
                                        childCurrent: widget,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'register'.tr(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 27.0,),
                              child: TextFormField(
                                obscureText: true,
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
                                hintText: "Enter password",


                                 prefixIcon: Padding(
                                   padding: const EdgeInsets.only(right: 25.0,),
                                   child: Icon(Icons.remove_red_eye_rounded,color: AppColors.primary,size: 30,),
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

                                // title: 'password'.tr(),
                                // isPassword: true,
                                // controller: cubit.passwordController,
                                // backgroundColor:AppColors.white ,
                                // textInputType: TextInputType.text,


                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.03),
                            CustomButton(
                              text: 'login'.tr(),
                              color: AppColors.secondPrimary,
                              paddingHorizontal: 40,
                              borderRadius: 30,
                              onClick: () {
                                if(formKey.currentState!.validate()){
                                 cubit.login();
                                }
                              },
                            ),
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
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
