import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/booking/booking_model.dart';
import '../../../data/model/product/details_property_item.dart';
import '../../../presentation/error/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/booking_repository.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingModel> {
  final LoginBloc _loginBloc;
  final BookingRepository _repository;

  BookingCubit({
    required LoginBloc loginBloc,
    required BookingRepository repository,
  })  : _loginBloc = loginBloc,
        _repository = repository,
        super(BookingModel.init());

  List<BookingModel> myBookings = [];
  List<BookingModel> bookingList = [];
  List<DetailsPropertyItem> compareList = [];

  void changePropertyId(String text) {
    emit(state.copyWith(state: text, bookState: const BookingInitial()));
  }

  void changeDate(String text) {
    emit(state.copyWith(bookingDate: text, bookState: const BookingInitial()));
  }

  void changeTime(String text) {
    emit(state.copyWith(bookingTime: text, bookState: const BookingInitial()));
  }

  void changeGuest(String text) =>
      emit(state.copyWith(tempGuests: text, bookState: const BookingInitial()));

  void changeName(String text) {
    emit(state.copyWith(name: text, bookState: const BookingInitial()));
  }

  void changeCity(String text) {
    emit(state.copyWith(city: text, bookState: const BookingInitial()));
  }

  void changeZipcode(String text) {
    emit(state.copyWith(zipCode: text, bookState: const BookingInitial()));
  }

  void changePhone(String text) {
    emit(state.copyWith(phone: text, bookState: const BookingInitial()));
  }

  void changeComment(String text) {
    emit(state.copyWith(comment: text, bookState: const BookingInitial()));
  }
  void loading(bool val) {
    debugPrint('new-loading-value $val');
    emit(state.copyWith(isLoading: val));
  }

  void addSingComId(int text) {
    if (!state.tempComId.contains(text)) {
      //debugPrint('add-newComId $text');
      final updatedComId = List.of(state.tempComId)..add(text);
      emit(state.copyWith(tempComId: updatedComId));
    } else {
      //debugPrint('removed-oldComId $text');
      final updatedComId = List.of(state.tempComId)..remove(text);
      emit(state.copyWith(tempComId: updatedComId));
    }
  }

  Future<void> createBooking() async {
    //debugPrint('add-booking-body ${state.toMap()}');
    emit(state.copyWith(bookState: const BookingCreating()));
    final result = await _repository.createBooking(
        _loginBloc.userInfo!.accessToken, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errorState = BookingFormError(failure.errors);
        emit(state.copyWith(bookState: errorState));
      } else {
        final errors = BookingCreateError(failure.message, failure.statusCode);
        emit(state.copyWith(bookState: errors));
      }
    }, (success) {
      emit(state.copyWith(bookState: BookingCreated(success)));
    });
  }

  Future<void> getBookings() async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(bookState: MyBookLoading()));
      final result = await _repository.getBookings(
          _loginBloc.userInfo!.accessToken, state.initialPage.toString());
      result.fold((failure) {
        final errors = MyBookError(failure.message, failure.statusCode);
        emit(state.copyWith(bookState: errors));
      }, (success) {
        if (state.initialPage == 1) {
          myBookings = success;
          final loaded = MyBookLoaded(myBookings);
          emit(state.copyWith(bookState: loaded));
        } else {
          myBookings.addAll(success);
          final loaded = MyBookMoreLoaded(myBookings);
          emit(state.copyWith(bookState: loaded));
        }
        state.initialPage++;
        if (success.isEmpty && state.initialPage != 1) {
          emit(state.copyWith(isListEmpty: true));
        }
      });
    }
  }

  Future<void> bookingReq() async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(bookState: BookingReqLoading()));
      // final uri = Utils.tokenWithQuery(
      //   RemoteUrls.getPurchaseHistory,
      //   _loginBloc.userInformation!.accessToken,
      //   _loginBloc.state.languageCode,
      //   extraParams: {'page': state.initialPage.toString()},
      // );
      final result = await _repository.bookingReq(
          _loginBloc.userInfo!.accessToken, state.initialPage2.toString());
      result.fold((failure) {
        final errors = BookingReqError(failure.message, failure.statusCode);
        emit(state.copyWith(bookState: errors));
      }, (success) {
        if (state.initialPage2 == 1) {
          bookingList = success;
          final loaded = BookingReqLoaded(bookingList);
          emit(state.copyWith(bookState: loaded));
        } else {
          bookingList.addAll(success);
          final loaded = BookingReqMoreLoaded(bookingList);
          emit(state.copyWith(bookState: loaded));
        }
        state.initialPage2++;
        if (success.isEmpty && state.initialPage2 != 1) {
          emit(state.copyWith(isListEmpty2: true));
        }
      });
    }
  }

// Future<void> bookingReqDetails(String token, String id) async {}
//
// Future<void> bookingStatusUpdate(String token, String id, BookingModel body) async {}

  Future<void> getCompareList() async {
    //debugPrint('called-getCompareList');
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(bookState: CompareLoading()));
      final result =
          await _repository.getCompareList(_loginBloc.userInfo!.accessToken);
      result.fold((failure) {
        final errors = CompareError(failure.message, failure.statusCode);
        emit(state.copyWith(bookState: errors));
      }, (success) {
        compareList = success;
        final loaded = CompareLoaded(success);
        //debugPrint('getCompareList ${compareList.length}');
        emit(state.copyWith(bookState: loaded));
        addComId();
      });
    }
  }

  Future<void> compareAddOrRemove(String id, [bool isAdd = true]) async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(state.copyWith(bookState: CompareRemoving()));
      Either<Failure, String> result;
      if (isAdd) {
        result = await _repository.addToCompare(
            _loginBloc.userInfo!.accessToken, id);
      } else {
        result = await _repository.removeCompare(
            _loginBloc.userInfo!.accessToken, id);
      }
      result.fold((failure) {
        if (!isAdd) {
          compareList.removeWhere((e) => e.id.toString() == id);
          final errors = CompareError(failure.message, failure.statusCode);
          emit(state.copyWith(bookState: errors));
          return false;
        } else {
          final errors = CompareError(failure.message, failure.statusCode);
          emit(state.copyWith(bookState: errors));
        }
      }, (success) {
        final loaded = CompareAddRemoved(success);
        emit(state.copyWith(bookState: loaded));
      });
    }
  }

  void addComId() {
    // compareList.clear();
    if (state.tempComId.isNotEmpty) {
      emit(state.copyWith(tempComId: <int>[]));
    }
    if (compareList.isNotEmpty) {
      for (var comId in compareList) {
        //debugPrint('compare-id-added ${comId.id}');
        final updatedComId = List.of(state.tempComId)..add(comId.id);
        emit(state.copyWith(tempComId: updatedComId));
      }
    }
  }

  FutureOr<void> clear() {
    emit(state.copyWith(
      bookingDate: '',
      bookingTime: '',
      tempGuests: '',
      name: '',
      city: '',
      zipCode: '',
      phone: '',
      comment: '',
    ));
  }

  void initPage([bool isMyBook = true]) {
    if (isMyBook) {
      emit(state.copyWith(initialPage: 1, isListEmpty: false));
    } else {
      emit(state.copyWith(initialPage2: 1, isListEmpty2: false));
    }
  }

  void clearComId() => emit(state.copyWith(tempComId: <int>[]));
}
