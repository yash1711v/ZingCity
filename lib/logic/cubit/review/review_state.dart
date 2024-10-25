part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<ReviewModel> reviews;

  const ReviewLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String message;
  final int statusCode;

  const ReviewError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ReviewStoreLoaded extends ReviewState {
  final String message;

  const ReviewStoreLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class ReviewFieldError extends ReviewState {
  final Errors errors;

  const ReviewFieldError(this.errors);

  @override
  List<Object> get props => [errors];
}
