part of 'delete_info_cubit.dart';

sealed class DeleteInfoState extends Equatable {
  const DeleteInfoState();

  @override
  List<Object> get props => [];
}

final class DeleteInfoInitial extends DeleteInfoState {}

final class DeleteInfoLoading extends DeleteInfoState {}

final class DeletePropertyLoading extends DeleteInfoState {}

final class DeleteInfoError extends DeleteInfoState {
  final String errorMessage;
  final int statusCode;

  const DeleteInfoError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

final class DeleteInfoPropertyError extends DeleteInfoState {
  final String errorMessage;
  final int statusCode;

  const DeleteInfoPropertyError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

final class DeleteInfoSuccess extends DeleteInfoState {
  final String message;

  const DeleteInfoSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class PropertyDeleteSuccess extends DeleteInfoState {
  final String message;

  const PropertyDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}
