import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '/data/data_provider/remote_url.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

int _index = 0;
PageController controller = PageController();

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final onBoardingList = context.read<AppSettingCubit>().onBoarding;
    //print(size.height);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              width: size.width,
              height: 400,
              decoration: const ShapeDecoration(
                color: Color(0x23398BCB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500),
                    bottomRight: Radius.circular(500),
                  ),
                ),
              ),
              child: Image.asset("assets/Yash/images/zingCityIcon.png",
                width: 40,
                height: 40,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nextButton(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.width * 0.3,
          height: 3.0,
          margin: EdgeInsets.only(bottom: size.height * 0.03),
          decoration: BoxDecoration(
              color: borderWithOpacityColor,
              borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            children: List.generate(
                context.read<AppSettingCubit>().onBoarding.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: size.width * 0.1,
                height: 3.0,
                decoration: BoxDecoration(
                  color: _index == index ? blackColor : transparent,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              );
            }),
          ),
        ),
        GestureDetector(
          onTap: () {
            final list = context.read<AppSettingCubit>().onBoarding.length - 1;
            if (_index == list) {
              context.read<AppSettingCubit>().cachOnBoarding();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.loginScreen, (route) => false);
              //print('last index');
            } else {
              controller.nextPage(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeInOut);
            }
            //print(_index);
          },
          child: Container(
            width: size.width * 0.5,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                .copyWith(bottom: 0.0),
            height: size.height * 0.06,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: borderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: CustomTextStyle(
                    text: 'Next',
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: whiteColor,
                  ),
                ),
                //const SizedBox(width: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: size.width * 0.12,
                    height: size.height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.22),
                      borderRadius: borderRadius,
                    ),
                    child: const Icon(
                      Icons.arrow_right_alt_outlined,
                      color: whiteColor,
                      size: 22.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget locationEnable(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.2, vertical: size.height * 0.02),
      child: Column(
        children: [
          PrimaryButton(
            text: 'Allow Location',
            onPressed: () {
              context.read<AppSettingCubit>().cachOnBoarding();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.loginScreen, (route) => false);
            },
            fontSize: 20.0,
            borderRadiusSize: radius,
            textColor: whiteColor,
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.loginScreen, (route) => false),
            child: const CustomTextStyle(
              text: 'Skip for Now',
              fontWeight: FontWeight.w500,
              color: grayColor,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}
