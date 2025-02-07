class RemoteUrls {
  // static const String rootUrl = "https://mamunuiux.com/homeco/"; //test url
  //static const String rootUrl = "https://homeco.mamunuiux.com/"; //test url
  static const String rootUrl = "https://lab7.invoidea.in/zingcity/"; //test url
  //static const String rootUrl = "https://casasemangola.com/"; //test url
  static const String baseUrl = '${rootUrl}api/';
  static const String homeUrl = '${baseUrl}user/dashboard';
  static const String userRegisterAndUpdateData = '${baseUrl}user/profile-update';
  static const String userLogin = '${baseUrl}send-mobile-otp';
  static const String verifyOtp = '${baseUrl}veryfy-otp';
  static const String websiteSetup = '${baseUrl}website-setup';

  static String createPropertyInfoUrl(String token, String purpose) =>
      '${baseUrl}user/property/create?token=$token&purpose=$purpose';

  static String editInfoUrl(String id, String token) =>
      '${baseUrl}user/property/$id/edit?token=$token';

  static String getPropertyChooseInfo(String token) =>
      '${baseUrl}user/choose-property-type?token=$token';

  static String changePassword(String token) =>
      '${baseUrl}user/update-password?token=$token';

  static String userLogOut(String token) =>
      '${baseUrl}user/logout?token=$token';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';

  static String storeResetPassword = '${baseUrl}store-reset-password';

  static String userVerification = '${baseUrl}user-verification';
  static String resendVerificationCode = '${baseUrl}resend-register';

  static String singlePropertyDetailsUrl(String slug) =>
      '${baseUrl}property/$slug';

  static String createPropertyUrl(String token) =>
      '${baseUrl}user/property';

  static String deleteAccount(String token) =>
      '${baseUrl}user/delete-account?token=$token';

  static String updatePropertyUrl(String id, String token) =>
      '${baseUrl}user/update-property/$id';

  static String removeSliderImageUrl(String id, String token) =>
      '${baseUrl}user/remove-property-slider/$id?token=$token';

  static String removeSingleNearestLocationUrl(String id, String token) =>
      '${baseUrl}user/remove-nearest-location/$id?token=$token';

  static String removeSingleAddInfoUrl(String id, String token) =>
      '${baseUrl}user/remove-add-infor/$id?token=$token';

  static String removeSinglePlanUrl(String id, String token) =>
      '${baseUrl}user/remove-plan/$id?token=$token';

  static String deletePropertyUrl(String id, String token) =>
      '${baseUrl}user/property/$id?token=$token';

  static String getAgentDashboardInfo(String token) =>
      '${baseUrl}user/dashboard?token=$token';

  static String getAgentProfile() =>
      '${baseUrl}user/my-profile';


  static String getAgencyAgentList(String token) =>
      '${baseUrl}user/my-team?token=$token';

  static String createAgencyAgent(String token) =>
      '${baseUrl}user/store-agent?token=$token';

  static String createCompany(String token) =>
      '${baseUrl}user/apply-company?token=$token';

  static String getCompanyProfile(String token) =>
      '${baseUrl}user/company-profile?token=$token';

  static String updateCompanyProfile(String id, String token) =>
      '${baseUrl}user/update-agency-information/$id?token=$token';

  static String getEditAgencyAgent(String id, String token) =>
      '${baseUrl}user/agency-agent-edit/$id?token=$token';

  static String updateAgencyAgent(String id, String token) =>
      '${baseUrl}user/agency-agent-update/$id?token=$token';

  static String deleteAgencyAgent(String id, String token) =>
      '${baseUrl}user/agency-agent-delete/$id?token=$token';

  static String getAllAgent() => '${baseUrl}agents';

  static String getAllAgency() => '${baseUrl}agency-list';

  static String getAgentDetails(String userName) =>
      '${baseUrl}agent?agent_type=agent&user_name=$userName';

  static String getAgencyDetails(String id, String token) =>
      '${baseUrl}agency-details/$id?token=$token';

  static String sendMessageToAgent() => '${baseUrl}send-mail-to-agent';

  static String updateAgentProfileInfo(String token) =>
      '${baseUrl}user/update-profile?token=$token';

  static String getFaqContent() => '${baseUrl}faq';

  static String getPrivacyPolicy() => '${baseUrl}privacy-policy';

  static String getTermsAndCondition() => '${baseUrl}terms-and-conditions';

  static String getReviewList(String token) =>
      '${baseUrl}user/my-reviews?token=$token';

  static String storeReview(String token) =>
      '${baseUrl}store-property-review?token=$token';

  static String getWishListProperties(String token) =>
      '${baseUrl}user/wishlist?token=$token';

  static String addToWishlist(String token, String id) =>
      '${baseUrl}user/add-to-wishlist/$id?token=$token';

  static String removeFromWishlist(String token, String id) =>
      '${baseUrl}user/remove-wishlist/$id?token=$token';

  static String getContactUs() => '${baseUrl}contact-us';
  static String sendContactUsMessage = '${baseUrl}send-contact-message';

  static String getAboutUs() => '${baseUrl}about-us';

  static String getAllOrders(String token) =>
      '${baseUrl}user/orders?token=$token';

  static String getOrderDetails(String token, String orderId) =>
      '${baseUrl}user/order/$orderId?token=$token';

  static String getPricePlan() => '${baseUrl}pricing-plan';

  static String getPaymentPageInformation(String token, String planSlug) =>
      '${baseUrl}payment/$planSlug?token=$token';

  // support urls

  static String getAllTickets(String token) =>
      '${baseUrl}user/support-tickets?token=$token';

  static String showTicket(String token, String id) =>
      '${baseUrl}user/support-tickets/$id?token=$token';

  static String getPriorityList(String token) =>
      '${baseUrl}user/support-tickets/create?token=$token';

  static String createTicket(String token) =>
      '${baseUrl}user/support-tickets?token=$token';

  static String sendMessage(String token, String id) =>
      '${baseUrl}user/send-support-message/$id?token=$token';

  //kyc urls
  static String submitKyc(String token) =>
      '${baseUrl}user/kyc-submit?token=$token';

  static String getKycInfo(String token) => '${baseUrl}user/kyc?token=$token';

  static String getAgencyKyc = '${baseUrl}kyc-list';

  //booking urls

  static String getBookings(String token, String page) =>
      '${baseUrl}user/my-booking?token=$token&page=$page';

  static String bookingReq(String token, String page) =>
      '${baseUrl}user/property-booking?token=$token&page=$page';

  static String bookingReqDetails(String token, String id) =>
      '${baseUrl}user/property-booking/show/$id&token=$token';

  static String bookingStatusUpdate(String token, String id) =>
      '${baseUrl}user/property-booking/edit/$id?token=$token';

  static String createBooking(String token) =>
      '${baseUrl}user/booking?token=$token';

  static String addToCompare(token, id) =>
      '${baseUrl}user/add-to-compare/$id?token=$token';

  static String compareList(token) => '${baseUrl}user/compare?token=$token';

  static String removeCompare(token, id) =>
      '${baseUrl}user/remove-compare/$id?token=$token';

  static String getData() =>
      '${baseUrl}get-category';

  static String getMyPropertiesApi() =>
      '${baseUrl}user/property';

  //payment urls start

  static String freeEnrollment(String token, String planSlug) =>
      '${baseUrl}free-enroll/$planSlug?token=$token';

  static String bankPayment(String token, String planSlug) =>
      '${baseUrl}bank-payment/$planSlug?token=$token';

  static String stripePayment(String token, String planSlug) =>
      '${baseUrl}pay-with-stripe/$planSlug?token=$token';

  static String payWithFlutterWave(String token, String planSlug) =>
      '${rootUrl}flutterwave-webview/$planSlug?token=$token';

  static String payWithPayStack(String token, String planSlug) =>
      '${rootUrl}paystack-webview/$planSlug?token=$token';

  static String payWithMolli(String token, String planSlug) =>
      '${rootUrl}mollie-webview/$planSlug?token=$token';

  static String payWithInstamojo(String token, String planSlug) =>
      '${rootUrl}instamojo-webview/$planSlug?token=$token';

  static String payWithRazorpay(String token, String planSlug) =>
      '${rootUrl}razorpay-webview/$planSlug?token=$token';

  static String payWithPaypal(String token, String planSlug) =>
      '${rootUrl}paypal-webview/$planSlug?token=$token';

  //payment urls end

  static String getSearchProperty = '${baseUrl}property-search?';
  static String getAllProperty = '${baseUrl}properties';
  static String getFilterProperty = '${baseUrl}properties?';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
