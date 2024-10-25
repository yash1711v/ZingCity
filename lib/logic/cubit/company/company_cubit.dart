import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/data/model/kyc/company_kyc_model.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/cubit/company/company_state.dart';
import 'package:real_estate/logic/cubit/company/company_state_model.dart';
import 'package:real_estate/logic/repository/company_repository.dart';
import '../../../presentation/error/failure.dart';
import '../../../presentation/router/route_packages_name.dart';


class CompanyCubit extends Cubit<CompanyStateModel> {
  final CompanyRepository _companyRepository;
  final LoginBloc _loginBloc;

  CompanyCubit(
      {required CompanyRepository companyRepository,
        required LoginBloc loginBloc})
      : _companyRepository = companyRepository,
        _loginBloc = loginBloc,
        super(const CompanyStateModel());


  List<KycListModel>  kycListModel = [];

  Profile? profile;


  void nameChange(String text) {
    emit(state.copyWith(name: text, companyState: const CompanyInitial()));
  }

  void emailChange(String text) {
    emit(state.copyWith(email: text, companyState: const CompanyInitial()));
  }

  void phoneChange(String text) {
    emit(state.copyWith(phone: text, companyState: const CompanyInitial()));
  }

  void tagLineChange(String text) {
    emit(state.copyWith(tagLine: text, companyState: const CompanyInitial()));
  }

  void imageChange(String text) {
    emit(state.copyWith(image: text, companyState: const CompanyInitial()));
  }

  void fileChange(String text) {
    emit(state.copyWith(file: text, companyState: const CompanyInitial()));
  }

  void kycIdChange(String text) {
    emit(state.copyWith(kycId: text, companyState: const CompanyInitial()));
  }

  void addressChange(String text) {
    emit(state.copyWith(address: text, companyState: const CompanyInitial()));
  }

  void aboutUsChange(String text) {
    emit(state.copyWith(aboutMe: text, companyState: const CompanyInitial()));
  }
  void messageChange(String text) {
    emit(state.copyWith(message: text, companyState: const CompanyInitial()));
  }

  void instagramChange(String text) {
    emit(state.copyWith(instagram: text, companyState: const CompanyInitial()));
  }

  void twitterChange(String text) {
    emit(state.copyWith(twitter: text, companyState: const CompanyInitial()));
  }

  void linkedinChange(String text) {
    emit(state.copyWith(linkedin: text, companyState: const CompanyInitial()));
  }



  Future<void> getAgencyKyc() async {
    emit(state.copyWith(companyState: GetAgencyKycListLoading()));
    final result = await _companyRepository.getAgencyKyc();
    result.fold((failure) {
      emit(state.copyWith(
          companyState: GetAgencyKycListError(failure.message, failure.statusCode)));
    }, (success) {
      kycListModel = success;
      emit(state.copyWith(companyState: GetAgencyKycListLoaded(success)));
    });
  }


  Future<void> createCompany() async {
    debugPrint('crate Company-body ${state.toMap()}');
    emit(state.copyWith(companyState: const CreateCompanyLoading()));
    final result = await _companyRepository.createCompany(
        state, _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = CreateCompanyFormError(failure.errors);
          emit(state.copyWith(companyState: errorState));
        } else {
          final errors =
          CreateCompanyError(failure.message, failure.statusCode);
          emit(state.copyWith(companyState: errors));
        }
      },
          (success) {
        emit(state.copyWith(companyState: CreateCompanyLoaded(success)));
      },
    );
  }


  Future<void> updateCompanyProfile(String id) async {
    debugPrint('add-Company-body ${state.toMap()}');

    emit(state.copyWith(companyState: const CreateCompanyLoading()));
    final result = await _companyRepository.updateCompanyProfile(
        id, state, _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = CreateCompanyFormError(failure.errors);
          emit(state.copyWith(companyState: errorState));
        } else {
          final errors = CreateCompanyError(failure.message, failure.statusCode);
          emit(state.copyWith(companyState: errors));
        }
      },
          (success) {
        emit(state.copyWith(companyState: CreateCompanyLoaded(success)));
      },
    );
  }

  Future<void> getCompanyProfile() async {
    print("call get company");
    emit(state.copyWith(companyState: const GetCompanyProfileLoading()));
    final result = await _companyRepository.getCompanyProfile(
 _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        final errors =
        GetCompanyProfileError(failure.message, failure.statusCode);
        emit(state.copyWith(companyState: errors));
      },
          (data) {
            profile = data;
        if (profile != null) {
          emit(state.copyWith(name: data.companyName));
          emit(state.copyWith(email: data.email));
          emit(state.copyWith(phone: data.phone));
          emit(state.copyWith(tagLine: data.tagLine));
          emit(state.copyWith(address: data.address));
          emit(state.copyWith(aboutMe: data.aboutUs));
          emit(state.copyWith(instagram: data.instagram));
          emit(state.copyWith(twitter: data.twitter));
          emit(state.copyWith(linkedin: data.linkedin));
          // emit(state.copyWith(password: data.pas));
          // emit(state.copyWith(passwordConfirmation: data.pas));
          emit(state.copyWith(tempImage: data.image));
          emit(state.copyWith(kycId: data.kycId.toString()));
          emit(state.copyWith(tempFile: data.file));
          emit(state.copyWith(message: data.message));
        }
        emit(state.copyWith(companyState: GetCompanyProfileLoaded(data)));
      },
    );
  }

  void resetData() {
    emit(const CompanyStateModel().clear());
  }
}
