import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/repository/agency_repository.dart';
import '../../../data/model/auth/auth_error_model.dart';
import '../../../presentation/router/route_packages_name.dart';
import '../../../presentation/error/failure.dart';
import 'agency_state_model.dart';

part 'agency_state.dart';

class AgencyCubit extends Cubit<AgencyStateModel> {
  final AgencyRepository _agencyRepository;
  final LoginBloc _loginBloc;

  AgencyCubit(
      {required AgencyRepository agencyRepository,
      required LoginBloc loginBloc})
      : _agencyRepository = agencyRepository,
        _loginBloc = loginBloc,
        super(const AgencyStateModel());

  void nameChange(String text) {
    emit(state.copyWith(name: text, agencyState: const AgencyInitial()));
  }

  void emailChange(String text) {
    emit(state.copyWith(email: text, agencyState: const AgencyInitial()));
  }

  void phoneChange(String text) {
    emit(state.copyWith(phone: text, agencyState: const AgencyInitial()));
  }

  void designationChange(String text) {
    emit(state.copyWith(designation: text, agencyState: const AgencyInitial()));
  }

  void addressChange(String text) {
    emit(state.copyWith(address: text, agencyState: const AgencyInitial()));
  }

  void aboutMeChange(String text) {
    emit(state.copyWith(aboutMe: text, agencyState: const AgencyInitial()));
  }

  void passwordChange(String text) {
    emit(state.copyWith(password: text, agencyState: const AgencyInitial()));
  }

  void cPasswordChange(String text) {
    emit(state.copyWith(
        passwordConfirmation: text, agencyState: const AgencyInitial()));
  }

  void instagramChange(String text) {
    emit(state.copyWith(instagram: text, agencyState: const AgencyInitial()));
  }

  void twitterChange(String text) {
    emit(state.copyWith(twitter: text, agencyState: const AgencyInitial()));
  }

  void linkedinChange(String text) {
    emit(state.copyWith(linkedin: text, agencyState: const AgencyInitial()));
  }

  void imageChange(String logo) {
    emit(state.copyWith(image: logo, agencyState: const AgencyInitial()));
  }

  void agentEmailChange(String text) {
    emit(state.copyWith(agentEmail: text, agencyState: const AgencyInitial()));
  }

  void subjectChange(String text) {
    emit(state.copyWith(subject: text, agencyState: const AgencyInitial()));
  }

  void messageChange(String text) {
    emit(state.copyWith(message: text, agencyState: const AgencyInitial()));
  }

  void statusChange(String text) {
    emit(state.copyWith(status: text, agencyState: const AgencyInitial()));
  }

  List<AgencyListModel>? agency = [];

  List<AgencyListModel>? agencyAgent = [];

  AgencyListModel? editAgencyAgent;

  AgencyDetailsModel? agencyDetailsModel;

  Future<void> getAllAgency() async {
    emit(state.copyWith(agencyState: AgencyLoading()));
    final result = await _agencyRepository.getAllAgency();
    result.fold((failure) {
      emit(state.copyWith(
          agencyState: AgencyError(failure.message, failure.statusCode)));
    }, (success) {
      agency = success;
      emit(state.copyWith(agencyState: AgencyLoaded(success)));
    });
  }

  Future<void> getAgencyDetails(String id) async {
    emit(state.copyWith(agencyState: AgencyDetailsLoading()));
    // final Map<String, String> param = {
    //   'agent_type': 'agent',
    //   'user_name': userName
    // };
    final result = await _agencyRepository.getAgencyDetails(
        id, _loginBloc.userInfo!.accessToken);
    result.fold((failure) {
      emit(state.copyWith(
          agencyState:
              AgencyDetailsError(failure.message, failure.statusCode)));
    }, (success) {
      agencyDetailsModel = success;
      emit(state.copyWith(agencyState: AgencyDetailsLoaded(success)));
    });
  }

  Future<void> getAgencyAgentList() async {
    emit(state.copyWith(agencyState: AgencyAgentListLoading()));
    final result = await _agencyRepository
        .getAgencyAgentList(_loginBloc.userInfo!.accessToken);
    result.fold((failure) {
      emit(state.copyWith(
          agencyState:
              AgencyAgentListError(failure.message, failure.statusCode)));
    }, (success) {
      agencyAgent = success;
      emit(state.copyWith(agencyState: AgencyAgentListLoaded(success)));
    });
  }

  Future<void> createAgencyAgent() async {
    debugPrint('crate agent-body ${state.toMap()}');
    emit(state.copyWith(agencyState: const CreateAgencyAgentLoading()));
    final result = await _agencyRepository.createAgencyAgent(
        state, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errorState = CreateAgencyAgentFormError(failure.errors);
          emit(state.copyWith(agencyState: errorState));
        } else {
          final errors =
              CreateAgencyAgentError(failure.message, failure.statusCode);
          emit(state.copyWith(agencyState: errors));
        }
      },
      (success) {
        emit(state.copyWith(agencyState: CreateAgencyAgentLoaded(success)));
      },
    );
  }

  Future<void> getEditAgencyAgent(String id) async {
    emit(state.copyWith(agencyState: const AgencyAgentEditing()));
    final result = await _agencyRepository.getEditAgencyAgent(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final errors =
            AgencyAgentEditingError(failure.message, failure.statusCode);
        emit(state.copyWith(agencyState: errors));
      },
      (data) {
        editAgencyAgent = data;
        if (editAgencyAgent != null) {
          emit(state.copyWith(name: data.name));
          emit(state.copyWith(email: data.email));
          emit(state.copyWith(phone: data.phone));
          emit(state.copyWith(designation: data.designation));
          emit(state.copyWith(address: data.address));
          emit(state.copyWith(aboutMe: data.aboutMe));
          emit(state.copyWith(instagram: data.instagram));
          emit(state.copyWith(twitter: data.twitter));
          emit(state.copyWith(linkedin: data.linkedin));
          // emit(state.copyWith(password: data.pas));
          // emit(state.copyWith(passwordConfirmation: data.pas));
         // emit(state.copyWith(image: data.image));
          emit(state.copyWith(tempImage: data.image));
          emit(state.copyWith(status: data.status.toString()));
        }
        emit(state.copyWith(agencyState: AgencyAgentEdited(data)));
      },
    );
  }


  Future<void> updateAgencyAgent(String id) async {
    debugPrint('add-Agency-Agent-body ${state.toMap()}');

    emit(state.copyWith(agencyState: const CreateAgencyAgentLoading()));
    final result = await _agencyRepository.updateAgencyAgent(
        id, state, _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        if (failure is InvalidAuthData) {
          final errorState = CreateAgencyAgentFormError(failure.errors);
          emit(state.copyWith(agencyState: errorState));
        } else {
          final errors = CreateAgencyAgentError(failure.message, failure.statusCode);
          emit(state.copyWith(agencyState: errors));
        }
      },
          (success) {
        emit(state.copyWith(agencyState: CreateAgencyAgentLoaded(success)));
      },
    );
  }



  void resetData() {
    emit(const AgencyStateModel().clear());
  }

// Future<void> sendMessageToAgent() async {
//   emit(state.copyWith(agentState: AgentSendMessageLoading()));
//   print('messages: $state');
//   final result = await _agentRepository.sendMessageToAgent(state);
//   result.fold((failure) {
//     if (failure is InvalidAuthData) {
//       final errors = AgentSendMessageFormValidate(failure.errors);
//       emit(state.copyWith(agentState: errors));
//     } else {
//       emit(state.copyWith(
//           agentState:
//               AgentSendMessageError(failure.message, failure.statusCode)));
//     }
//   }, (message) {
//     emit(state.copyWith(agentState: AgentSendMessageLoad(message)));
//     emit(state.clear());
//   });
// }
}
