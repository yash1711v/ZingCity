import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/auth/user_login_response_model.dart';
import 'package:real_estate/data/model/auth/user_profile_model.dart';
import 'package:real_estate/logic/bloc/General/general_cubit.dart';
import 'package:real_estate/logic/cubit/order/order_cubit.dart';
import 'package:real_estate/presentation/screens/support/contact_us.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../../logic/repository/auth_repository.dart';
import '../../widget/custom_theme.dart';
import '../EnquireScreens/enquires.dart';
import '../home/component/agent_search.dart';
import '../my_property/my_property.dart';
import '/presentation/utils/utils.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/model/agent/agent_profile_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../router/route_names.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import 'component/person_information.dart';
import 'component/person_single_property.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<ProfileCubit>().getAgentProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(360, 300),
          child: Container(
            width: 360,
            height: 240,
            decoration: BoxDecoration(
              color: Color(0xFFE7EBF4),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 16, right: 16),
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
                          // width: 95.65,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: Color(0xFF30469A),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileCubit, ProfileStateModel>(
                  builder: (context, state) {
                    log(
                        (state.user ??
                                    UserModel())
                                . name??
                            "",
                        name: "Name");
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                debugPrint("Edit Profile");
                                Navigator.pushReplacementNamed(
                                    context, RouteNames.updateProfileScreen,arguments: state.user);
                              },
                              child: Container(
                                // width: 324,
                                height: 75.49,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint("Edit Profile");
                                      Navigator.pushReplacementNamed(
                                          context, RouteNames.updateProfileScreen,arguments: state.user);
                                    },
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            debugPrint("Edit Profile");
                                            Navigator.pushReplacementNamed(
                                                context, RouteNames.updateProfileScreen,arguments: state.user);
                                          },
                                          child:  Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(RemoteUrls.rootUrl+"/${state.user?.image ?? ""}"),
                                              ),
                                              Positioned(
                                                  top: 35,
                                                  left: 38,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, left: 10.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Edit Profile',
                                                  style: TextStyle(
                                                    color: Color(0xFF398BCB),
                                                    fontSize: 12,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w300,
                                                    height: 0,
                                                  ),
                                                ),
                                                Text(
                                                  '${state.user?.phone ?? ""}',
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(
                                                            0.699999988079071),
                                                    fontSize: 14,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w300,
                                                    height: 0,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: scaffoldBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProperty()));
                  },
                  child: Text(
                    'Your Properties',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.699999988079071),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: (){
                    Repository repo = Repository();
                    repo.getEnquiryRequests().then((value){
                      print(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EnquiryScreen(properties: value, isRequest: true,)),
                      );
                    });
                  },
                  child: Text(
                    'Enquiry Requests',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.699999988079071),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Repository repo = Repository();
                    repo.getUserEnquires().then((value){
                      print(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EnquiryScreen(properties: value, isRequest: false,)),
                      );
                    });
                  },
                  child: Text(
                    'Your Enquires',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.699999988079071),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.699999988079071),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                              Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<PrivacyPolicyCubit>().getPrivacyPolicy();
                    Navigator.pushNamed(
                      context,
                      RouteNames.privacyPolicyScreen,
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.699999988079071),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.read<PrivacyPolicyCubit>().getTermsAndCondition();
                    Navigator.pushNamed(
                      context,
                      RouteNames.termsAndConditionScreen,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.699999988079071),
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 324,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color:
                                  Colors.black.withOpacity(0.10000000149011612),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class ProfileLoadedWidget extends StatelessWidget {
  const ProfileLoadedWidget({super.key, required this.properties});

  final AgentProfileModel properties;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // if (properties.properties == null) {
    //   print('null');
    // } else {
    //   print('not null');
    // }
    return ListView(
      clipBehavior: Clip.none,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        PersonInformation(properties: properties),
        SizedBox(height: size.height * 0.04),
        Padding(
          padding: Utils.symmetric(h: 8.0),
          //  child: const AgentSearch(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CustomTextStyle(
                text: 'My Property List',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ],
          ),
        ),
        if (properties.properties != null) ...[
          PersonSingleProperty(properties: properties.properties!.data!),
        ],
        SizedBox(height: size.height * 0.07),
      ],
    );
  }
}
