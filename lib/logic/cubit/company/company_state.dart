
import 'package:equatable/equatable.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/data/model/kyc/company_kyc_model.dart';

import '../../../data/model/auth/auth_error_model.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

class CompanyInitial extends CompanyState {
  const CompanyInitial();
  @override
  List<Object> get props => [];
}


final class GetAgencyKycListLoading extends CompanyState {}

final class GetAgencyKycListError extends CompanyState {
  final String errorMessage;
  final int statusCode;

  const GetAgencyKycListError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

final class GetAgencyKycListLoaded extends CompanyState {
  final List<KycListModel> kycListModel;

  const GetAgencyKycListLoaded(this.kycListModel);

  @override
  List<Object> get props => [kycListModel];
}





final class CreateCompanyLoading extends CompanyState {
  const CreateCompanyLoading();
}

final class CreateCompanyFormError extends CompanyState {
  final Errors errors;

  const CreateCompanyFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

final class CreateCompanyError extends CompanyState {
  final String message;
  final int statusCode;

  const CreateCompanyError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class CreateCompanyLoaded extends CompanyState {
  final String message;

  const CreateCompanyLoaded(this.message);

  @override
  List<Object> get props => [message];
}


final class GetCompanyProfileLoading extends CompanyState {
  const GetCompanyProfileLoading();
}

final class GetCompanyProfileError extends CompanyState {
  final String message;
  final int statusCode;

  const GetCompanyProfileError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

final class GetCompanyProfileLoaded extends CompanyState {
  final Profile profile;

  const GetCompanyProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

