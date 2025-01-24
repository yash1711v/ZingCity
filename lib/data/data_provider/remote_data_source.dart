import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate/logic/cubit/company/company_state_model.dart';

import '../../logic/cubit/add_property/add_property_state_model.dart';
import '../../logic/cubit/agency/agency_state_model.dart';
import '../../logic/cubit/agent/agent_state_model.dart';
import '../../logic/cubit/change_password/change_password_cubit.dart';
import '../../logic/cubit/contact_us/contact_us_state_model.dart';
import '../../logic/cubit/payment/stripe_payment/stripe_payment_state_model.dart';
import '../../logic/cubit/profile/profile_state_model.dart';
import '../../presentation/error/failure.dart';
import '../../state_inject_package_names.dart';
import '../model/auth/set_password_model.dart';
import '../model/booking/booking_model.dart';
import '../model/kyc/kyc_model.dart';
import '../model/ticket/ticket_model.dart';
import 'network_parser.dart';
import 'remote_url.dart';

abstract class RemoteDataSource {
  Future signIn(Map<String, dynamic> body);

  Future<String> userRegister(Map<String, dynamic> userInfo);

  Future getHomeData();

  Future getPropertyCreateInfo(String token, String purpose);

  Future<String> createPropertyRequest(AddPropertyModel data);

  Future<String> updatePropertyRequest(
      String id, AddPropertyModel data, String token);

  Future<String> removeSliderImageApi(String id, String token);

  Future<String> deleteProperty(String id, String token);

  Future<String> removeSingleNearestLocationApi(String id, String token);

  Future<String> removeSingleAddInfoApi(String id, String token);

  Future<String> removeSinglePlanApi(String id, String token);

  Future getPropertyEditInfo(String id, String token);

  Future getPropertyChooseInfo(String token);
  Future getPropertyInfo();
  Future getMyProperties();

  Future websiteSetup();

  Future<String> passwordChange(
      ChangePasswordStateModel changePassData, String token);

  Future<String> sendForgotPassCode(Map<String, dynamic> body);

  Future<String> setPassword(SetPasswordModel body);

  Future<String> sendActiveAccountCode(String email);

  Future<String> activeAccountCodeSubmit(Map<String, String> body);

  Future<String> resendVerificationCode(Map<String, String> email);

  Future getSinglePropertyDetails(String slug);

  Future getAgentDashboardInfo(String token);

  Future getAgentProfile();

  Future<String> deleteAccount(String token, ProfileStateModel password);

  Future getAllAgent();

  Future getAllAgency();

  Future getAgentDetails(String userName);

  Future getAgencyDetails(String id, String token);

  Future sendMessageToAgent(AgentStateModel messages);

  Future getAgencyAgentList(String token);

  Future<String> createAgencyAgent(AgencyStateModel body, String token);

  Future<String> createCompany(CompanyStateModel body, String token);

  Future getEditAgencyAgent(String id, String token);

  Future getCompanyProfile(String token);

  Future<String> updateCompanyProfile(
      String id, CompanyStateModel data, String token);

  Future<String> updateAgencyAgent(
      String id, AgencyStateModel data, String token);

  Future<String> deleteAgencyAgent(String id, String token);

  Future<String> updateAgentProfileInfo(String token, ProfileStateModel body);

  Future getFaqContent();

  Future getPrivacyPolicy();

  Future getTermsAndCondition();

  Future getReviewList(String token);

  Future<String> storeReview(String token, Map<String, String> body);

  Future getWishListProperties(String token);

  Future<String> addToWishlist(String token, String id);

  Future<String> removeFromWishlist(String token, String id);

  Future getContactUs();

  Future<String> sendContactUsMessage(ContactUsStateModel body);

  Future getAboutUs();

  Future getAllOrders(String token);

  Future getOrderDetails(String token, String orderId);

  Future getPricePlan();

  Future getPaymentPageInformation(String token, String planSlug);

  Future<String> freeEnrollment(String token, String planSlug);

  Future<String> bankPayment(
      String token, String planSlug, Map<String, String> body);

  Future<String> stripePayment(
      String token, String planSlug, StripePaymentStateModel body);

  Future<Map<String, dynamic>> flutterWavePayment(Uri uri);

  //Future getPropertyDetail(String slug);

  Future getSearchProperty(Uri uri);

  Future getAllProperty();

  Future getFilterProperty(Uri uri);

  Future<String> logOut(String tokne);

  Future getAllTickets(String token);

  Future showTicket(String token, String id);

  Future getPriorityList(String token);

  Future createTicket(TicketModel body);

  Future sendMessage(TicketModel body);

  Future getKycInfo(String token);

  Future getAgencyKyc();

  Future<String> submitKyc(String token, KycItem data);

  Future getBookings(String token, String page);

  Future bookingReq(String token, String page);

  Future bookingReqDetails(String token, String id);

  Future bookingStatusUpdate(String token, String id, BookingModel data);

  Future createBooking(String token, BookingModel body);

  Future compareList(String token);

  Future addToCompare(String token, String id);

  Future removeCompare(String token, String id);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImp extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future signIn(Map body) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getHomeData() async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.homeUrl);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getPropertyCreateInfo(String token, String purpose) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.createPropertyInfoUrl(token, purpose));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getPropertyChooseInfo(String token) async {
    final uri = Uri.parse(RemoteUrls.getPropertyChooseInfo(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['property_content'];
  }

  @override
  Future websiteSetup() async {
    final uri = Uri.parse(RemoteUrls.websiteSetup);
    print('website-url $uri');
    final clientMethod = client.get(
      uri,
      headers: headers,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> userRegister(Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.userRegisterAndUpdateData);

    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: userInfo,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> sendForgotPassCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.sendForgetPassword);

    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: body,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> setPassword(SetPasswordModel body) async {
    final uri = Uri.parse(RemoteUrls.storeResetPassword);

    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: body.toMap(),
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> sendActiveAccountCode(String email) async {
    final uri = Uri.parse(RemoteUrls.resendRegisterCode);

    final clientMethod = client.post(
      uri,
      headers: postDeleteHeader,
      body: {'email': email},
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> activeAccountCodeSubmit(Map<String, String> body) async {
    final uri = Uri.parse(RemoteUrls.userVerification);

    final clientMethod =
        client.post(uri, body: body, headers: postDeleteHeader);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> resendVerificationCode(Map<String, String> email) async {
    final uri = Uri.parse(RemoteUrls.resendVerificationCode);

    final clientMethod =
        client.post(uri, body: email, headers: postDeleteHeader);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  ) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.changePassword(token));

    final clientMethod =
        client.post(uri, headers: headers, body: changePassData.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] ?? "";
  }

  @override
  Future<String> logOut(String tokne) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogOut(tokne));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<void> getAgentDashboardInfo(String token) async {
    final uri = Uri.parse(RemoteUrls.getAgentDashboardInfo(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }


  @override
  Future<String> createAgencyAgent(
      AgencyStateModel body, String token,) async {
    final url = Uri.parse(RemoteUrls.createAgencyAgent(token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };
    // final clientMethod = client.put(url, headers: headers,body: body);
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.image.isNotEmpty) {
      print('immmmmm: ${body.image}');
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> createCompany(
      CompanyStateModel body, String token,) async {
    final url = Uri.parse(RemoteUrls.createCompany(token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };
    // final clientMethod = client.put(url, headers: headers,body: body);
    final request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.image.isNotEmpty) {
      print('immmmmm: ${body.image}');
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    if (body.file.isNotEmpty) {
      print('file: ${body.file}');
      final file = await http.MultipartFile.fromPath('file', body.file);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }


  @override
  Future getEditAgencyAgent(String id, String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.getEditAgencyAgent(id, token));
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCompanyProfile(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.getCompanyProfile(token));
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }


  @override
  Future<String> updateCompanyProfile(
      String id, CompanyStateModel data, String token) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.updateCompanyProfile(id, token));
   print("updateCompanyUrl $uri");
    log('update AgencyAgent map data:', name: '${data.toMap()}');
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(data.toMap());

    request.headers.addAll(headers);

    if (data.image.isNotEmpty) {
      print('immmmmm: ${data.image}');
      final file = await http.MultipartFile.fromPath('image', data.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }


  @override
  Future<String> updateAgencyAgent(
      String id, AgencyStateModel data, String token) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.updateAgencyAgent(id, token));

    log('update AgencyAgent map data:', name: '${data.toMap()}');
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(data.toMap());

    request.headers.addAll(headers);

    if (data.image.isNotEmpty) {
      print('immmmmm: ${data.image}');
      final file = await http.MultipartFile.fromPath('image', data.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }



  // @override
  // Future<String> updateAgentProfileInfo(
  //     String token, ProfileStateModel body) 
  // async {
  //   final url = Uri.parse(RemoteUrls.updateAgentProfileInfo(token));
  //   final headers = {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'X-Requested-With': 'XMLHttpRequest',
  //   };
  //   // final clientMethod = client.put(url, headers: headers,body: body);
  //   final request = http.MultipartRequest(
  //     'POST',
  //     url,
  //   );
  //   request.fields.addAll(body.toMap());
  //
  //   request.headers.addAll(headers);
  //   if (body.image.isNotEmpty) {
  //     print('immmmmm: ${body.image}');
  //     final file = await http.MultipartFile.fromPath('image', body.image);
  //     request.files.add(file);
  //   }
  //   // final file = await http.MultipartFile.fromPath('image', body.image);
  //   // request.files.add(file);
  //
  //   http.StreamedResponse response = await request.send();
  //   final clientMethod = http.Response.fromStream(response);
  //
  //   final responseJsonBody =
  //       await NetworkParser.callClientWithCatchException(() => clientMethod);
  //   return responseJsonBody['message'] as String;
  // }

  @override
  Future getFaqContent() async {
    final uri = Uri.parse(RemoteUrls.getFaqContent());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['faq'];
  }

  @override
  Future getSinglePropertyDetails(String slug) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final uri = Uri.parse(RemoteUrls.singlePropertyDetailsUrl(slug));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getTermsAndCondition() async {
    final uri = Uri.parse(RemoteUrls.getTermsAndCondition());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['terms_conditions'];
  }

  @override
  Future getPrivacyPolicy() async {
    final uri = Uri.parse(RemoteUrls.getPrivacyPolicy());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['privacyPolicy'];
  }

  @override
  Future getReviewList(String token) async {
    final uri = Uri.parse(RemoteUrls.getReviewList(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['reviews'];
  }



  @override
  Future<String> storeReview(String token, Map<String, String> body) async {
    final uri = Uri.parse(RemoteUrls.storeReview(token));

    final clientMethod =
        client.post(uri, body: body, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future getWishListProperties(String token) async {
    final uri = Uri.parse(RemoteUrls.getWishListProperties(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> addToWishlist(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.addToWishlist(token, id));
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> removeFromWishlist(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.removeFromWishlist(token, id));
    final clientMethod = client.delete(uri, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future getContactUs() async {
    final uri = Uri.parse(RemoteUrls.getContactUs());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> sendContactUsMessage(ContactUsStateModel body) async {
    final uri = Uri.parse(RemoteUrls.sendContactUsMessage);
    final headers = postDeleteHeader;

    final clientMethod = client.post(uri, body: body.toMap(), headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getAboutUs() async {
    final uri = Uri.parse(RemoteUrls.getAboutUs());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAgentProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    final _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? token}'
    };
    final uri = Uri.parse(RemoteUrls.getAgentProfile());

    final clientMethod = client.get(uri, headers: _mainHeaders);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return clientMethod;
  }

  @override
  Future<String> deleteAccount(String token, ProfileStateModel password) async {
    final uri = Uri.parse(RemoteUrls.deleteAccount(token));
    final currentPassword = {'current_password': password.currentPassword};
    final clientMethod =
        client.delete(uri, body: currentPassword, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future getAllAgent() async {
    final uri = Uri.parse(RemoteUrls.getAllAgent());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAllAgency() async {
    final uri = Uri.parse(RemoteUrls.getAllAgency());
    print("agency Url : $uri");
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAgentDetails(String userName) async {
    final uri = Uri.parse(RemoteUrls.getAgentDetails(userName));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAgencyDetails(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.getAgencyDetails(id, token));
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future sendMessageToAgent(AgentStateModel messages) async {
    final uri = Uri.parse(RemoteUrls.sendMessageToAgent());
    final header = postDeleteHeader;
    final clientMethod =
        client.post(uri, body: messages.toMap(), headers: header);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }


  @override
  Future getAgencyAgentList(String token) async {
    final uri = Uri.parse(RemoteUrls.getAgencyAgentList(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }


  @override
  Future getAllOrders(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllOrders(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getOrderDetails(String token, String orderId) async {
    final uri = Uri.parse(RemoteUrls.getOrderDetails(token, orderId));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['order'];
  }

  @override
  Future getPricePlan() async {
    final uri = Uri.parse(RemoteUrls.getPricePlan());

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getPaymentPageInformation(String token, String planSlug) async {
    final uri =
        Uri.parse(RemoteUrls.getPaymentPageInformation(token, planSlug));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> freeEnrollment(String token, String planSlug) async {
    final uri = Uri.parse(RemoteUrls.freeEnrollment(token, planSlug));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> bankPayment(
      String token, String planSlug, Map<String, String> body) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.bankPayment(token, planSlug));

    final clientMethod = client.post(uri, body: body, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> stripePayment(
      String token, String planSlug, StripePaymentStateModel body) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.stripePayment(token, planSlug));

    final clientMethod = client.post(uri, body: body.toMap(), headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<Map<String, dynamic>> flutterWavePayment(Uri uri) async {
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody as Map<String, dynamic>;
  }

  @override
  Future getSearchProperty(Uri uri) async {
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['data'];
  }

  @override
  Future getAllProperty() async {
    final uri = Uri.parse(RemoteUrls.getAllProperty);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getFilterProperty(Uri uri) async {
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> createPropertyRequest(
      AddPropertyModel data,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    final _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? token}'
    };
    final uri = Uri.parse(RemoteUrls.createPropertyUrl(token!));
    // debugPrint('create-url $uri');
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      "title": data.title,
      "slug": data.title.trim().replaceAll(" ", "-"),
      "category_id": data.categoryId.toString(),
      "property_type_id": data.propertyTypeId.toString(),
      "purpose": data.purpose == "rent" ? "2" :  "1",
      "bhk_type": data.roomTypeId.toString(),
      "rent_period": data.rentPeriod.toLowerCase(),
      "price": data.price,
      "description": data.description,
      "total_area": data.totalArea,
      "total_unit": data.totalUnit,
      "total_bedroom": data.totalBedroom,
      "total_bathroom": data.totalBathroom,
      "total_garage": data.totalGarage,
      "total_kitchen": data.totalKitchen,
      "city_id": data.cityId,
      "state_id": data.stateId,
      "country_id": "0",
      "address": data.address,
      "address_description": "",
      "google_map": "",
      "lat": "",
      "lng": "",
      // "thumbnail_image": data.thumbNailImage,// File upload (use Postman to upload the file)
      "video_thumbnail": "", // File upload (use Postman to upload the file)
      "aminities[]": jsonEncode(data.aminities),
      // "slider_images": ["slider_image1.jpg", "slider_image2.jpg"], // File upload (use Postman to upload the files)
      // "nearest_locations": [1, 2],
      "distances[]": jsonEncode(data.distance),
      "nearest_locations[]": jsonEncode(data.nearestLocation),
      "add_keys": "",
      "add_values": "",
      "date_form": "",
      "date_to": "",
      "time_form": "",
      "time_to": "",
      "possession_status": "2"
    });

    // log('create property map data:', name: '${data.toMap()}');

    request.headers.addAll(_mainHeaders);

    if (data.thumbNailImage.isNotEmpty) {
      print('thumbnailImage ${data.thumbNailImage}');
      final thumbImage =
          await http.MultipartFile.fromPath('thumbnail_image', data.thumbNailImage);
      request.files.add(thumbImage);
    }

    // if (data.propertyImageDto.sliderImages.isNotEmpty) {
    //   for (var i = 0; i < data.propertyImageDto.sliderImages.length; i++) {
    //     final file = await http.MultipartFile.fromPath(
    //         'slider_images[$i]', data.propertyImageDto.sliderImages[i].image);
    //     request.files.add(file);
    //   }
    // }
    if (data.sliderImages.isNotEmpty) {
      for (var i = 0; i < data.sliderImages.length; i++) {
        final file = await http.MultipartFile.fromPath(
            'slider_images[$i]', data.sliderImages[i].path);
        request.files.add(file);
      }
    }

    // if (data.aminities.isNotEmpty) {
    //   for (var i = 0; i < data.aminities.length; i++) {
    //     final file = await http.MultipartFile.fromPath(
    //         'aminities[$i]', data.aminities[i].toString());
    //     request.files.add(file);
    //   }
    // }

    // if (data.nearestLocation.isNotEmpty) {
    //   for (var i = 0; i < data.nearestLocation.length; i++) {
    //     final file = await http.MultipartFile.fromPath(
    //         'nearest_locations[$i]', data.nearestLocation[i].toString());
    //     request.files.add(file);
    //   }
    // }

    // if (data.distance.isNotEmpty) {
    //   for (var i = 0; i < data.distance.length; i++) {
    //     final file = await http.MultipartFile.fromPath(
    //         'distances[$i]', data.distance[i].toString());
    //     request.files.add(file);
    //   }
    // }

    if (data.propertyVideoDto.videoThumbnail.isNotEmpty) {
      final file = await http.MultipartFile.fromPath(
          'video_thumbnail', data.propertyVideoDto.videoThumbnail);
      request.files.add(file);
    }

    if (data.propertyPlanDto.isNotEmpty) {
      for (var i = 0; i < data.propertyPlanDto.length; i++) {
        print("Path ${data.propertyPlanDto[i].planImages}");
        if (data.propertyPlanDto[i].planImages.isNotEmpty) {
          final file = await http.MultipartFile.fromPath(
              'plan_images[$i]', data.propertyPlanDto[i].planImages);
          request.files.add(file);
        }
      }
    }
log(request.fields.toString(),name: "Data");
    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> updatePropertyRequest(
      String id, AddPropertyModel data, String token) async {
    final headers = postDeleteHeader;
    final uri = Uri.parse(RemoteUrls.updatePropertyUrl(id, token));

    log('update property map data:', name: '${data.toMap()}');
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(data.toMap());

    request.headers.addAll(headers);

    if (data.image.isNotEmpty && !data.image.contains('https://')) {
      final thumbImage =
          await http.MultipartFile.fromPath('thumbnail_image', data.image);
      request.files.add(thumbImage);
    }
    for (int i = 0; i < data.galleryImage.length; i++) {
      final element = data.galleryImage[i];
      if (element.image.isNotEmpty && !element.image.contains('https://')) {
        final file = await http.MultipartFile.fromPath(
            'slider_images[$i]', element.image);
        request.files.add(file);
      }
    }
    if (data.propertyVideoDto.videoThumbnail.isNotEmpty &&
        !data.propertyVideoDto.videoThumbnail.contains('https://')) {
      final file = await http.MultipartFile.fromPath(
          'video_thumbnail', data.propertyVideoDto.videoThumbnail);
      request.files.add(file);
    }

    if (data.propertyPlanDto.isNotEmpty) {
      for (int i = 0; i < data.propertyPlanDto.length; i++) {
        final element = data.propertyPlanDto[i].planImages;
        final id = data.propertyPlanDto[i].id;
        if (element.isNotEmpty && !element.contains('https://')) {
          final file =
              await http.MultipartFile.fromPath('plan_images[$i]', element);
          request.files.add(file);
        }
        // else if (element.isNotEmpty) {
        //   //final imgPath = element.split(RemoteUrls.rootUrl).last;
        //   final file = await http.MultipartFile.fromPath(
        //       'existing_plan_image_$id', element);
        //   // final file = await http.MultipartFile.fromString('existing_plan_image_$id', imgPath);
        //   request.files.add(file);
        // }
      }
    }

    // else {
    //   final imgPath = data.image.split(RemoteUrls.rootUrl).last;
    //   print("imgPath $imgPath");
    //   print('http-not-available image ${data.image}');
    // }

    // for (var i = 0; i < data.galleryImage.length; i++) {
    //   final element = data.galleryImage[i];
    //   if (element.contains('https://') == false) {
    //     final file =
    //         await http.MultipartFile.fromPath('slider_images[$i]', element);
    //     request.files.add(file);
    //   }
    // }
    //
    // if (data.propertyVideoDto.videoThumbnail.contains('https://') == false) {
    //   if (data.propertyVideoDto.videoThumbnail.isNotEmpty) {
    //     final file = await http.MultipartFile.fromPath(
    //         'video_thumbnail', data.propertyVideoDto.videoThumbnail);
    //     request.files.add(file);
    //   }
    // }
    //
    // if (data.propertyPlanDto.isNotEmpty) {
    //   for (var i = 0; i < data.propertyPlanDto.length; i++) {
    //     final element = data.propertyPlanDto[i].planImages;
    //     final id = data.propertyPlanDto[i].id;
    //     print("pln img $element");
    //     if (element.isNotEmpty && element.contains('https://') == false) {
    //       final file =
    //           await http.MultipartFile.fromPath('plan_images[$i]', element);
    //       request.files.add(file);
    //     } else if (element.isNotEmpty) {
    //       final imgPath = element.split(RemoteUrls.rootUrl).last;
    //       print("imgPath $imgPath");
    //       final file =
    //           http.MultipartFile.fromString('existing_plan_image_$id', imgPath);
    //       request.files.add(file);
    //     }
    //   }
    // }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getPropertyEditInfo(String id, String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.editInfoUrl(id, token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> removeSingleAddInfoApi(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.removeSingleAddInfoUrl(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> removeSingleNearestLocationApi(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.removeSingleNearestLocationUrl(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> removeSinglePlanApi(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.removeSinglePlanUrl(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> removeSliderImageApi(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.removeSliderImageUrl(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> deleteProperty(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.deletePropertyUrl(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }


  @override
  Future<String> deleteAgencyAgent(String id, String token) async {
    final uri = Uri.parse(RemoteUrls.deleteAgencyAgent(id, token));

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }


  @override
  Future createTicket(TicketModel body) async {
    final uri = Uri.parse(RemoteUrls.createTicket(body.token));

    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAllTickets(String token) async {
    final uri = Uri.parse(RemoteUrls.getAllTickets(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getPriorityList(String token) async {
    final uri = Uri.parse(RemoteUrls.getPriorityList(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future sendMessage(TicketModel body) async {
    final uri = Uri.parse(RemoteUrls.sendMessage(body.token, body.ticketId));
    final mapBody = {'message': body.messageFrom};
    final clientMethod =
        client.post(uri, body: mapBody, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future showTicket(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.showTicket(token, id));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getKycInfo(String token) async {
    final uri = Uri.parse(RemoteUrls.getKycInfo(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future getAgencyKyc() async {
    final uri = Uri.parse(RemoteUrls.getAgencyKyc);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future<String> submitKyc(String token, KycItem data) async {
    final uri = Uri.parse(RemoteUrls.submitKyc(token));

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(data.toMap());

    request.headers.addAll(postDeleteHeader);
    if (data.file.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('file', data.file);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future bookingReq(String token, String page) async {
    final uri = Uri.parse(RemoteUrls.bookingReq(token, page));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future bookingReqDetails(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.bookingReqDetails(token, id));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future bookingStatusUpdate(String token, String id, BookingModel data) async {
    final uri = Uri.parse(RemoteUrls.bookingStatusUpdate(token, id));

    final body = {'status': data.status};

    final clientMethod = client.post(uri, body: body, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future createBooking(String token, BookingModel body) async {
    final uri = Uri.parse(RemoteUrls.createBooking(token));

    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getBookings(String token, String page) async {
    final uri = Uri.parse(RemoteUrls.getBookings(token, page));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future addToCompare(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.addToCompare(token, id));

    final clientMethod = client.post(uri, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future compareList(String token) async {
    final uri = Uri.parse(RemoteUrls.compareList(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future removeCompare(String token, String id) async {
    final uri = Uri.parse(RemoteUrls.removeCompare(token, id));

    final clientMethod = client.delete(uri, headers: postDeleteHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> updateAgentProfileInfo(String token, ProfileStateModel body) {
    // TODO: implement updateAgentProfileInfo
    throw UnimplementedError();
  }

  @override
  Future getPropertyInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    final _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? token}'
    };
    final uri = Uri.parse(RemoteUrls.getData());

    final clientMethod = client.get(uri, headers: _mainHeaders);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    log('responseJsonBody', name: responseJsonBody.toString());
    return responseJsonBody;
  }

  @override
  Future getMyProperties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    final _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? token}'
    };
    final uri = Uri.parse(RemoteUrls.getMyPropertiesApi());

    final clientMethod = client.get(uri, headers: _mainHeaders);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    log('responseJsonBody', name: responseJsonBody.toString());
    return responseJsonBody['properties'];
  }
}
