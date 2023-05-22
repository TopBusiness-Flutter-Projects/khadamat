import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/login_cubit.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final formKey = GlobalKey<FormState>();

  bool hasError = false;

  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    errorController = StreamController<ErrorAnimationType>();
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          LoginCubit cubit = context.read<LoginCubit>();
          // if (state is CheckCodeSuccessfully) {
          //   Future.delayed(const Duration(milliseconds: 500), () {
          //     context.read<RegisterCubit>().isCodeSend = true;
          //     context.read<NavigatorBottomCubit>().page=0;
          //     cubit.isRegister
          //         ? context.read<RegisterCubit>().registerUserData()
          //         : null;
          //     cubit.isRegister
          //         ? Navigator.pop(context)
          //         : Navigator.pushAndRemoveUntil(
          //             context,
          //             PageTransition(
          //               type: PageTransitionType.fade,
          //               alignment: Alignment.center,
          //               duration: const Duration(milliseconds: 1300),
          //               child: NavigationBottom(
          //                 loginModel: cubit.loginModel ?? LoginModel(),
          //               ),
          //             ),
          //             (route) => false,
          //           ).then((value) => null);
          //   });
          //   // return const ShowLoadingIndicator();
          // }
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.introBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(ImageAssets.logoImage),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30,
                    ),
                    child: PinCodeTextField(
                      // backgroundColor: AppColors.white,
                      hintCharacter: '-',
                      textStyle:
                          TextStyle(color: AppColors.white),
                      hintStyle:
                          TextStyle(color: AppColors.primary),
                      pastedTextStyle: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      appContext: context,
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 5) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: AppColors.white,
                        activeColor: AppColors.primary,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        selectedColor: AppColors.primary,
                      ),
                      cursorColor: AppColors.textBackground,
                      animationDuration:
                          const Duration(milliseconds: 300),
                      errorAnimationController: errorController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError
                        ? 'verification_validator_message'.tr()
                        : "",
                    style: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'done_btn'.tr(),
                  color: AppColors.primary,
                  paddingHorizontal: 40,
                  borderRadius: 30,
                  onClick: () {
                    formKey.currentState!.validate();
                    if (currentText.length != 6) {
                      errorController!.add(
                        ErrorAnimationType.shake,
                      ); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                        () {
                          hasError = false;
                          // context
                          //     .read<LoginCubit>()
                          //     .verifySmsCode(currentText);
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: lang=='en'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / 8),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppColors.white, // Text Color
                      ),
                      child: Text('back_btn'.tr(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
