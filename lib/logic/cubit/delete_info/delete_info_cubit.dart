import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../repository/property_repository.dart';

part 'delete_info_state.dart';

class DeleteInfoCubit extends Cubit<DeleteInfoState> {
  final PropertyRepository _repository;
  final LoginBloc _loginBloc;

  DeleteInfoCubit({
    required PropertyRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(DeleteInfoInitial());

  Future<void> deleteSliderImage(String id) async {
    emit(DeleteInfoLoading());
    final result = await _repository.deleteSliderImage(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final error = DeleteInfoError(failure.message, failure.statusCode);
        emit(error);
      },
      (delete) {
        final error = DeleteInfoSuccess(delete);
        emit(error);
      },
    );
  }

  Future<void> deleteSingleNearestLocation(String id) async {
    emit(DeleteInfoLoading());
    final result = await _repository.deleteSingleNearestLocation(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final error = DeleteInfoError(failure.message, failure.statusCode);
        emit(error);
      },
      (delete) {
        final error = DeleteInfoSuccess(delete);
        emit(error);
      },
    );
  }

  Future<void> deleteSinglePlan(String id) async {
    emit(DeleteInfoLoading());
    final result = await _repository.deleteSinglePlan(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final error = DeleteInfoError(failure.message, failure.statusCode);
        emit(error);
      },
      (delete) {
        final error = DeleteInfoSuccess(delete);
        emit(error);
      },
    );
  }

  Future<void> deleteSingleAddInfo(String id) async {
    emit(DeleteInfoLoading());
    final result = await _repository.deleteSingleAddInfo(
        id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final error = DeleteInfoError(failure.message, failure.statusCode);
        emit(error);
      },
      (delete) {
        final error = DeleteInfoSuccess(delete);
        emit(error);
      },
    );
  }

  Future<void> deleteProperty(String id) async {
    emit(DeletePropertyLoading());
    final result =
        await _repository.deleteProperty(id, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final error =
            DeleteInfoPropertyError(failure.message, failure.statusCode);
        emit(error);
      },
      (delete) {
        final error = PropertyDeleteSuccess(delete);
        emit(error);
      },
    );
  }
}
