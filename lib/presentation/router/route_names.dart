import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/data/model/auth/user_login_response_model.dart';
import 'package:real_estate/presentation/screens/company_screen/company_screen.dart';
import 'package:real_estate/presentation/screens/company_screen/components/create_agent_screen.dart';
import 'package:real_estate/presentation/screens/company_screen/create_company_screen.dart';
import 'package:real_estate/presentation/screens/company_screen/update_company_screen.dart';
import 'package:real_estate/presentation/screens/rent_screen/rent_screen.dart';

import '../screens/booking/booking_request_screen.dart.dart';
import '../screens/booking/compare_screen.dart';
import '../screens/booking/create_booking_screen.dart';
import '../screens/booking/my_booking_screen.dart';
import '../screens/home/agent/components/agency_profile_screen.dart';
import '../screens/kyc/kyc_screen.dart';
import '../screens/property_create/add_property_screen.dart';
import '../screens/rent_screen/rent_screen.dart';
import '../screens/rent_screen/rent_screen.dart';
import '../screens/support/single_support_screen.dart';
import '../screens/support/support_screen.dart';
import 'route_packages_name.dart';

class RouteNames {
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String updatePasswordScreen = '/updatePasswordScreen';
  static const String homeScreen = '/homeScreen';
  static const String mainPageScreen = '/mainPageScreen';
  static const String allCategoryScreen = '/allCategoryScreen';
  static const String allPropertyScreen = '/allPropertyScreen';
  static const String urgentPropertyScreen = '/urgentPropertyScreen';
  static const String allRecommendedPropertyScreen =
      '/allRecommendedPropertyScreen';
  static const String allBrokerAgentListScreen = '/allBrokerAgentListScreen';
  static const String agentProfileScreen = '/agentProfileScreen';
  static const String sendMessageScreen = '/sendMessageScreen';
  static const String profileScreen = '/profileScreen';
  static const String updateProfileScreen = '/updateProfileScreen';
  static const String propertyDetailsScreen = '/propertyDetailsScreen';
  static const String myDealsScreen = '/myDealsScreen';
  static const String rentScreen = '/RentScreen';
  static const String savedScreen = '/SavedScreen';
  static const String choosePropertyOptionScreen =
      '/choosePropertyOptionScreen';
  static const String addNewPropertyScreen = '/addNewPropertyScreen';
  static const String newPropertyCreateScreen = '/newPropertyCreateScreen';
  static const String addPropertyScreen = '/addPropertyScreen';
  static const String reviewScreen = '/reviewScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String paymentMethodScreen = '/paymentMethodScreen';

  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String termsAndConditionScreen = '/termsAndConditionScreen';
  static const String faqScreen = '/faqScreen';
  static const String premiumMembershipScreen = '/premiumMembershipScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String purchaseScreen = '/purchaseScreen';
  static const String purchaseDetailsScreen = '/purchaseDetailsScreen';
  static const String searchScreen = '/searchScreen';
  static const String updateScreen = '/updateScreen';
  static const String filterPropertyScreen = '/filterPropertyScreen';


  /// company
  static const String createCompanyScreen = '/createCompanyScreen';
  static const String updateCompanyScreen = '/updateCompanyScreen';
  static const String companyScreen = '/companyScreen';
  static const String createAgentScreen = '/createAgentScreen';
  static const String agencyDetailsScreen = '/agencyDetailsScreen';



//payment string
  static const String bankPaymentScreen = '/bankPaymentScreen';
  static const String stripePaymentScreen = '/stripePaymentScreen';
  static const String flutterWavePaymentScreen = '/flutterWavePaymentScreen';
  static const String payStackPaymentScreen = '/payStackPaymentScreen';
  static const String molliPaymentScreen = '/molliPaymentScreen';
  static const String instamojoPaymentScreen = '/instamojoPaymentScreen';
  static const String razorpayPaymentScreen = '/razorpayPaymentScreen';
  static const String paypalPaymentScreen = '/paypalPaymentScreen';

  static const String supportScreen = '/supportScreen';
  static const String singleSupportScreen = '/singleSupportScreen';
  static const String kycScreen = '/kycScreen';
  static const String createBookingScreen = '/createBookingScreen';
  static const String myBookingScreen = '/myBookingScreen';
  static const String bookingReqScreen = '/bookingReqScreen';
  static const String compareScreen = '/compareScreen';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteNames.signUpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SingUpScreen());

      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());

      case RouteNames.verificationScreen:
        final isVerification = settings.arguments ;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VerificationScreen(phoneNumber: isVerification.toString()));

      case RouteNames.updatePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UpdatePasswordScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  HomeScreen(onTap: (i ) {  },));

      case RouteNames.mainPageScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainPageScreen());

      case RouteNames.allCategoryScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryScreen());

      case RouteNames.allPropertyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllPropertyListScreen());

      case RouteNames.urgentPropertyScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const UrgentPropertyListScreen());

      case RouteNames.allRecommendedPropertyScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AllRecommendedProperties());
      case RouteNames.allBrokerAgentListScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AllBrokerAgentListScreen());

      case RouteNames.agentProfileScreen:
        String userName = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AgentProfileScreen(userName: userName));

      case RouteNames.sendMessageScreen:
        String agentEmail = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SendMessageScreen(agentEmail: agentEmail));

      case RouteNames.profileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());

      case RouteNames.updateProfileScreen:
        final profile = settings.arguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UpdateProfileScreen(profile: profile));

      case RouteNames.propertyDetailsScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PropertyDetailScreen(slug: slug));

      case RouteNames.myDealsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyDealsScreen());

      case RouteNames.rentScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  RentScreen());

      case RouteNames.savedScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SavedScreen());

      // case RouteNames.addNewPropertyScreen:
      //   final slug = settings.arguments as String;
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (_) => AddNewPropertyScreen(purpose: slug));

      //case RouteNames.updateScreen:
      //   final id = settings.arguments as String;
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => UpdateScreen(id: id));

      case RouteNames.newPropertyCreateScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => NewPropertyCreateScreen(id: id));

        case RouteNames.addPropertyScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AddPropertyScreen());

      case RouteNames.choosePropertyOptionScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ChoosePropertyOptionScreen());
      case RouteNames.supportScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SupportScreen());
      case RouteNames.singleSupportScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SingleSupportScreen(applicantId: id));

      case RouteNames.reviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ReviewScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutUsScreen());

      case RouteNames.paymentMethodScreen:
        final planSlug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PaymentMethodScreen(planSlug: planSlug));

      case RouteNames.bankPaymentScreen:
        final String planSlug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => BankPaymentScreen(planSlug: planSlug));

      case RouteNames.stripePaymentScreen:
        final String planSlug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => StripePaymentScreen(planSlug: planSlug));

      case RouteNames.flutterWavePaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => FlutterWaveScreen(url: url));

      case RouteNames.molliPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => MolliPaymentScreen(url: url));

      case RouteNames.instamojoPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => InstamojoPaymentScreen(url: url));

      case RouteNames.razorpayPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => RazorpayPaymentScreen(url: url));

      case RouteNames.paypalPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => PaypalPaymentScreen(url: url));

      case RouteNames.payStackPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PayStackPaymentScreen(url: url));

      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());

      case RouteNames.termsAndConditionScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TermsAndConditionScreen());

      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());

      case RouteNames.premiumMembershipScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const PremiumMembershipScreen());

      case RouteNames.contactUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsScreen());
      case RouteNames.purchaseScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PurchaseScreen());
      case RouteNames.purchaseDetailsScreen:
        final dynamic  properties = settings.arguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PurchaseDetailScreen(propertiesDetails: properties));

      case RouteNames.searchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SearchScreen());

      case RouteNames.filterPropertyScreen:
        final type = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => FilterPropertyScreen(type: type));

      case RouteNames.kycScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const KycScreen());
      case RouteNames.createBookingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CreateBookingScreen());
      case RouteNames.myBookingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyBookingScreen());
      case RouteNames.bookingReqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BookingReqScreen());
      case RouteNames.compareScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CompareScreen());


    /// company
      case RouteNames.createCompanyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CreateCompanyScreen());

      case RouteNames.updateCompanyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UpdateCompanyScreen());

      case RouteNames.companyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CompanyScreen());

      case RouteNames.createAgentScreen:
        String id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) =>  CreateAgentScreen(id: id,));
      //
      // case RouteNames.agencyDetailsScreen:
      //   final id = settings.arguments as String;
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) =>  AgencyProfileScreen(id: id,));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
