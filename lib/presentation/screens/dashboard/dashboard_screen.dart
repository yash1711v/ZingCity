import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/bottomSheet.dart';
import '../../widget/custom_app_bar.dart';

class BuyScreen extends StatefulWidget {
  final TabController? tabController;
  const BuyScreen({super.key, this.tabController});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  late LoginBloc loginBloc;
  late CompanyCubit cCubit;

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    cCubit = context.read<CompanyCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return   Scaffold(
      backgroundColor: scaffoldBackground,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    '14 results found',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        isDismissible: false,
                        constraints:  BoxConstraints(
                          minWidth:  MediaQuery.of(context).size.height * 0.8,
                        ),
                        context: context,
                        builder: (context) {
                          return const CustomBottomSheet();
                        },
                      );
                    },
                    child: Container(
                      width: 75.31,
                      height: 25.82,
                      decoration: ShapeDecoration(
                        color: const Color(0x1930469A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              color: Color(0xFF30469A),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                          SizedBox(width: 10,),
                          ImageIcon(AssetImage("assets/Yash/images/settings_filter.png",),size: 15,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 5,
              width: size.width,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                  controller: widget.tabController,
                  children:  [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 60,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 94.83,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 94.83,
                                            height: 94.83,
                                            decoration: ShapeDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage("assets/Yash/images/property_1.png"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 13,),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/iconamoon_profile-light.png",
                                                      height: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Villa',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    SizedBox(width: size.width - 250,),
                                                    const Text(
                                                      '₹ 80 Lac',
                                                      style: TextStyle(
                                                        color: Color(0xFF30469A),
                                                        fontSize: 14,
                                                        fontFamily: 'DM Sans',
                                                        fontWeight: FontWeight.w800,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3,),
                                                const Text(
                                                  'Modern Green',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    Text(
                                                      'A7, 180C, Mayur Vihar, New Delhi',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
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
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 60,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 94.83,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 94.83,
                                            height: 94.83,
                                            decoration: ShapeDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage("assets/Yash/images/property_1.png"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 13,),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/iconamoon_profile-light.png",
                                                      height: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Villa',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    SizedBox(width: size.width - 250,),
                                                    const Text(
                                                      '₹ 80 Lac',
                                                      style: TextStyle(
                                                        color: Color(0xFF30469A),
                                                        fontSize: 14,
                                                        fontFamily: 'DM Sans',
                                                        fontWeight: FontWeight.w800,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3,),
                                                const Text(
                                                  'Modern Green',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    Text(
                                                      'A7, 180C, Mayur Vihar, New Delhi',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
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
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 60,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(
                                        context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 94.83,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 94.83,
                                            height: 94.83,
                                            decoration: ShapeDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage("assets/Yash/images/property_1.png"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 13,),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/iconamoon_profile-light.png",
                                                      height: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Villa',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    SizedBox(width: size.width - 250,),
                                                    const Text(
                                                      '₹ 80 Lac',
                                                      style: TextStyle(
                                                        color: Color(0xFF30469A),
                                                        fontSize: 14,
                                                        fontFamily: 'DM Sans',
                                                        fontWeight: FontWeight.w800,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3,),
                                                const Text(
                                                  'Modern Green',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    Text(
                                                      'A7, 180C, Mayur Vihar, New Delhi',
                                                      style: TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontSize: 14,
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
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ]),
            ),
        ],),
      ),
    );
  }
}

class DashboardComponents extends StatelessWidget {
  const DashboardComponents({
    super.key, required this.title, required this.icon, required this.onTap,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
        color: whiteColor
        ),
        child: Padding(
          padding: Utils.symmetric(h: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: const Color(0xFFF5F4FF),
                ),
                child: Padding(
                  padding:Utils.all(value: 10.0),
                  child:  CustomImage(path: icon,),
                ),
              ),
              const SizedBox(width: 20.0,),
               CustomTextStyle(text: title,fontSize: 16,fontWeight: FontWeight.w400,),

            ],),
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F4FF),
              ),
              child: Padding(
                padding: Utils.all(value: 8.0),
                child: const Center(child: CustomImage(path: KImages.arrowIcon,)),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
