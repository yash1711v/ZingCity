import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate/logic/cubit/privacy_policy/privacy_policy_cubit.dart';

import '../../../logic/bloc/login/login_cubit.dart';
import '/presentation/utils/utils.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/error_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final spacer = const SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final loginBloc = context.read<LoginBloc>();
    // final appSetting =
    //     context.read<AppSettingCubit>().settingModel!.mobileAppContent;
    //print(appSetting.loginBgImage);
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginModelState>(
          // listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {}
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: size.width,
              height: 425,
              decoration: const ShapeDecoration(
                color: Color(0xFFE3EFF8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                    bottomRight: Radius.circular(300),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x1E000000),
                    blurRadius: 8,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    "assets/Yash/images/ZingCityLogo.png",
                    width: 74.2,
                    height: 51.91,
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Enter your Phone Number',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6000000238418579),
                            fontSize: 22,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        Text(
                          "You'll get a verification code from us.",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4000000059604645),
                            fontSize: 13,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BlocBuilder<LoginCubit, LoginModelState>(
                      builder: (context, state) {
                        // final login = state.state;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller:
                                  context.read<LoginCubit>().phoneController,
                              keyboardType: TextInputType.number,
                              // initialValue: state.text,
                              onChanged: (value) {
                                context
                                    .read<LoginCubit>()
                                    .phoneController
                                    .text = value;
                                // context.read<LoginCubit>().add(LoginEvenEmailOrPhone(value));
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black
                                        .withOpacity(0.10000000149011612),
                                  ),
                                ),
                                prefixIcon: SizedBox(
                                  width: 40.0,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '+91',
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(
                                                0.4000000059604645),
                                            fontSize: 15,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                hintText: 'Number',
                              ),
                            ),
                            // if (login is LoginStateFormInvalid) ...[
                            //   if (login.error.email.isNotEmpty &&
                            //       login.error.email.length < 10)
                            //     ErrorText(text: login.error.email.first)
                            // ]
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 17),
                  // SvgPicture.asset(
                  //   "assets/Yash/images/orImage.svg",
                  //   height: 22,
                  //   width: 0,
                  // ),
                  // const SizedBox(height: 47),
                  // Container(
                  //   width: 324,
                  //   height: 55,
                  //   decoration: ShapeDecoration(
                  //     color: Colors.transparent,
                  //     shape: RoundedRectangleBorder(
                  //       side: const BorderSide(width: 1, color: Color(0xFF398BCB)),
                  //       borderRadius: BorderRadius.circular(3),
                  //     ),
                  //   ),
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  //       elevation: MaterialStateProperty.all(0.0),
                  //       shape: MaterialStateProperty.all(
                  //         RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(3),
                  //         ),
                  //       ),
                  //     ),
                  //       onPressed: () {},
                  //       child:  Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset("assets/Yash/images/mailIcon.png", width: 35, height: 35,),
                  //           const SizedBox(width: 15),
                  //           const Text(
                  //             'Login with Gmail',
                  //             style: TextStyle(
                  //               color: Color(0xFF398BCB),
                  //               fontSize: 15,
                  //               fontFamily: 'DM Sans',
                  //               fontWeight: FontWeight.w400,
                  //               height: 0,
                  //             ),
                  //           )
                  //         ],
                  //       )),
                  // ),
                ],
              ),
            ),
            // Spacer(),
            const Spacer(),
            BlocBuilder<LoginCubit, LoginModelState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: (state.isLoading ?? false)
                      ? const CircularProgressIndicator()
                      : PrimaryButton(
                          text: 'Send Otp',
                          onPressed: () async {
                            await context
                                .read<LoginCubit>()
                                .onPressLogin(context
                                    .read<LoginCubit>()
                                    .phoneController
                                    .text)
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacementNamed(
                                    context, RouteNames.verificationScreen,
                                    arguments: context
                                        .read<LoginCubit>()
                                        .phoneController
                                        .text);
                              }
                            });
                            // Navigator.pushReplacementNamed(
                            //     context, RouteNames.verificationScreen,arguments: false);
                          },
                        ),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: 324,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'You accept our ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: const TextStyle(
                        color: Color(0xFF398BCB),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Terms & Conditions tap
                          print('Terms & Conditions tapped');
                          context.read<PrivacyPolicyCubit>().getTermsAndCondition();
                          Navigator.pushNamed(
                            context, RouteNames.termsAndConditionScreen,);
                        },
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: Color(0xFF398BCB),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle Privacy Policy
                          context.read<PrivacyPolicyCubit>().getPrivacyPolicy();
                          Navigator.pushNamed(
                            context, RouteNames.privacyPolicyScreen,);
                          // print('Privacy Policy tapped');
                        },
                    ),
                    TextSpan(
                      text: ' by clicking the login button.',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
