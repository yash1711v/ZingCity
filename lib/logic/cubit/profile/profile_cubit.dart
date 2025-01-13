import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/agent/agent_profile_model.dart';
import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/auth/user_login_response_model.dart';
import '../../../data/model/auth/user_profile_model.dart';
import '../../../presentation/error/failure.dart';
import '../../../presentation/router/route_names.dart';
import '../../../state_inject_package_names.dart';
import '../../bloc/General/general_cubit.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/auth_repository.dart';
import '../../repository/profile_repository.dart';
import 'profile_state_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStateModel> {
  // final ProfileRepository _profileRepository;
  // final LoginBloc _loginBloc;
  TextEditingController amountCon = TextEditingController();

  ProfileCubit() : super(ProfileStateModel());

  final Repository _authRepository = Repository();

  void nameChange(String text) {
    emit(state.copyWith(name: text, profileState: const ProfileInitial()));
  }

  void phoneChange(String text) {
    emit(state.copyWith(phone: text, profileState: const ProfileInitial()));
  }

  void addressChange(String text) {
    emit(state.copyWith(address: text, profileState: const ProfileInitial()));
  }

  void designationChange(String text) {
    emit(state.copyWith(
        designation: text, profileState: const ProfileInitial()));
  }

  void aboutMeChange(String text) {
    emit(state.copyWith(aboutMe: text, profileState: const ProfileInitial()));
  }

  void emailChange(String text) {
    emit(state.copyWith(email: text, profileState: const ProfileInitial()));
  }

  void twitterChange(String text) {
    emit(state.copyWith(twitter: text, profileState: const ProfileInitial()));
  }

  void linkedinChange(String text) {
    emit(state.copyWith(linkedin: text, profileState: const ProfileInitial()));
  }

  void instagramChange(String text) {
    emit(state.copyWith(instagram: text, profileState: const ProfileInitial()));
  }

  void imageChange(File text) {
    emit(state.copyWith(image: text, profileState: const ProfileInitial()));
  }

  void currentPassword(String value) {
    emit(
      state.copyWith(
        currentPassword: value,
        profileState: const ProfileInitial(),
      ),
    );
  }

  void showPassword() {
    emit(
      state.copyWith(
        showPassword: !(state.showPassword),
        profileState: const ProfileInitial(),
      ),
    );
  }

  void amountChange(String text) {
    emit(state.copyWith(amount: text));
  }

  void rateChange(double text) {
    emit(state.copyWith(rate: text));
  }

  void yearChange(int text) {
    emit(state.copyWith(year: text));
  }

  void resultChange() {
    if (state.amount.isNotEmpty) {
      if (double.parse(state.amount) > 0.0 &&
          state.rate > 0.0 &&
          state.year > 0) {
        double monthlyInterestRate = state.rate / 100.0 / 12.0;
        int numberOfPayments = (state.year * 12).toInt();
        double numerator = monthlyInterestRate *
            pow(1 + monthlyInterestRate, numberOfPayments);
        double denominator = pow(1 + monthlyInterestRate, numberOfPayments) - 1;
        double r = double.parse(state.amount) * (numerator / denominator);

        emit(state.copyWith(result: r));
      }
    } else {
      emit(state.copyWith(result: 0.0));
    }
  }

  void resetValue() {
    emit(state.copyWith(amount: '', rate: 0.0, year: 0, result: 0.0));
    amountCon.clear();
  }

  AgentProfileModel? agentDetailModel;
  UserProfileModel? users;

  // Future<void> getAgentDashboardInfo() async {
  //   if (_loginBloc.userInfo != null &&
  //       _loginBloc.userInfo!.accessToken.isNotEmpty) {
  //     emit(state.copyWith(profileState: ProfileLoading()));
  //     final result = await _profileRepository
  //         .getAgentDashboardInfo(_loginBloc.userInfo!.accessToken);
  //     result.fold(
  //         (failure) => emit(state.copyWith(
  //             profileState: ProfileError(failure.message, failure.statusCode))),
  //         (success) {
  //       agentDetailModel = success;
  //       emit(state.copyWith(profileState: ProfileLoaded(success)));
  //     });
  //   }
  // }

  Future<dynamic> updateAgentProfileInfo({
    required String name,
    required String number,
    required String address,
    required String description,
    required String email,
    required String about,
    required File image,
    required BuildContext context,
    required String Token,
  }) async {
    emit(state.copyWith(isLoading: true));
    var res = await _authRepository.updateProfile(
        name: name,
        number: number,
        address: address,
        description: description,
        email: email,
        about: about,
        image: image,
        token: Token);
    var data = jsonDecode(res.body);
    // log('res: ${data}', name: 'LoginCubit verify');
    if (data["status"]) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      UserModel user = UserModel.fromJson(data["user"]);
      await prefs.setString("token", Token);
      String? token = await prefs.getString("token");
      context.read<GeneralCubit>().setUser(user);

      // if(user.name == null){
      //   emit(state.copyWith(isLoading: false));
      //   Navigator.pushReplacementNamed(
      //       context, RouteNames.updateProfileScreen,arguments: user);
      // } else {
      //   emit(state.copyWith(isLoading: false));
      //   Navigator.pushReplacementNamed(
      //       context, RouteNames.mainPageScreen);
      // }
      // await prefs.setString("token", data["access_token"].toString());
      // String? token = await prefs.getString("token");
      // _authRepository.updateHeader(token);
      emit(state.copyWith(isLoading: false));

      return true;
    }
  }

  // Future<void> getAgentProfile() async {
  //   debugPrint('called-getAgentProfile');
  //   if (_loginBloc.userInfo != null &&
  //       _loginBloc.userInfo!.accessToken.isNotEmpty) {
  //     emit(state.copyWith(profileState: ProfileLoading()));
  //     final result = await _profileRepository
  //         .getAgentProfile(_loginBloc.userInfo!.accessToken);
  //     result.fold((failure) {
  //       final errors = ProfileError(failure.message, failure.statusCode);
  //       emit(state.copyWith(profileState: errors));
  //     }, (success) {
  //       users = success;
  //       final loaded = AgentProfileLoaded(success);
  //       emit(state.copyWith(profileState: loaded));
  //     });
  //   }
  // }

  // Future<void> deleteAccount() async {
  //   emit(state.copyWith(profileState: const AccountDeleting()));
  //   final result = await _profileRepository.deleteAccount(
  //       _loginBloc.userInfo!.accessToken, state);
  //   result.fold((failure) {
  //     if (failure is InvalidAuthData) {
  //       final error = ProfileUpdateFormValidate(failure.errors);
  //       emit(state.copyWith(profileState: error));
  //     } else {
  //       final error = AccountDeleteError(failure.message, failure.statusCode);
  //       emit(state.copyWith(profileState: error));
  //     }
  //   }, (delete) {
  //     emit(state.copyWith(profileState: AccountDeleted(delete)));
  //   });
  // }

  FutureOr<void> clear() {
    emit(state.copyWith(
        currentPassword: '', profileState: const ProfileInitial()));
  }
}
