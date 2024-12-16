import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import 'components/setting_error_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appSettinBloc = context.read<AppSettingCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(

      body: BlocConsumer<AppSettingCubit, AppSettingState>(
        listener: (context, state) {
          if (state is AppSettingStateLoaded) {
            if (loginBloc.isLogedIn) {
              context.read<ProfileCubit>().getAgentProfile();
              context.read<ProfileCubit>().getAgentDashboardInfo();
              Navigator.pushReplacementNamed(
                  context, RouteNames.mainPageScreen);
            } else if (appSettinBloc.isOnBoardingShown) {
              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            } else {
              Navigator.pushReplacementNamed(
                  context, RouteNames.onBoardingScreen);
            }
          }
        },
        builder: (context, state) {
          if (state is AppSettingStateError) {
            return SettingErrorWidget(message: state.meg);
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: 800,
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
                        'assets/Yash/images/splashPhoto.png',
                        width: 200.3,
                        height: 154.41,
                      ),
                      const SizedBox(height: 20),

                      Container(
                        width: 324,
                        height: 199.59,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 38.59,
                              child: SizedBox(
                                width: 324,
                                child: Text(
                                  'We’re thrilled to have you here! Whether you’re searching for your dream home, exploring investment opportunities, or looking for a new rental, our app is designed to make your property journey seamless and enjoyable.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8500000238418579),
                                    fontSize: 18,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 23,
                              top: 0,
                              child: Text(
                                'WELCOME TO ZINGCITY',
                                style: TextStyle(
                                  color: Color(0xFF398BCB),
                                  fontSize: 24,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 292.53,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Thank you for choosing ',
                                style: TextStyle(
                                  color: Color(0xFF30469A),
                                  fontSize: 18,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'ZINGCITY',
                                style: TextStyle(
                                  color: Color(0xFF30469A),
                                  fontSize: 18,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: ' Let’s start your property journey together!',
                                style: TextStyle(
                                  color: Color(0xFF30469A),
                                  fontSize: 18,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
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
