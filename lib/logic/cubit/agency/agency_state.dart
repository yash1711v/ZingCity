part of 'agency_cubit.dart';

abstract class AgencyState extends Equatable {
  const AgencyState();

  @override
  List<Object> get props => [];
}

class AgencyInitial extends AgencyState {
  const AgencyInitial();
  @override
  List<Object> get props => [];
}

class AgencyLoading extends AgencyState {}

class AgencyLoaded extends AgencyState {
  final List<AgencyListModel> agency;

  const AgencyLoaded(this.agency);

  @override
  List<Object> get props => [agency];
}

class AgencyError extends AgencyState {
  final String message;
  final int statusCode;

  const AgencyError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class AgencyDetailsLoading extends AgencyState {}

class AgencyDetailsError extends AgencyState {
  final String message;
  final int statusCode;

  const AgencyDetailsError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class AgencyDetailsLoaded extends AgencyState {
  final AgencyDetailsModel agencyDetailsModel;

  const AgencyDetailsLoaded(this.agencyDetailsModel);

  @override
  List<Object> get props => [agencyDetailsModel];
}


class AgencyAgentListLoading extends AgencyState {}

class AgencyAgentListLoaded extends AgencyState {
  final List<AgencyListModel> agencyAgent;

  const AgencyAgentListLoaded(this.agencyAgent);

  @override
  List<Object> get props => [agencyAgent];
}

class AgencyAgentListError extends AgencyState {
  final String message;
  final int statusCode;

  const AgencyAgentListError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}



final class CreateAgencyAgentLoading extends AgencyState {
  const CreateAgencyAgentLoading();
}

final class CreateAgencyAgentFormError extends AgencyState {
  final Errors errors;

  const CreateAgencyAgentFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

final class CreateAgencyAgentError extends AgencyState {
  final String message;
  final int statusCode;

  const CreateAgencyAgentError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class CreateAgencyAgentLoaded extends AgencyState {
  final String message;

  const CreateAgencyAgentLoaded(this.message);

  @override
  List<Object> get props => [message];
}


final class AgencyAgentEditing extends AgencyState {
  const AgencyAgentEditing();
}

final class AgencyAgentEditingError extends AgencyState {
  final String message;
  final int statusCode;

  const AgencyAgentEditingError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class AgencyAgentEdited extends AgencyState {
  final AgencyListModel editAgencyAgent;

  const AgencyAgentEdited(this.editAgencyAgent);

  @override
  List<Object> get props => [editAgencyAgent];
}




//
// class AgentSendMessageLoading extends AgencyState {}
//
// class AgentSendMessageError extends AgencyState {
//   final String message;
//   final int statusCode;
//
//   const AgentSendMessageError(this.message, this.statusCode);
//
//   @override
//   List<Object> get props => [message, statusCode];
// }
//
// class AgentSendMessageFormValidate extends AgencyState {
//   final Errors errors;
//
//   const AgentSendMessageFormValidate(this.errors);
//
//   @override
//   List<Object> get props => [errors];
// }
//
// class AgentSendMessageLoad extends AgencyState {
//   final String message;
//
//   const AgentSendMessageLoad(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
