import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../data/model/add_property_model.dart';
import '../../data/model/agency/agency_details_model.dart';
import '../../data/model/home/home_data_model.dart';
import '../../state_inject_package_names.dart';
import '/data/model/create_property/create_property_model.dart';
import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/create_property/edit_info/edit_info_model.dart';
import '../../data/model/product/property_choose_model.dart';
import '../../presentation/error/exception.dart';
import '../../presentation/error/failure.dart';
import '../cubit/add_property/add_property_state_model.dart';

abstract class PropertyRepository {
  Future<Either<Failure, CreatePropertyInfo>> getPropertyCreateInfo(
      String token, String purpose);

  Future<Either<Failure, PropertyTypeResponse>> getPropertyData();

  Future<Either<Failure, List<Properties>>> getMyProperties();

  Future<Either<dynamic, String>> createProperty(
      AddPropertyModel data);

  Future<Either<dynamic, String>> updateProperty(
      String id, AddPropertyModel data, );

  Future<Either<dynamic, String>> deleteSliderImage(String id, String token);

  Future<Either<Failure, String>> deleteProperty(String id, String token);

  Future<Either<dynamic, String>> deleteSingleNearestLocation(
      String id, String token);

  Future<Either<dynamic, String>> deleteSingleAddInfo(String id, String token);

  Future<Either<dynamic, String>> deleteSinglePlan(String id, String token);

  Future<Either<Failure, EditInfoModel>> getPropertyEditInfo(
      String id, String token);

  Future<Either<Failure, PropertyChooseModel>> getPropertyChooseInfo(
      String token);
}

class PropertyRepositoryImp extends PropertyRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PropertyRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, CreatePropertyInfo>> getPropertyCreateInfo(
      String token, String purpose) async {
    try {
      final result =
          await remoteDataSource.getPropertyCreateInfo(token, purpose);
      final data = CreatePropertyInfo.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> createProperty(
      AddPropertyModel data,) async {
    try {
      final result = await remoteDataSource.createPropertyRequest(data);
      debugPrint('result === >: $result');
      return Right(result);
    } on ServerException catch (e) {
      debugPrint('resultServer === >: ${e.message}');
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      debugPrint('resultAuth === >: ${e.message}');
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, EditInfoModel>> getPropertyEditInfo(
      String id, String token) async {
    try {
      final result = await remoteDataSource.getPropertyEditInfo(id, token);
      final data = EditInfoModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }



  @override
  Future<Either<dynamic, String>> deleteSingleAddInfo(
      String id, String token) async {
    try {
      final result = await remoteDataSource.removeSingleAddInfoApi(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> deleteSingleNearestLocation(
      String id, String token) async {
    try {
      final result =
          await remoteDataSource.removeSingleNearestLocationApi(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> deleteSinglePlan(
      String id, String token) async {
    try {
      final result = await remoteDataSource.removeSinglePlanApi(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> deleteSliderImage(
      String id, String token) async {
    try {
      final result = await remoteDataSource.removeSliderImageApi(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProperty(
      String id, String token) async {
    try {
      final result = await remoteDataSource.deleteProperty(id, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, PropertyChooseModel>> getPropertyChooseInfo(
      String token) async {
    try {
      final result = await remoteDataSource.getPropertyChooseInfo(token);
      final data = PropertyChooseModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PropertyTypeResponse>> getPropertyData() async {
     try {
    final result = await remoteDataSource.getPropertyInfo();

    final data = PropertyTypeResponse.fromJson(result);
    // log('value === >: ${result}',name:"roomtype");
    return Right(data);
    } on ServerException catch (e) {
    return Left(ServerFailure(e.message, e.statusCode));
    }
  }


  @override
  Future<Either<dynamic, String>> updateProperty(
      String id, AddPropertyModel data, ) async {



    try {
      final result = await remoteDataSource.updatePropertyRequest(id,data);
      debugPrint('result === >: $result');
      return Right(result);
    } on ServerException catch (e) {
      debugPrint('resultServer === >: ${e.message}');
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      debugPrint('resultAuth === >: ${e.message}');
      return Left(InvalidAuthData(e.errors));
    }


  }


  @override
  Future<Either<Failure, List<Properties>>> getMyProperties() async {
    try {
      final result = await remoteDataSource.getMyProperties();
     List<dynamic> values = result['data'];
     // log('Data === >: $values');
     // values.forEach((element) {
     //   debugPrint('value === >: $element');
     //
     // });
      final data = values.map((e) => Properties.fromMap(e)).toList();
      // log('My Properties: $values',name: "My Properties");
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
