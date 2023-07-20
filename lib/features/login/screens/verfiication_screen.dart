import 'dart:async';
import 'package:easy_localization/easy_localization.dart' as oo;


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../config/routes/app_routes.dart';
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
    //String lang = EasyLocalization.of(context)!.locale.languageCode;
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
      if(state is ModelExistState){
        Navigator.pushNamed(context, Routes.homeRoute);
      }
      if(state is ModelDoesNotExist){
        Navigator.pushNamed(context, Routes.registerScreenRoute);
      }
      },
      builder: (context, state) {

     return
       Scaffold(
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
            return Stack(
              children: [
                Container(
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
                      const SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 30,
                          ),
                          child:Directionality(
                            textDirection: TextDirection.ltr,
                            child:   PinCodeTextField(

                              // backgroundColor: AppColors.white,
                              hintCharacter: '-',
                              textStyle: TextStyle(color: AppColors.white,locale: Locale("en")),
                              hintStyle: TextStyle(color: AppColors.primary),
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
                                activeColor: AppColors.secondPrimary,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(15),
                                selectedColor: AppColors.secondPrimary,
                              ),
                              cursorColor: AppColors.secondPrimary,
                              animationDuration: const Duration(milliseconds: 300),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError ? oo.tr('verification_validator_message'): "",
                          //hasError ? 'verification_validator_message' : "",
                          style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: oo.tr('done_btn'),
                       // text: 'تـم',
                        color: AppColors.secondPrimary,
                        paddingHorizontal: 40,
                        textcolor: AppColors.black,
                        borderRadius: 30,
                        onClick: () async {
                          formKey.currentState!.validate();
                          if (currentText.length != 6) {
                            errorController!.add(
                              ErrorAnimationType.shake,
                            ); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            //TODO
                            await context.read<LoginCubit>().verifySmsCode(currentText);
                           // var model=await  Preferences.instance.getUserModel();
                           // if(model==null){
                           //   Navigator.pushNamed(context, Routes.otpRoute);
                           // }else{
                           //   Navigator.pushNamed(context, Routes.registerScreenRoute);
                           // }
                             setState(
                               () {
                                hasError = false;
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => HomeScreen()),
                                // );
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
                        alignment: Alignment.center,
                        // alignment: lang == 'en'
                        //     ? Alignment.centerRight
                        //     : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 8),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.white,
                            ),
                            child: Text(
                              oo.tr("back_btn"),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                    right: 0,
                    left: 0,
                    child: Image.asset(ImageAssets.bottomImage))
              ],
            );
          },
        ),
      );
      },
    );
  }
}
