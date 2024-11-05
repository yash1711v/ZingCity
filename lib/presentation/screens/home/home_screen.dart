import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import 'package:real_estate/presentation/widget/fetch_text_error.dart';

import '../../../data/data_provider/remote_url.dart';
import '/logic/cubit/home/cubit/home_cubit.dart';
import '/logic/cubit/profile/profile_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/loading_widget.dart';
import '/presentation/widget/page_refresh.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import 'component/fun_fact_section.dart';
import 'component/headline_text.dart';
import 'component/home_app_bar.dart';
import 'component/horizontal_category_view.dart';
import 'component/horizontal_property_view.dart';
import 'component/property_agents_view.dart';
import 'component/search_field.dart';
import 'component/single_property_card_view.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onTap;
  const HomeScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      //appBar: const HomeAppBar(),
      body: PageRefresh(
        onRefresh: () async => homeCubit.getHomeData(),
        child: Utils.logoutListener(
          child: BlocListener<ProfileCubit, ProfileStateModel>(
            listener: (context, state) {
              final profile = state.profileState;
              if (profile is ProfileUpdateLoaded) {
                Utils.showSnackBar(context, profile.message);
                context.read<ProfileCubit>().getAgentProfile();
              }
              if (profile is ProfileError) {
                if (profile.statusCode == 401) {
                  // debugPrint('profile-error ${profile.message}');
                  Utils.logout(context);
                }
              }
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const LoadingWidget();
                }
                if (state is HomeErrorState) {
                  return FetchErrorText(text: state.error);
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/Yash/images/headerImage.png'),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 163.42,
                                    child: Text(
                                      'Explore The Right Fit Property For You',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Buy or rent from the best!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 83.64,
                                    height: 30,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF30469A),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 8,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Verify',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  onTap(1);
                                },
                                child: Container(
                                  height: 143.60,
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.47, -0.88),
                                      end: Alignment(-0.47, 0.88),
                                      colors: [
                                        Color(0xFF336C7E),
                                        Color(0xFF52AECB),
                                        Color(0xFF5DC3E4)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Buy Property',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'EXPLORE',
                                        style: TextStyle(
                                          color: Color(0xFF30469A),
                                          fontSize: 12,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Image.asset(
                                        "assets/Yash/images/buy_property_Icons.png",
                                        height: 75.63,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  onTap(2);
                                },
                                child: Container(
                                  width: 153,
                                  height: 143.60,
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.49, -0.87),
                                      end: Alignment(-0.49, 0.87),
                                      colors: [
                                        Color(0xFF506622),
                                        Color(0xFF87AB3A),
                                        Color(0xFFA1CC45)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Rent Property',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'EXPLORE',
                                        style: TextStyle(
                                          color: Color(0xFF30469A),
                                          fontSize: 12,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        "assets/Yash/images/handImage.png",
                                        height: 88.45,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: HorizontalCategoryView(
                            category: homeCubit
                                .homeModel!.featuredProperty!.properties),
                      ),
                      const SizedBox(height: 25),
                      HeadlineText(
                        text: 'Properties Near You',
                        onTap: () {},
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0,left: 16,bottom: 25,top: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                  },
                                  child: Container(
                                    width: 370,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 5,
                                            blurRadius: 3,
                                            offset: const Offset(0, 1)
                                        )
                                      ]
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 500,
                                          height: 174.69,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/Yash/images/properties_near_${index + 1}.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Modern Green',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.location_on_sharp,
                                                size: 10,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'A7, 180C, Mayur Vihar, New Delhi',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(
                                                          0.699999988079071),
                                                  fontSize: 10,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                              const Spacer(),
                                              const Text(
                                                '₹ 80 Lac',
                                                style: TextStyle(
                                                  color: Color(0xFF30469A),
                                                  fontSize: 16,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w800,
                                                  height: 0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                     Container(
                       color: Color(0x1b398bcb),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
                         child: Column(
                           children: [
                             HeadlineText(
                               text: 'Search by Price',
                               onTap: () {},
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Container(
                                   width: 89.01,
                                   height: 35,
                                   decoration: ShapeDecoration(
                                     color: Colors.white,
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                   ),
                                   child: const Center(
                                     child: Text(
                                       '50-90 Lac',
                                       style: TextStyle(
                                         color: Color(0xFF30469A),
                                         fontSize: 12,
                                         fontFamily: 'DM Sans',
                                         fontWeight: FontWeight.w400,
                                         height: 0,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 10),
                                 Container(
                                   width: 89.01,
                                   height: 35,
                                   decoration: ShapeDecoration(
                                     color: Colors.white.withOpacity(0.3),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                   ),
                                   child: const Center(
                                     child: Text(
                                       '1-3 Cr',
                                       style: TextStyle(
                                         color: Color(0xFF30469A),
                                         fontSize: 12,
                                         fontFamily: 'DM Sans',
                                         fontWeight: FontWeight.w400,
                                         height: 0,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 10),
                                 Container(
                                   width: 89.01,
                                   height: 35,
                                   decoration: ShapeDecoration(
                                     color: Colors.white.withOpacity(0.3),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                   ),
                                   child: const Center(
                                     child: Text(
                                       '4-8 Cr',
                                       style: TextStyle(
                                         color: Color(0xFF30469A),
                                         fontSize: 12,
                                         fontFamily: 'DM Sans',
                                         fontWeight: FontWeight.w400,
                                         height: 0,
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 10),
                             SizedBox(
                               width: 500,
                               height: 400.6,
                               child: GridView.builder(
                                 physics: const NeverScrollableScrollPhysics(),
                                 shrinkWrap: true,
                                 itemCount: 4,
                                 // 2 rows * 2 elements in each row
                                 gridDelegate:
                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 2,
                                   crossAxisSpacing: 8.0,
                                   mainAxisSpacing: 8.0,
                                   childAspectRatio:
                                   1.1, // Aspect ratio based on width and height of the container
                                 ),
                                 itemBuilder: (context, index) {
                                   return GestureDetector(
                                     onTap: (){
                                       Navigator.pushNamed(
                                           context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                     },
                                     child: Container(
                                       width: 157,
                                       padding: const EdgeInsets.only(bottom: 4.46),
                                       decoration: ShapeDecoration(
                                         color: Colors.white,
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                       ),
                                       child: Column(
                                         children: [
                                           Container(
                                             width: 300,
                                             height: 100.57,
                                             decoration: ShapeDecoration(
                                               image: const DecorationImage(
                                                 image: AssetImage(
                                                     "assets/Yash/images/properties_near_1.png"),
                                                 fit: BoxFit.cover,
                                               ),
                                               shape: RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius.circular(5)),
                                             ),
                                           ),
                                           const SizedBox(
                                             height: 5,
                                           ),
                                           const Padding(
                                             padding: EdgeInsets.symmetric(
                                                 horizontal: 10.0),
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               children: [
                                                 Text(
                                                   'Modern Green',
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 12,
                                                     fontFamily: 'DM Sans',
                                                     fontWeight: FontWeight.w700,
                                                     height: 0,
                                                   ),
                                                 )
                                               ],
                                             ),
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.symmetric(
                                                 horizontal: 10.0),
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               children: [
                                                 const Icon(
                                                   Icons.location_on_sharp,
                                                   size: 10,
                                                   color: Colors.grey,
                                                 ),
                                                 const SizedBox(
                                                   width: 2,
                                                 ),
                                                 Padding(
                                                   padding:
                                                   const EdgeInsets.only(top: 6.0),
                                                   child: SizedBox(
                                                     width: 141,
                                                     child: Text(
                                                       'A7, 180C, Mayur Vihar, New Delhi',
                                                       style: TextStyle(
                                                         color: Colors.black
                                                             .withOpacity(
                                                             0.699999988079071),
                                                         fontSize: 10,
                                                         fontFamily: 'DM Sans',
                                                         fontWeight: FontWeight.w400,
                                                         height: 0,
                                                       ),
                                                     ),
                                                   ),
                                                 )
                                               ],
                                             ),
                                           ),
                                           const Padding(
                                             padding: EdgeInsets.only(left: 8.0),
                                             child: Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment.start,
                                               children: [
                                                 Text(
                                                   '₹ 80 Lac',
                                                   style: TextStyle(
                                                     color: Color(0xFF30469A),
                                                     fontSize: 14,
                                                     fontFamily: 'DM Sans',
                                                     fontWeight: FontWeight.w800,
                                                     height: 0,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),

                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            HeadlineText(
                              text: 'Newly Added',
                              onTap: () {},
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  shrinkWrap: true,
                                  itemCount: homeCubit.homeModel!.latestProperty!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10.0,bottom: 14),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(
                                              context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                        },
                                        child: Container(
                                          width: 324,
                                          height: 78.93,
                                          decoration: ShapeDecoration(
                                            color: const Color(0x0C398BCB),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 78.93,
                                                height: 78.93,
                                                decoration: ShapeDecoration(
                                                  image:
                                                       DecorationImage(
                                                    image: NetworkImage(
                                                      "${RemoteUrls.rootUrl}${homeCubit
                                                          .homeModel!
                                                          .latestProperty![index]
                                                          .thumbnailImage}"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Modern Green',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_sharp,
                                                          size: 10,
                                                        ),
                                                        Text(
                                                          'A7, 180C, Mayur Vihar, New Delhi',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                            height: 0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/iconamoon_profile-light.png",
                                                          height: 10,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const Text(
                                                          'Villa',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                            height: 0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
