import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/ticket/ticket_model.dart';
import '../../../presentation/error/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/support_repository.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<TicketModel> {
  final LoginBloc _loginBloc;
  final SupportRepository _repository;

  SupportCubit({
    required LoginBloc loginBloc,
    required SupportRepository repository,
  })  : _loginBloc = loginBloc,
        _repository = repository,
        super(TicketModel.init());
  List<TicketModel> allTickets = [];
  List<TicketModel> showTickets = [];
  List<String> priorities = [];
  Timer? _timer;
  TextEditingController messageController = TextEditingController();

  void changeSubject(String text) {
    emit(state.copyWith(subject: text));
  }

  void changePriority(String text) {
    emit(state.copyWith(priority: text));
  }

  void changeCreateMsg(String text) {
    emit(state.copyWith(message: text));
  }

  void changeSendMsg(String text) {
    emit(state.copyWith(messageFrom: text));
  }
  void changeTicketId(String text) {
    emit(state.copyWith(ticketId: text));
  }

  void isOpen(bool val) {
    debugPrint('called-isOpened');
    emit(state.copyWith(isOpenSupport: val));
    if (val) {
      _startPeriodicRefresh();
    } else {
      _stopPeriodicRefresh();
    }
  }

  void _startPeriodicRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (state.isOpenSupport) {
        emit(state.copyWith(supState: const RefreshStateEveryFive()));
      } else {
        _timer?.cancel();
      }
    });
  }

  void _stopPeriodicRefresh() {
    _timer?.cancel();
  }

  Future<void> getAllTickets() async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(
          token: _loginBloc.userInfo!.accessToken,
          supState: const SupportTicketLoading()));
      final result = await _repository.getAllTickets(state.token);
      result.fold((failure) {
        final errors = SupportTicketError(failure.message, failure.statusCode);
        emit(state.copyWith(supState: errors));
      }, (success) {
        allTickets = success;
        final loaded = SupportTicketLoaded(success);
        emit(state.copyWith(supState: loaded));
      });
    }
  }

  Future<void> showTicket(String id) async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      // emit(state.copyWith(token: _loginBloc.userInfo!.accessToken));
      final result =
          await _repository.showTicket(_loginBloc.userInfo!.accessToken, id);
      result.fold((failure) {
        final errors =
            SupportShowTicketError(failure.message, failure.statusCode);
        emit(state.copyWith(supState: errors));
      }, (success) {
        showTickets = success;
        final loaded = SupportShowTickets(success);
        emit(state.copyWith(supState: loaded));
      });
    }
  }

  Future<void> getPriorityList() async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      final result =
          await _repository.getPriorityList(_loginBloc.userInfo!.accessToken);
      result.fold((failure) {
        final errors =
            SupportCreateInfoError(failure.message, failure.statusCode);
        emit(state.copyWith(supState: errors));
      }, (success) {
        priorities = success;
        debugPrint('priorities ${priorities.length}');
        final loaded = SupportCreateInfoLoaded(success);
        emit(state.copyWith(supState: loaded));
      });
    }
  }

  Future<void> createTicket() async {
    debugPrint('create-body ${state.toMap()}');
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      final body = state.copyWith(token: _loginBloc.userInfo!.accessToken);
      emit(state.copyWith(supState: const SupportCreating()));
      final result = await _repository.createTicket(body);
      result.fold((failure) {
        if (failure is InvalidAuthData) {
          final errors = SupportCreateFormError(failure.errors);
          emit(state.copyWith(supState: errors));
        } else {
          final errors =
              SupportCreateInfoError(failure.message, failure.statusCode);
          emit(state.copyWith(supState: errors));
        }
      }, (success) {
        final loaded = SupportCreated(success);
        emit(state.copyWith(supState: loaded));
      });
    }
  }

  Future<void> sendMessage() async {
    if (state.messageFrom.trim().isNotEmpty) {
      if (_loginBloc.userInfo != null &&
          _loginBloc.userInfo!.accessToken.isNotEmpty) {
        final body = state.copyWith(token: _loginBloc.userInfo!.accessToken);
        emit(state.copyWith(supState: const SupportCreating()));
        final result = await _repository.sendMessage(body);
        result.fold((failure) {
          if (failure is InvalidAuthData) {
            final errors = SupportCreateFormError(failure.errors);
            emit(state.copyWith(supState: errors));
          } else {
            final errors =
                SupportSendError(failure.message, failure.statusCode);
            emit(state.copyWith(supState: errors));
          }
        }, (success) {
          final loaded = SupportMessageSent(success);
          emit(state.copyWith(supState: loaded));
        });
      }
    }
  }

  FutureOr<void> clear() {
    emit(state.copyWith(message: '', subject: '', messageFrom: ''));
  }
}
