import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/data_provider/remote_url.dart';
import '../../data/model/auth/set_password_model.dart';
import '../../data/model/auth/user_login_response_model.dart';
import '../../data/model/home/home_data_model.dart';
import '../../data/model/kyc/kyc_model.dart';
import '../../presentation/error/exception.dart';
import '../../presentation/error/failure.dart';
import 'package:http/http.dart' as http;

import '../../state_inject_package_names.dart';

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
    // try {
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   final result = await preferences.clear();
    //   localDataSource.clearUserProfile();
    //   // localDataSource.clearCoupon();
    //   // localDataSource.clearCoupon();
    //   return Right(result!);
    // } on ServerException catch (e) {
    //   return Left(ServerFailure(e.message, e.statusCode));
    // }
    return Right("Success");
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

class Repository {
  final http.Client client = http.Client();
  late Map<String, String> _mainHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<void> updateHeader(
    String? tokens,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? tokens}'
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
    var response = client.post(
      uri,
      body: jsonEncode(body),
      headers: _mainHeaders,
    );
    // log("${response} ", name: "Login  in Repository");
    return response;
  }

  dynamic OtpVerfy(String number, String Otp) {
    final uri = Uri.parse(RemoteUrls.verifyOtp);

    var body = {"phone": number, "otp": Otp};

    log("${body} ", name: "Login  in Repository verify otp");

    var response = client.post(uri, body: body);
    // log("${response} ", name: "Login  in Repository");
    return response;
  }

  dynamic updateProfile({
    required String name,
    required String number,
    required String address,
    required String description,
    required String email,
    required String about,
    required File image,
    required String token,
  }) async {
    final uri = Uri.parse(RemoteUrls.userRegisterAndUpdateData);
    await updateHeader(token);

    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name ?? '';
    request.fields['phone'] = number ?? '';
    request.fields['address'] = address ?? '';
    request.fields['description'] = description ?? '';
    request.fields['email'] = email ?? '';
    request.fields['about'] = about ?? '';

    if (image.path.isNotEmpty) {
      // debugPrint('====> isEmpty: ${files.isEmpty}');
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }
    // debugPrint('====> API Call: $url\nHeader: $token');
    // debugPrint('====> API body: ${request.files.single.filename}');
    request.headers.addAll(_mainHeaders);
    log('====> API body: ${request.headers}');

    try {
      // Send the request and get the StreamedResponse
      final streamedResponse = await request.send();

      // Convert the StreamedResponse to a Response
      final response = await http.Response.fromStream(streamedResponse);
      log('====> API Response: ${response.body}');
      return response;
    } catch (e) {
      print("Exception: $e");
      rethrow; // Re-throw the error if needed
    }

    // var body = {"phone": number, "otp": Otp};

    //
    //
    // var response = client.post(uri, body: body);
    // // log("${response} ", name: "Login  in Repository");
    // return response;
  }

  dynamic getHomeScreenData({required String lat, required String long}) async {
    final uri =
        Uri.parse("${RemoteUrls.homeUrl}?latitude=$lat&longitude=$long");
    await updateHeader("");

    // var body = {
    //   "":,
    //   "":,
    // };

    // log("${body} ", name: "Data is ");

    var response = client.get(uri, headers: _mainHeaders);
    log("${response} ", name: "HomeData");
    return response;
  }

  Future<dynamic> getEnquiryRequests() async {
    final uri = Uri.parse("${RemoteUrls.baseUrl}property-enquiry");
    await updateHeader("");

    var response = await client.get(uri, headers: _mainHeaders);
    log("${response.body} ", name: "Enquiry Requests");

    var data = jsonDecode(response.body);

    List<dynamic> properties =
        data['data'].map((e) => Properties.fromMap(e)).toList();

    return properties;
  }

  Future<dynamic> getUserEnquires() async {
    final uri = Uri.parse("${RemoteUrls.baseUrl}enquiry");
    await updateHeader("");

    var response = await client.get(uri, headers: _mainHeaders);
    log("${response.body} ", name: "Enquiry Requests");

    var data = jsonDecode(response.body);
          log("${data['data']} ", name: "Enquiry Requests");
    List<dynamic> properties =
        data['data'].map((e) => EnquiryModel.fromMap(e)).toList();

    return properties;
  }

  Future<dynamic> deleteMyProperty(String id) async {
    debugPrint("$id");
    final uri = Uri.parse("${RemoteUrls.baseUrl}user/delete-property");
    await updateHeader("");
  var body = {
    "id": id
  };

  debugPrint("$uri");
    var response = await client.post(uri, headers: _mainHeaders,body: jsonEncode(body));
    log("${response.body} ", name: "Enquiry Requests");

    var data = jsonDecode(response.body);
    //
    // List<dynamic> properties = data['data'].map((e) => Properties.fromMap(e)).toList();
    //
    return data['message'] == 'Deleted successfully';
  }

  Future<dynamic> filter({
    required String maxPrice,
    required String minPrice,
    required String roomType,
    required String city,
    required String possession,
    required String maxArea,
    required String purpose,
    required String type,
    required String minArea,
    required String possessionStatus,
    required String categoryId,
  }) async {
    final uri = Uri.parse("${RemoteUrls.baseUrl}properties/search");
    await updateHeader("");

    var body = {
      // "category_id":categoryId,
      if(possessionStatus != "null")
      "possession_status": possessionStatus,
      "purpose": purpose,
      if(city != "null")
      "city": city,
      "country": 0,
      "type": type,
      "min_price": minPrice,
      "max_price": maxPrice,
      if(minArea != "null")
      "min_area": minArea,
      if(maxArea != "null")
      "max_area": maxArea,
      "room_types[]": [roomType],
    };
  debugPrint("body==>$body");
    var response = await client.post(
      uri,
      headers: _mainHeaders,
      body: jsonEncode(body), // Encode the body as JSON
    );

    log("${response.body} ", name: "Enquiry Requests");

    Map<String,dynamic> data = jsonDecode(response.body);
    log("${data['status']} ", name: "Search Data");

    return data;
  }

}
