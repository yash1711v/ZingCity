import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/widget/primary_button.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../data/model/product/property_item_model.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import '../home/component/single_property_card_view.dart';

class RentScreen extends StatefulWidget {
  final TabController? tabController;
  const RentScreen({super.key,  this.tabController});

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen>{

  @override
  void initState() {

    Future.microtask(
        () => context.read<WishlistCubit>().getWishListProperties());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wishlistCubit = context.read<WishlistCubit>();
    // wishlistCubit.getWishListProperties();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: PageRefresh(
        onRefresh: () async => wishlistCubit.getWishListProperties(),
        child: Utils.logoutListener(
            child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            // final wishlist = state.wishlistState;

            return SingleChildScrollView(
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
                        Container(
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
                        )
                      ],
                                       ),
                   ),
                  SizedBox(
                    height: size.height * 5,
                    width: size.width,
                    child: TabBarView(
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
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
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
                                                const SizedBox(height: 8,),
                                                const Text(
                                                  'Modern Green',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
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
                            
                                              ],
                                                                                 ),
                                           )
                                        ],
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
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
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
                                                    const SizedBox(height: 8,),
                                                    const Text(
                                                      'Modern Green',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
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

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            );
            // return const Center(
            //     child: CustomTextStyle(text: 'Something went wrong'));
          },
          // buildWhen: (previous, current) {
          //   print('pre $previous');
          //   print('cur $current');
          //   return previous != current;
          // },
        )),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: Padding(
        padding: Utils.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteNames.loginScreen,
                    (route) => false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class WishlistLoadedWidget extends StatelessWidget {
  const WishlistLoadedWidget({super.key, required this.wishlist});

  final List<PropertyItemModel> wishlist;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (wishlist.isEmpty) {
      return Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: const EmptyWidget(
          icon: KImages.emptySavedIcon,
          title: 'No Item Found!',
        ),
      );
    } else {
      return ListView.builder(
        itemCount: wishlist.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0)
            .copyWith(bottom: 40.0),
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteNames.propertyDetailsScreen,
                arguments: item.slug),
            child: SinglePropertyCardView(
              property: item,
            ),
          );
        },
      );
    }
  }
}
