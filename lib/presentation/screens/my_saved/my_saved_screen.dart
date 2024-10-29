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

class MySavedScreen extends StatefulWidget {
  final TabController? tabController;
  const MySavedScreen({super.key,  this.tabController});

  @override
  State<MySavedScreen> createState() => _MySavedScreenState();
}

class _MySavedScreenState extends State<MySavedScreen>{

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
      appBar: const CustomAppBar(title: 'My Wishlist', showButton: false),
      body: PageRefresh(
        onRefresh: () async => wishlistCubit.getWishListProperties(),
        child: Utils.logoutListener(
            child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is WishListError) {
              if (state.statusCode == 401) {
                // print('callesssssss logoutFunction');
                // context.read<LoginBloc>().add(const LoginEventLogout());
                Utils.logout(context);
              }
            }
          },
          builder: (context, state) {
            // final wishlist = state.wishlistState;

            return Column(
              children: [
                 Row(
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
                          ImageIcon(AssetImage("assets/Yash/images/settings_filter.png",),size: 15,)
                        ],
                      ),
                    )
                  ],
                ),
                TabBarView(
                    controller: widget.tabController,
                    children: const [
                      Column(
                        children: [
                          Center(
                            child: Text("Residential Property"),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Center(
                            child: Text("Commercial Property"),
                          )
                        ],
                      )
                    ]),
              ],
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
