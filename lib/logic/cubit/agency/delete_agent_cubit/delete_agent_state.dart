
import 'package:equatable/equatable.dart';

abstract class AgencyDeleteState extends Equatable {
  const AgencyDeleteState();

  @override
  List<Object> get props => [];
}

class AgencyDeleteInitial extends AgencyDeleteState {
  const AgencyDeleteInitial();
  @override
  List<Object> get props => [];
}


final class DeleteAgencyAgentLoading extends AgencyDeleteState {}

final class DeleteAgencyAgentError extends AgencyDeleteState {
  final String errorMessage;
  final int statusCode;

  const DeleteAgencyAgentError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

final class DeleteAgencyAgentSuccess extends AgencyDeleteState {
  final String message;

  const DeleteAgencyAgentSuccess(this.message);

  @override
  List<Object> get props => [message];
}

