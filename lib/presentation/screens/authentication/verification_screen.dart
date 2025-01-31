import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/bloc/login/login_cubit.dart';
import 'package:real_estate/logic/bloc/signup/sign_up_state.dart';
import 'package:real_estate/logic/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:real_estate/presentation/screens/main_page/main_page_scree.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';

import '../../../logic/bloc/signup/sign_up_cubit.dart';
import '../../widget/primary_button.dart';
import '../main_page/main_page_scree.dart';
import '../main_page/main_page_scree.dart';
import '/presentation/router/route_names.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/utils/utils.dart';
import '../../../../presentation/widget/custom_images.dart';
// import '../../../logic/bloc/signup/sign_up_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // // timerStart() {
  // //   Timer.periodic(const Duration(seconds: 1), (timer) {
  // //     setState(() {
  // //       second--;
  // //       if (second < 1) {
  // //         minute--;
  // //         if (minute < 1) {
  // //           minute = 0;
  // //         }
  // //         second = minute == 0 ? 0 : 4;
  // //       }
  // //     });
  // //   });
  // // }
  // bool finishTime = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginCubit>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final bloc = context.read<SignUpCubit>();
    // final forgotCubit = context.read<ForgotPasswordCubit>();
    // print('isVerification ${widget.isVerification}');
    // print('forgotEmail ${forgotCubit.emailController.text}');
    // print('code ${forgotCubit.codeController.text}');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<LoginCubit, LoginModelState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  // height: 600,
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
                              'Verify OTP',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.6000000238418579),
                                fontSize: 22,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 324,
                              child: Text(
                                'We have sent a verification code to your number ${widget.phoneNumber}',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.4000000059604645),
                                  fontSize: 13,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Align(
                          alignment: Alignment.center,
                          child: Pinput(
                            controller:
                                context.read<LoginCubit>().verifyOtpController,
                            // bloc.pinController,

                            mainAxisAlignment: MainAxisAlignment.center,
                            defaultPinTheme: PinTheme(
                                width: 80.90,
                                height: 59.36,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: borderRadius,
                                ),
                                textStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0,
                                  color: blackColor,
                                )),
                            onCompleted: (v) {
                              context
                                  .read<LoginCubit>()
                                  .verifyOtpController
                                  .text = v;
                              // if (widget.isVerification) {
                              //   // print('new user create');
                              //   bloc.add(AccountActivateCodeSubmit(v));
                              // } else {
                              //   forgotCubit.codeController.text = v;
                              //   forgotCubit.verifyForgotPasswordCode();
                              // }
                            },
                            length: 6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 27),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Spacer(),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              state.timeLeft ?? "",
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.4000000059604645),
                                fontSize: 13,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Spacer(),
                            Visibility(
                              visible: state.timeLeft == "Expired!",
                              child: Text(
                                'Didn’t receive an OTP?',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.4000000059604645),
                                  fontSize: 13,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            Visibility(
                                visible: state.timeLeft == "Expired!",
                                child: const SizedBox(width: 5)),
                            Visibility(
                              visible:state.timeLeft == "Expired!",
                              child: GestureDetector(
                                onTap: () async {
                                  await context.read<LoginCubit>().onPressLogin(
                                      context
                                          .read<LoginCubit>()
                                          .phoneController
                                          .text);
                                },
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(
                                    color: Color(0xFF30469A),
                                    fontSize: 13,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    height: 0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 31),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: (state.isLoading ?? false)
                            ? const CircularProgressIndicator()
                            : PrimaryButton(
                                text: 'Verify Otp',
                                onPressed: () async {
                                  final otp = context
                                      .read<LoginCubit>()
                                      .verifyOtpController
                                      .text;
                                  if (otp.length != 6) {
                                    // Show an error message or handle the invalid OTP case
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please enter a valid 6-digit OTP')),
                                    );
                                    return;
                                  }

                                  await context
                                      .read<LoginCubit>()
                                      .verifyOtp(
                                          widget.phoneNumber, otp, context)
                                      .then((value) {
                                    if (value) {
                                      // Navigator.pushReplacementNamed(
                                      //     context, RouteNames.mainPageScreen);
                                    }
                                  });
                                },
                              ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

// Widget verificationWidget() {
//   final bloc = context.read<SignUpCubit>();
//   if (finishTime) {
//     return Align(
//       alignment: Alignment.center,
//       child: TimerCountdown(
//         format: CountDownTimerFormat.minutesSeconds,
//         enableDescriptions: false,
//         spacerWidth: 6.0,
//         timeTextStyle: GoogleFonts.poppins(
//           fontSize: 30.0,
//           color: whiteColor,
//           fontWeight: FontWeight.w600,
//         ),
//         colonsTextStyle: GoogleFonts.poppins(
//           fontSize: 30.0,
//           color: whiteColor,
//           fontWeight: FontWeight.w600,
//         ),
//         endTime: DateTime.now().add(
//           const Duration(minutes: 1),
//         ),
//         onEnd: () {
//           print('finish');
//           setState(() => finishTime = false);
//         },
//       ),
//     );
//   } else {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't get any Code? ",
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             fontSize: 17.0,
//             color: whiteColor,
//           ),
//         ),
//         BlocBuilder<SignUpCubit, SignUpState>(
//           builder: (context, state) {
//             return GestureDetector(
//               onTap: () {},
//                   // bloc.add(SignUpEventResendCodeSubmit(state.email)),
//               child: Text(
//                 'Resend',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 17.0,
//                   color: yellowColor,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// Widget _buildContinueBtn() {
//   final bloc = context.read<SignUpBloc>();
//   return PrimaryButton(
//     onPressed: () {
//       context
//           .read<SignUpBloc>()
//           .add(AccountActivateCodeSubmit(bloc.pinController.text));
//       //Navigator.pushNamed(context, RouteNames.updatePasswordScreen);
//     },
//     text: 'Continue',
//     borderRadiusSize: 5.0,
//   );
// }
}
