import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/data_provider/remote_url.dart';
import '../../data/model/auth/set_password_model.dart';
import '../../data/model/auth/user_login_response_model.dart';
import '../../data/model/kyc/kyc_model.dart';
import '../../presentation/error/exception.dart';
import '../../presentation/error/failure.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<Either<dynamic, UserLoginResponseModel>> login(
      Map<String, dynamic> body);

  Either<Failure, UserLoginResponseModel> getCashedUserInfo();

  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body);

  Future<Either<dynamic, String>> sendForgotPassCode(Map<String, dynamic> body);

  Future<Either<dynamic, String>> setPassword(SetPasswordModel body);

  Future<Either<Failure, String>> sendActiveAccountCode(String email);

  Future<Either<Failure, String>> activeAccountCodeSubmit(
      Map<String, String> body);

  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, String> email);

  Future<Either<Failure, String>> logOut(String token);

  Future<Either<Failure, KycModel>> getKycInfo(String token);

  Future<Either<dynamic, String>> submitKyc(String token, KycItem body);
}

class AuthRepositoryImp extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<dynamic, UserLoginResponseModel>> login(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.signIn(body);
      final data = UserLoginResponseModel.fromMap(result);
      localDataSource.cacheUserResponse(data);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(String token) async {
    try {
      final result = await remoteDataSource.logOut(token);
      localDataSource.clearUserProfile();
      // localDataSource.clearCoupon();
      // localDataSource.clearCoupon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, UserLoginResponseModel> getCashedUserInfo() {
    try {
      final result = localDataSource.getUserResponseModel();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<dynamic, String>> signUp(Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.userRegister(body);
      return Right(result);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> sendForgotPassCode(
      Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.sendForgotPassCode(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> setPassword(SetPasswordModel body) async {
    try {
      final result = await remoteDataSource.setPassword(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> sendActiveAccountCode(String email) async {
    try {
      final result = await remoteDataSource.sendActiveAccountCode(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> activeAccountCodeSubmit(
      Map<String, String> body) async {
    try {
      final result = await remoteDataSource.activeAccountCodeSubmit(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> resendVerificationCode(
      Map<String, String> email) async {
    try {
      final result = await remoteDataSource.resendVerificationCode(email);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, KycModel>> getKycInfo(String token) async {
    try {
      final result = await remoteDataSource.getKycInfo(token);
      final data = KycModel.fromMap(result);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> submitKyc(String token, KycItem body) async {
    try {
      final result = await remoteDataSource.submitKyc(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}


class Respository {
  final http.Client client = http.Client();
  late Map<String, String> _mainHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  void updateHeader(String? token,) {

    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept' : 'application/json',
      'Authorization': 'Bearer $token'
    };
    print("Api main header ================>${_mainHeaders} ");
  }


  dynamic login(String number) {
    final uri = Uri.parse(RemoteUrls.userLogin);

    var body = {
      "phone": number,
    };

    log("${body} ", name: "Login  in Repository");
    log("${_mainHeaders} ", name: "Login  in Repository");
    var response = client.post(uri,body: jsonEncode(body), headers: _mainHeaders,);
    // log("${response} ", name: "Login  in Repository");
    return response;

  }
  dynamic OtpVerfy(String number,String Otp) {
    final uri = Uri.parse(RemoteUrls.verifyOtp);

    var body = {
      "phone": number,
      "otp": Otp
    };

    log("${body} ", name: "Login  in Repository verify otp");

    var response = client.post(uri,body: body);
    // log("${response} ", name: "Login  in Repository");
    return response;

  }
}