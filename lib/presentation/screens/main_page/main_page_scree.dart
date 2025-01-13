import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/logic/cubit/order/order_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/utils/utils.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../logic/cubit/about_us/about_us_cubit.dart';
import '../../../logic/cubit/agent/agent_cubit.dart';
import '../../../logic/cubit/booking/booking_cubit.dart';
import '../../../logic/cubit/contact_us/contact_us_cubit.dart';
import '../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../logic/cubit/filter_property/filter_property_cubit.dart';
import '../../../logic/cubit/home/cubit/home_cubit.dart';
import '../../../logic/cubit/kyc/kyc_cubit.dart';
import '../../../logic/cubit/payment/price_plan/price_plan_cubit.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../../logic/cubit/support/support_cubit.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/custom_theme.dart';
import '../all_settings/all_settings_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../home/component/search_field.dart';
import '../home/home_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../rent_screen/rent_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'component/main_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with TickerProviderStateMixin {
  final _homeController = MainController();
  late TabController _tabController;
  late List<Widget> screenList;
  final controller = MainController();

  Future<void> _setInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, you may want to handle this
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {

     debugPrint("lat ${position.latitude.toString()} long ${position.longitude.toString()}");

        context.read<HomeCubit>().getHomeData(
              lat: position.latitude.toString(),
              long: position.longitude.toString(),
            );
      }
    } catch (e) {
      if (mounted) {
        // Handle the error or display a message
        print('Error: $e');
      }
    }

    // setState(() {
    //   _currentPosition = LatLng(position.latitude, position.longitude);
    // });
    // _getAddressFromLatLng(_currentPosition!);
    // // Move the camera to the current location
    // if (_controller != null) {
    //   _controller!.animateCamera(
    //     CameraUpdate.newLatLng(_currentPosition!),
    //   );
    // }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      // setState(() {
      //   _address = "${place.street}, ${place.locality}, ${place.country}";
      // });
      // context.read<AddressCubit>().addressController.clear();
      // context.read<AddressCubit>().cityController.clear();
      // context.read<AddressCubit>().stateController.clear();
      // context.read<AddressCubit>().pincodeController.clear();
      // context.read<AddressCubit>().addressController.text = _address;
      // context.read<AddressCubit>().cityController.text = place.locality!;
      // context.read<AddressCubit>().stateController.text = place.administrativeArea!;
      // context.read<AddressCubit>().pincodeController.text = place.postalCode!;
      // context.read<AddressCubit>().lat = position.latitude.toString();
      // context.read<AddressCubit>().long = position.longitude.toString();
      // context.read<HomeServiceCubit>().onAddressChange("${place.street}");
      // context.read<HomeServiceCubit>().onAreaChange(place.locality!);
      // context.read<HomeServiceCubit>().onPinCodeChange(place.postalCode!);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
    _tabController = TabController(length: 2, vsync: this);
    screenList = [
      HomeScreen(
        onTap: (i) {},
      ),
      //const MyDealsScreen(),
      RentScreen(
        tabController: _tabController,
      ),
      BuyScreen(
        tabController: _tabController,
      ),
      const SavedScreen(),
      // const OrderScreen(),
      // Container(),
    ];

    // context.read<PrivacyPolicyCubit>().getFaqContent();
    // context.read<PrivacyPolicyCubit>().getTermsAndCondition();
    // context.read<PrivacyPolicyCubit>().getPrivacyPolicy();
    // context.read<WishlistCubit>().getWishListProperties();
    // context.read<ContactUsCubit>().getContactUs();
    // context.read<AboutUsCubit>().getAboutUs();
    // context.read<AgentCubit>().getAllAgent();
    // context.read<PricePlanCubit>().getPricePlan();
    // context.read<FilterPropertyCubit>().getAllProperty();
    // context.read<CreateInfoCubit>().getPropertyChooseInfo();
    // context.read<ProfileCubit>().getAgentProfile();
    // context.read<ProfileCubit>().getAgentDashboardInfo();
    // context.read<CreateInfoCubit>().getCreateInfo('rent');
    // context.read<SupportCubit>().getPriorityList();
    // context.read<KycCubit>().getKycInfo();
    // context.read<BookingCubit>().getCompareList();
    // context.read<CompanyCubit>().getAgencyKyc();
    // context.read<CompanyCubit>().getCompanyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitApp(context);
        return true;
      },
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
            preferredSize: const Size(360, 300),
            child: StreamBuilder<int>(
                initialData: 0,
                stream: _homeController.naveListener.stream,
                builder: (context, snapshot) {
                  int item = snapshot.data ?? 0;
                  if (item == 2) {
                    _tabController = TabController(length: 4, vsync: this);
                  } else {
                    _tabController = TabController(length: 2, vsync: this);
                  }
                  screenList = [
                    HomeScreen(
                      onTap: (i) {
                        controller.naveListener.sink.add(i);
                      },
                    ),
                    //const MyDealsScreen(),
                    RentScreen(
                      tabController: _tabController,
                    ),
                    BuyScreen(
                      tabController: _tabController,
                    ),
                    const SavedScreen(),
                    // const OrderScreen(),
                    // Container(),
                  ];
                  return Container(
                    width: 360,
                    height: item == 0 || item == 3 ? 200 : 240,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE7EBF4),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1E000000),
                          blurRadius: 8,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 16, right: 16),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/Yash/images/ZingCityLogo.png",
                                width: 50.03,
                                height: 35.01,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.addPropertyScreen);
                                },
                                child: Container(
                                  width: 155,
                                  height: 30.90,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF30469A),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            "assets/Yash/images/post_ad_button.png"),
                                        const SizedBox(width: 5.0),
                                        const Text(
                                          'Post Property',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.profileScreen);
                                },
                                child: Container(
                                  width: 31,
                                  height: 31,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: const Color(0x3330469A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Color(0xFF30469A),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.searchScreen);
                            },
                            decoration: const InputDecoration(
                              fillColor: Color(0xFFF5F5F5),
                              hintText: 'Search',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: item == 1,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicatorWeight: 3,
                            controller: _tabController,
                            unselectedLabelColor: Colors.grey,
                            labelColor: const Color(0xFF30469A),
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Residential',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Commercial',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: item == 2,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            labelPadding: EdgeInsets.zero,
                            indicatorWeight: 4,
                            controller: _tabController,
                            unselectedLabelColor: Colors.grey,
                            labelColor: const Color(0xFF30469A),
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Residential',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Commercial',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Agricultar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'Plot/Land',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })),
        body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int item = snapshot.data ?? 0;
            return screenList[item];
          },
        ),
        // bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        //   builder: (context, state) {
        //     if (state is HomeDataLoaded) {
        //       return const Padding(
        //         padding: EdgeInsets.only(bottom: 13.0, left: 18, right: 18),
        //         child: MyBottomNavigationBar(),
        //       );
        //     } else {
        //       return const SizedBox.shrink();
        //     }
        //   },
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: const MyBottomNavigationBar(),
        ),
      ),
    );
  }

  exitApp(BuildContext context) async {
    Utils.showCustomDialog(
      context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomImage(path: KImages.logoutIcon),
            const SizedBox(height: 10.0),
            const CustomTextStyle(
              textAlign: TextAlign.center,
              text: 'Are you sure\nYou want to Exit?',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logoutButton(
                    'No', () => Navigator.of(context).pop(), blackColor),
                const SizedBox(width: 14.0),
                logoutButton('Exit', () => SystemNavigator.pop(), primaryColor),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget logoutButton(String text, VoidCallback onPressed, Color bgColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100.0, 40.0)),
          backgroundColor: MaterialStateProperty.all(bgColor),
          elevation: MaterialStateProperty.all(0.0),
          shadowColor: MaterialStateProperty.all(transparent),
          splashFactory: NoSplash.splashFactory,
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius))),
      child: CustomTextStyle(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        color: whiteColor,
      ),
    );
  }
}
