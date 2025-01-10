import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/logic/bloc/General/general_cubit.dart';
import 'package:real_estate/logic/bloc/login/login_cubit.dart';
import 'package:real_estate/logic/cubit/home/cubit/home_cubit.dart';
import 'package:real_estate/logic/cubit/profile/profile_cubit.dart';
import 'package:real_estate/logic/repository/auth_repository.dart';
// import 'package:real_estate/logic/bloc/signup/sign_up_bloc.dart';

import '/presentation/utils/k_strings.dart';
import 'logic/bloc/signup/sign_up_cubit.dart';
import 'logic/bloc/splash_screen_cubit.dart';
import 'presentation/router/route_names.dart';
import 'presentation/widget/custom_theme.dart';
import 'state_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await StateInjector.init();
  runApp(const RealEstate());
}

class RealEstate extends StatelessWidget {
  const RealEstate({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return  MultiBlocProvider(
          // providers: StateInjector.blocProviders,
          providers: [
            BlocProvider<SplashScreenCubit>(create: (_) => SplashScreenCubit()..chekToken()),
            BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
            BlocProvider<GeneralCubit>(create: (_) => GeneralCubit()),
            BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
            BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: KString.appName,
            onGenerateRoute: RouteNames.generateRoutes,
            theme: CustomTheme.theme,
            initialRoute: RouteNames.splashScreen,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
