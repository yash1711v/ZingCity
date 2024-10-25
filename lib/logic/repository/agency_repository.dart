import 'package:dartz/dartz.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';

import '../cubit/agency/agency_state_model.dart';
import '/presentation/error/failure.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/agent/agent_details_model.dart';
import '../../data/model/agent/agent_list_model.dart';
import '../../presentation/error/exception.dart';
import '../cubit/agent/agent_state_model.dart';

abstract class AgencyRepository {
  Future<Either<Failure, List<AgencyListModel>>> getAllAgency();

  Future<Either<Failure, AgencyDetailsModel>> getAgencyDetails(
      String id, String token);

  Future<Either<Failure, List<AgencyListModel>>> getAgencyAgentList(
      String token);

  Future<Either<dynamic, String>> createAgencyAgent(
    AgencyStateModel body,
    String token,
  );

  Future<Either<Failure, AgencyListModel>> getEditAgencyAgent(
      String id, String token);

  Future<Either<dynamic, String>> updateAgencyAgent(
      String id, AgencyStateModel data, String token);

  Future<Either<Failure, String>> deleteAgencyAgent(String id, String token);
//
// Future<Either<Failure, String>> sendMessageToAgent(AgentStateModel messages);
}

class AgencyRepositoryImpl implements AgencyRepository {
  final RemoteDataSource remoteDataSource;

  AgencyRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<AgencyListModel>>> getAllAgency() async {
    try {
      final result = await remoteDataSource.getAllAgency();
      final agency = result['data']['data'] as List;
      final data = List<AgencyListModel>.from(
          agency.map((e) => AgencyListModel.fromMap(e))).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AgencyDetailsModel>> getAgencyDetails(
      String id, String token) async {
    try {
      final result = await remoteDataSource.getAgencyDetails(id, token);
      final data = AgencyDetailsModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<AgencyListModel>>> getAgencyAgentList(
      String token) async {
    try {
      final result = await remoteDataSource.getAgencyAgentList(token);
      final agency = result['agents']['data'] as List;
      final data = List<AgencyListModel>.from(
          agency.map((e) => AgencyListModel.fromMap(e))).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> createAgencyAgent(
      AgencyStateModel body, String token) async {
    try {
      final result = await remoteDataSource.createAgencyAgent(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, AgencyListModel>> getEditAgencyAgent(
      String id, String token) async {
    try {
      final result = await remoteDataSource.getEditAgencyAgent(id, token);
      final data = AgencyListModel.fromMap(result['agency_agent']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAgencyAgent(
      String id, String token) async {
    try {
      final result = await remoteDataSource.deleteAgencyAgent(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> updateAgencyAgent(
      String id, AgencyStateModel data, String token) async {
    try {
      final result = await remoteDataSource.updateAgencyAgent(id, data, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

// @override
// Future<Either<Failure, String>> sendMessageToAgent(
//     AgentStateModel messages) async {
//   try {
//     final result = await remoteDataSource.sendMessageToAgent(messages);
//     return Right(result);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(e.message, e.statusCode));
//   } on InvalidAuthData catch (e) {
//     return Left(InvalidAuthData(e.errors));
//   }
// }
}
