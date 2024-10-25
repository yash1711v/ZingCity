part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => [];
}

final class SupportInitial extends SupportState {
  const SupportInitial();
}

final class SupportTicketLoading extends SupportState {
  const SupportTicketLoading();
}

final class SupportTicketLoaded extends SupportState {
  final List<TicketModel> tickets;

  const SupportTicketLoaded(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class SupportTicketError extends SupportState {
  final String message;
  final int statusCode;

  const SupportTicketError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class SupportCreateInfoLoaded extends SupportState {
  final List<String> priority;
  const SupportCreateInfoLoaded(this.priority);

  @override
  List<Object> get props => [priority];
}

final class SupportCreateInfoError extends SupportState {
  final String message;
  final int statusCode;

  const SupportCreateInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class SupportCreating extends SupportState {
  const SupportCreating();
}

final class SupportCreated extends SupportState {
  final String tickets;

  const SupportCreated(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class SupportCreateFormError extends SupportState {
  final Errors errors;

  const SupportCreateFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

final class SupportCreatingError extends SupportState {
  final String message;
  final int statusCode;

  const SupportCreatingError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class SupportMessageSent extends SupportState {
  final String tickets;

  const SupportMessageSent(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class SupportSendError extends SupportState {
  final String message;
  final int statusCode;

  const SupportSendError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class SupportShowTickets extends SupportState {
  final List<TicketModel> tickets;

  const SupportShowTickets(this.tickets);

  @override
  List<Object> get props => [tickets];
}

final class SupportShowTicketError extends SupportState {
  final String message;
  final int statusCode;

  const SupportShowTicketError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class RefreshStateEveryFive extends SupportState {
  const RefreshStateEveryFive();
}

