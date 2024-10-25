import 'package:dartz/dartz.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/logic/cubit/company/company_state_model.dart';
import '../../data/model/kyc/company_kyc_model.dart';
import '/presentation/error/failure.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/error/exception.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<KycListModel>>> getAgencyKyc();

  Future<Either<Failure, Profile>> getCompanyProfile(String token);
  //
  // Future<Either<Failure, List<AgencyListModel>>> getAgencyAgentList(
  //     String token);
  //
  Future<Either<dynamic, String>> createCompany(
      CompanyStateModel body,
      String token,
      );
  //
  // Future<Either<Failure, AgencyListModel>> getEditAgencyAgent(
  //     String id, String token);
  //
  Future<Either<dynamic, String>> updateCompanyProfile(
      String id, CompanyStateModel data, String token);


}

class CompanyRepositoryImpl implements CompanyRepository {
  final RemoteDataSource remoteDataSource;

  CompanyRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<KycListModel>>> getAgencyKyc() async {
    try {
      final result = await remoteDataSource.getAgencyKyc();
      final agency = result['kyc_list'] as List;
      final data = List<KycListModel>.from(
          agency.map((e) => KycListModel.fromMap(e))).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Profile>> getCompanyProfile(String token) async {
    try {
      final result = await remoteDataSource.getCompanyProfile(token);
      final data = Profile.fromMap(result['company_profile']);
      return Right(data);

    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // @override
  // Future<Either<Failure, List<AgencyListModel>>> getAgencyAgentList(
  //     String token) async {
  //   try {
  //     final result = await remoteDataSource.getAgencyAgentList(token);
  //     final agency = result['agents']['data'] as List;
  //     final data = List<AgencyListModel>.from(
  //         agency.map((e) => AgencyListModel.fromMap(e))).toList();
  //     return Right(data);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }
  //
  @override
  Future<Either<dynamic, String>> createCompany(
      CompanyStateModel body, String token) async {
    try {
      final result = await remoteDataSource.createCompany(body, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  // @override
  // Future<Either<Failure, AgencyListModel>> getEditAgencyAgent(
  //     String id, String token) async {
  //   try {
  //     final result = await remoteDataSource.getEditAgencyAgent(id, token);
  //     final data = AgencyListModel.fromMap(result['agency_agent']);
  //     return Right(data);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   } on InvalidAuthData catch (e) {
  //     return Left(InvalidAuthData(e.errors));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, String>> deleteAgencyAgent(
  //     String id, String token) async {
  //   try {
  //     final result = await remoteDataSource.deleteAgencyAgent(id, token);
  //     return Right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   } on InvalidAuthData catch (e) {
  //     return Left(InvalidAuthData(e.errors));
  //   }
  // }
  //
  @override
  Future<Either<dynamic, String>> updateCompanyProfile(
      String id, CompanyStateModel data, String token) async {
    try {
      final result = await remoteDataSource.updateCompanyProfile(id, data, token);
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
