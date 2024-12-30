import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:real_estate/logic/bloc/General/general_cubit.dart';

import '../../../data/model/auth/user_login_response_model.dart';
import '../../../presentation/error/failure.dart';
import '../../../presentation/router/route_names.dart';
import '../../../state_inject_package_names.dart';
import 'login_bloc.dart';

class LoginCubit extends Cubit<LoginModelState> {
  LoginCubit() : super(LoginModelState());

  final Respository _authRepository = Respository();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyOtpController = TextEditingController();

  Future<dynamic> onPressLogin(String number) async {
    var res = await _authRepository.login(number);

    // if(res){}
    var data = jsonDecode(res.body);
    log('res: ${data}', name: 'LoginCubit');
    debugPrint('res: ${data}');
    if (data["status"]) {
      emit(state.copyWith(
        time: data["time"].toString(),
      ));
      return true;
    }
  }

  Future<dynamic> verifyOtp(
      String number, String otp, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await _authRepository.OtpVerfy(number, otp);
    var data = jsonDecode(res.body);
    log('res: ${data}', name: 'LoginCubit verify');
    if (data["status"]) {
      UserModel user = UserModel.fromJson(data["user"]);
      context.read<GeneralCubit>().setUser(user);
      if(user.name == null){
        Navigator.pushReplacementNamed(
            context, RouteNames.updateProfileScreen,arguments: user);
      } else {
        Navigator.pushReplacementNamed(
            context, RouteNames.mainPageScreen);
      }
      await prefs.setString("token", data["access_token"].toString());
      String? token = await prefs.getString("token");
      _authRepository.updateHeader(token);
      return true;
    }
  }

  void startTimer() {
    // Convert the given time (in minutes) into total seconds
    int totalSeconds = int.parse(state.time!) * 60;

    // Start the countdown timer
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (totalSeconds > 0) {
        totalSeconds--;

        // Calculate remaining minutes and seconds
        int remainingMinutes = totalSeconds ~/ 60;
        int remainingSeconds = totalSeconds % 60;

        // Update the state with time left in "X mins Y secs left" format
        emit(state.copyWith(
            timeLeft:
                '$remainingMinutes min${remainingMinutes > 1 ? "s" : ""} $remainingSeconds sec${remainingSeconds > 1 ? "s" : ""} left'));
      } else {
        timer.cancel();
        print("Timer Completed!");
        emit(state.copyWith(timeLeft: 'Expired!'));
      }
    });
  }

//
// LoginBloc({
//   required AuthRepository authRepository,
//   required ProfileRepository profileRepository,
// })  : _authRepository = authRepository,
//       _profileRepository = profileRepository,
//       super(const LoginModelState()) {
//   on<LoginEvenEmailOrPhone>((event, emit) {
//     emit(state.copyWith(text: event.text, state: const LoginStateInitial()));
//   });
//   on<LoginEventPassword>((event, emit) {
//     emit(state.copyWith(
//         password: event.password, state: const LoginStateInitial()));
//   });
//   on<LoginEventSubmit>(_submitLoginForm);
//   on<SentAccountActivateCodeSubmit>(_sentAccountActivateCode);
//   on<LoginEventLogout>(_logOut);
//   on<LoginEventCheckProfile>(_getUserInfo);
//
//   /// set user data if user already login
//
//   final result = _authRepository.getCashedUserInfo();
//
//   result.fold(
//         (l) => _user = null,
//         (r) {
//       user = r;
//     },
//   );
// }

// Future<void> _getUserInfo(
//     LoginEventCheckProfile event,
//     Emitter<LoginModelState> emit,
//     )
// async {
//   final result = _authRepository?.getCashedUserInfo();
//
//   result?.fold(
//         (l) => _user = null,
//         (r) {
//       user = r;
//       emit(state.copyWith(state: LoginStateLoaded(r)));
//     },
//   );
// }

// Future<void> _submitLoginForm(
//     LoginEventSubmit event,
//     Emitter<LoginModelState> emit,
//     )
// async {
//   emit(state.copyWith(state: const LoginStateLoading()));
//   final bodyData = state.toMap();
//
//   final result = await _authRepository?.login(bodyData);
//
//   result?.fold(
//         (failure) {
//       if (failure is InvalidAuthData) {
//         final errors = LoginStateFormInvalid(failure.errors);
//         emit(state.copyWith(state: errors));
//       } else {
//         final error = LoginStateError(failure.message, failure.statusCode);
//         emit(state.copyWith(state: error));
//       }
//     },
//         (user) {
//       final loadedData = LoginStateLoaded(user);
//       _user = user;
//       emit(state.copyWith(state: loadedData));
//
//       emit(state.copyWith(
//         text: '',
//         password: '',
//         state: const LoginStateInitial(),
//       ));
//     },
//   );
// }

// Future<void> _sentAccountActivateCode(
//     SentAccountActivateCodeSubmit event,
//     Emitter<LoginModelState> emit,
//     )
// async {
//   emit(state.copyWith(state: const LoginStateLoading()));
//
//   final result = await _authRepository?.sendActiveAccountCode(state.text);
//
//   result?.fold(
//         (Failure failure) {
//       final error = LoginStateError(failure.message, failure.statusCode);
//       emit(state.copyWith(state: error));
//     },
//         (String success) {
//       final loadedData = SendAccountCodeSuccess(success);
//       emit(state.copyWith(state: loadedData));
//     },
//   );
// }

// Future<void> _logOut(
//     LoginEventLogout event,
//     Emitter<LoginModelState> emit,
//     )
// async {
//   emit(state.copyWith(state: const LoginStateLogOutLoading()));
//
//   final result = await _authRepository?.logOut(userInfo!.accessToken);
//
//   result?.fold(
//         (Failure failure) {
//       if (failure.statusCode == 500) {
//         const loadedData = LoginStateLogOut('logout success', 200);
//         emit(state.copyWith(state: loadedData));
//       } else {
//         final error =
//         LoginStateSignOutError(failure.message, failure.statusCode);
//         emit(state.copyWith(state: error));
//       }
//     },
//         (String success) {
//       _user = null;
//       final loadedData = LoginStateLogOut(success, 200);
//       emit(state.copyWith(state: loadedData));
//     },
//   );
// }
}
