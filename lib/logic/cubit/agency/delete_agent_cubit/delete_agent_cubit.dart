import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/cubit/agency/delete_agent_cubit/delete_agent_state.dart';
import 'package:real_estate/logic/repository/agency_repository.dart';


class AgencyDeleteCubit extends Cubit<AgencyDeleteState> {
  final AgencyRepository _agencyRepository;
  final LoginBloc _loginBloc;

  AgencyDeleteCubit(
      {required AgencyRepository agencyRepository,
        required LoginBloc loginBloc})
      : _agencyRepository = agencyRepository,
        _loginBloc = loginBloc,
        super(const AgencyDeleteInitial());


  Future<void> deleteAgencyAgent(String id) async {
    emit( DeleteAgencyAgentLoading());
    final result = await _agencyRepository.deleteAgencyAgent(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
          (failure) {
        emit(
            DeleteAgencyAgentError(failure.message, failure.statusCode));
      },
          (delete) {
        emit(DeleteAgencyAgentSuccess(delete));
      },
    );
  }

}
