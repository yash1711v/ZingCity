import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/auth/auth_error_model.dart';
import '../../../data/model/review/review_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/review_repository.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final LoginBloc _loginBloc;
  final ReviewRepository _reviewRepository;

  ReviewCubit({
    required LoginBloc loginBloc,
    required ReviewRepository reviewRepository,
  })  : _loginBloc = loginBloc,
        _reviewRepository = reviewRepository,
        super(ReviewInitial());

  List<ReviewModel> reviews = [];
  TextEditingController messageController = TextEditingController();

  Future<void> getReviewList() async {
    emit(ReviewLoading());
    final result =
        await _reviewRepository.getReviewList(_loginBloc.userInfo!.accessToken);
    result.fold((failure) {
      emit(ReviewError(failure.message, failure.statusCode));
    }, (success) {
      reviews = success;
      emit(ReviewLoaded(success));
    });
  }

// Future<void> storeReview(Map<String, String> body) async {
//   emit(ReviewLoading());
//   print('review body $body');
//   final result = await _reviewRepository.storeReview(
//       _loginBloc.userInfo!.accessToken, body);
//   result.fold((failure) {
//     if (failure is InvalidAuthData) {
//       emit(ReviewFieldError(failure.errors));
//     } else {
//       emit(ReviewError(failure.message, failure.statusCode));
//     }
//   }, (success) {
//     emit(ReviewStoreLoaded(success));
//   });
// }
}
