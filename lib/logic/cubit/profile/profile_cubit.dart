import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/agent/agent_profile_model.dart';
import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/auth/user_profile_model.dart';
import '../../../presentation/error/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/profile_repository.dart';
import 'profile_state_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStateModel> {
  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;
  TextEditingController amountCon = TextEditingController();

  ProfileCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(ProfileStateModel());

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

  void facebookChange(String text) {
    emit(state.copyWith(facebook: text, profileState: const ProfileInitial()));
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

  void imageChange(String text) {
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

  Future<void> getAgentDashboardInfo() async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(profileState: ProfileLoading()));
      final result = await _profileRepository
          .getAgentDashboardInfo(_loginBloc.userInfo!.accessToken);
      result.fold(
          (failure) => emit(state.copyWith(
              profileState: ProfileError(failure.message, failure.statusCode))),
          (success) {
        agentDetailModel = success;
        emit(state.copyWith(profileState: ProfileLoaded(success)));
      });
    }
  }

  Future<void> updateAgentProfileInfo() async {
    emit(state.copyWith(profileState: ProfileUpdateLoading()));
    print('stateBody: $state');
    final result = await _profileRepository.updateAgentProfileInfo(
        _loginBloc.userInfo!.accessToken, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ProfileUpdateFormValidate(failure.errors);
        emit(state.copyWith(profileState: errors));
      } else {
        final errors = ProfileUpdateError(failure.message, failure.statusCode);
        emit(state.copyWith(profileState: errors));
      }
    }, (success) {
      emit(state.copyWith(profileState: ProfileUpdateLoaded(success)));
      //  emit(state.clear());
    });
  }

  Future<void> getAgentProfile() async {
    debugPrint('called-getAgentProfile');
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(profileState: ProfileLoading()));
      final result = await _profileRepository
          .getAgentProfile(_loginBloc.userInfo!.accessToken);
      result.fold((failure) {
        final errors = ProfileError(failure.message, failure.statusCode);
        emit(state.copyWith(profileState: errors));
      }, (success) {
        users = success;
        final loaded = AgentProfileLoaded(success);
        emit(state.copyWith(profileState: loaded));
      });
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(profileState: const AccountDeleting()));
    final result = await _profileRepository.deleteAccount(
        _loginBloc.userInfo!.accessToken, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final error = ProfileUpdateFormValidate(failure.errors);
        emit(state.copyWith(profileState: error));
      } else {
        final error = AccountDeleteError(failure.message, failure.statusCode);
        emit(state.copyWith(profileState: error));
      }
    }, (delete) {
      emit(state.copyWith(profileState: AccountDeleted(delete)));
    });
  }

  FutureOr<void> clear() {
    emit(state.copyWith(
        currentPassword: '', profileState: const ProfileInitial()));
  }
}
