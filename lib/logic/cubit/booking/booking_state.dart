part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {
  const BookingInitial();
}

final class BookingCreating extends BookingState {
  const BookingCreating();
}

final class BookingCreateError extends BookingState {
  final String message;
  final int statusCode;

  const BookingCreateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class BookingFormError extends BookingState {
  final Errors errors;

  const BookingFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

final class BookingCreated extends BookingState {
  final String message;

  const BookingCreated(this.message);

  @override
  List<Object> get props => [message];
}

//my booking
final class MyBookLoading extends BookingState {}

final class MyBookLoaded extends BookingState {
  final List<BookingModel> myBookings;

  const MyBookLoaded(this.myBookings);

  @override
  List<Object> get props => [myBookings];
}

final class MyBookMoreLoaded extends BookingState {
  final List<BookingModel> myBookings;

  const MyBookMoreLoaded(this.myBookings);

  @override
  List<Object> get props => [myBookings];
}

final class MyBookError extends BookingState {
  final String message;
  final int statusCode;

  const MyBookError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

//booking req
final class BookingReqLoading extends BookingState {}

final class BookingReqLoaded extends BookingState {
  final List<BookingModel> bookingList;

  const BookingReqLoaded(this.bookingList);

  @override
  List<Object> get props => [bookingList];
}

final class BookingReqMoreLoaded extends BookingState {
  final List<BookingModel> bookingList;

  const BookingReqMoreLoaded(this.bookingList);

  @override
  List<Object> get props => [bookingList];
}

final class BookingReqError extends BookingState {
  final String message;
  final int statusCode;

  const BookingReqError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

//compare states
final class CompareLoading extends BookingState {}


final class CompareLoaded extends BookingState {
  final List<DetailsPropertyItem> compareList;

  const CompareLoaded(this.compareList);

  @override
  List<Object> get props => [compareList];
}

final class CompareError extends BookingState {
  final String message;
  final int statusCode;

  const CompareError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}


//compare add /removed
final class CompareRemoving extends BookingState {}
final class CompareAddRemoveError extends BookingState {
  final String message;
  final int statusCode;

  const CompareAddRemoveError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
final class CompareAddRemoved extends BookingState {
  final String message;


  const CompareAddRemoved(this.message);

  @override
  List<Object> get props => [message];
}