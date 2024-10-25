part of 'add_property_cubit.dart';

sealed class AddPropertyState extends Equatable {
  const AddPropertyState();

  @override
  List<Object> get props => [];
}

final class AddPropertyInitial extends AddPropertyState {
  const AddPropertyInitial();
}

final class AddPropertyLoading extends AddPropertyState {
  const AddPropertyLoading();
}

final class AddPropertyFormError extends AddPropertyState {
  final Errors errors;

  const AddPropertyFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

final class AddPropertyError extends AddPropertyState {
  final String message;
  final int statusCode;

  const AddPropertyError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class AddPropertyLoaded extends AddPropertyState {
  final String message;

  const AddPropertyLoaded(this.message);

  @override
  List<Object> get props => [message];
}

final class AddPropertyEditing extends AddPropertyState {
  const AddPropertyEditing();
}

final class AddPropertyEditingError extends AddPropertyState {
  final String message;
  final int statusCode;

  const AddPropertyEditingError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class AddPropertyEdited extends AddPropertyState {
  final EditInfoModel editInfo;

  const AddPropertyEdited(this.editInfo);

  @override
  List<Object> get props => [editInfo];
}
