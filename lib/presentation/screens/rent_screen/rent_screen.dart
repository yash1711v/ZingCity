import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/home/cubit/home_cubit.dart';
import 'package:real_estate/presentation/widget/primary_button.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../data/model/product/property_item_model.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/bottomSheet.dart';
import '../../widget/customnetwork_widget.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import '../home/component/single_property_card_view.dart';

class RentScreen extends StatefulWidget {
  final TabController? tabController;

  const RentScreen({super.key, this.tabController});

  @override
  State<RentScreen> createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  @override
  void initState() {
    // Future.microtask(
    //     () => context.read<WishlistCubit>().getWishListProperties());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final wishlistCubit = context.read<WishlistCubit>();
    // wishlistCubit.getWishListProperties();

    String removeHtmlTags(String htmlText) {
      final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
      return htmlText.replaceAll(exp, '');
    }
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: PageRefresh(
          onRefresh: () async => null,
          //wishlistCubit.getWishListProperties(),

          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                         Text(
                          '${(state.searchedProperties ?? []).isNotEmpty?(state.searchedProperties ?? []).length:(state.data ?? []).length ?? 0} results found ${(state.searchedProperties ?? []).isNotEmpty?"from Search":""}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.height * 0.8,
                              ),
                              context: context,
                              builder: (context) {
                                return CustomBottomSheet(isRent: true, typeOfProperty: widget.tabController?.index == 0?"Residential":"Commercial",);
                              },
                            );
                          },
                          child: Container(
                            width: 75.31,
                            height: 25.82,
                            decoration: ShapeDecoration(
                              color: const Color(0x1930469A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
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
                                SizedBox(
                                  width: 10,
                                ),
                                ImageIcon(
                                  AssetImage(
                                    "assets/Yash/images/settings_filter.png",
                                  ),
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics() ,
                        controller: widget.tabController,
                        children: [
                        //   Visibility(
                        //  visible: (state.isLoading ?? true),
                        // child: CircularProgressIndicator()),
                        (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):
                        (state.searchedProperties ?? []).isNotEmpty?ListView.builder(
                            itemCount: (state.searchedProperties ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {
                              debugPrint((state.data ?? [])[index].title);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context,
                                      RouteNames
                                          .purchaseDetailsScreen,
                                      arguments: (state.data ?? [])[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0),
                                  child: Container(
                                    width: size.width,
                                    height: 85,
                                    decoration: ShapeDecoration(
                                      color: const Color(0x0C398BCB),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                  
                                        CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                        ),
                                        // Container(
                                        //   width: 94.83,
                                        //   height: 94.83,
                                        //   decoration: ShapeDecoration(
                                        //     image:
                                        //         const DecorationImage(
                                        //       image: AssetImage(
                                        //           "assets/Yash/images/property_1.png"),
                                        //       fit: BoxFit.fill,
                                        //     ),
                                        //     shape:
                                        //         RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius
                                        //               .circular(10),
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              const SizedBox(
                                                height: 13,
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Image.asset(
                                              //       "assets/images/iconamoon_profile-light.png",
                                              //       height: 12,
                                              //     ),
                                              //     const SizedBox(
                                              //       width: 5,
                                              //     ),
                                              //     const Text(
                                              //       'Villa',
                                              //       style: TextStyle(
                                              //         color: Colors
                                              //             .black,
                                              //         fontSize: 14,
                                              //         fontFamily:
                                              //             'DM Sans',
                                              //         fontWeight:
                                              //             FontWeight
                                              //                 .w300,
                                              //         height: 0,
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //       width:
                                              //           size.width -
                                              //               250,
                                              //     ),
                                              //     const Text(
                                              //       '₹ 80 Lac',
                                              //       style: TextStyle(
                                              //         color: Color(
                                              //             0xFF30469A),
                                              //         fontSize: 14,
                                              //         fontFamily:
                                              //             'DM Sans',
                                              //         fontWeight:
                                              //             FontWeight
                                              //                 .w800,
                                              //         height: 0,
                                              //       ),
                                              //     ),
                                              //     const SizedBox(
                                              //       width: 5,
                                              //     ),
                                              //   ],
                                              // ),
                                              // const SizedBox(
                                              //   height: 3,
                                              // ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width - 300,
                                                child: Text(
                                                  (state.searchedProperties ?? [])[index].title ?? "",
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                      'DM Sans',
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      height: 0,
                                                      overflow: TextOverflow.ellipsis
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                  
                                                  const Icon(
                                                    Icons
                                                        .location_on_sharp,
                                                    size: 12,
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width - 180,
                                                    child: Text(
                                                      removeHtmlTags((state.searchedProperties ?? [])[index].address ?? ""),
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        color: Colors
                                                            .black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                        height: 0,
                                                      ),
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
                            }): ListView.builder(
                              itemCount: (state.data ?? []).length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                debugPrint((state.data ?? [])[index].title);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        RouteNames
                                            .purchaseDetailsScreen,
                                        arguments: (state.data ?? [])[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 85,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                  
                                          CustomNetworkImageWidget(
                                         width: 94.83,
                                           height: 94.83,
                                            image:
                                            "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                          ),
                                          // Container(
                                          //   width: 94.83,
                                          //   height: 94.83,
                                          //   decoration: ShapeDecoration(
                                          //     image:
                                          //         const DecorationImage(
                                          //       image: AssetImage(
                                          //           "assets/Yash/images/property_1.png"),
                                          //       fit: BoxFit.fill,
                                          //     ),
                                          //     shape:
                                          //         RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius
                                          //               .circular(10),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(
                                                    top: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Image.asset(
                                                //       "assets/images/iconamoon_profile-light.png",
                                                //       height: 12,
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //     const Text(
                                                //       'Villa',
                                                //       style: TextStyle(
                                                //         color: Colors
                                                //             .black,
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w300,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width:
                                                //           size.width -
                                                //               250,
                                                //     ),
                                                //     const Text(
                                                //       '₹ 80 Lac',
                                                //       style: TextStyle(
                                                //         color: Color(
                                                //             0xFF30469A),
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w800,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 3,
                                                // ),
                                                 SizedBox(
                                                   width: MediaQuery.of(context).size.width - 300,
                                                   child: Text(
                                                    (state.data ?? [])[index].title ?? "",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      height: 0,
                                                      overflow: TextOverflow.ellipsis
                                                    ),
                                                                                                           ),
                                                 ),
                                                 Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                  
                                                    const Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width - 180,
                                                      child: Text(
                                                        removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'DM Sans',
                                                          fontWeight:
                                                              FontWeight
                                                                  .w300,
                                                          height: 0,
                                                        ),
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
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):(state.searchedProperties ?? []).isNotEmpty?ListView.builder(
                              itemCount: (state.searchedProperties ?? []).length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                debugPrint((state.data ?? [])[index].title);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        RouteNames
                                            .purchaseDetailsScreen,
                                        arguments: (state.data ?? [])[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 85,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                  
                                          CustomNetworkImageWidget(
                                            width: 94.83,
                                            height: 94.83,
                                            image:
                                            "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                          ),
                                          // Container(
                                          //   width: 94.83,
                                          //   height: 94.83,
                                          //   decoration: ShapeDecoration(
                                          //     image:
                                          //         const DecorationImage(
                                          //       image: AssetImage(
                                          //           "assets/Yash/images/property_1.png"),
                                          //       fit: BoxFit.fill,
                                          //     ),
                                          //     shape:
                                          //         RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius
                                          //               .circular(10),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Image.asset(
                                                //       "assets/images/iconamoon_profile-light.png",
                                                //       height: 12,
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //     const Text(
                                                //       'Villa',
                                                //       style: TextStyle(
                                                //         color: Colors
                                                //             .black,
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w300,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width:
                                                //           size.width -
                                                //               250,
                                                //     ),
                                                //     const Text(
                                                //       '₹ 80 Lac',
                                                //       style: TextStyle(
                                                //         color: Color(
                                                //             0xFF30469A),
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w800,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 3,
                                                // ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width - 300,
                                                  child: Text(
                                                    (state.searchedProperties ?? [])[index].title ?? "",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        height: 0,
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                  
                                                    const Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width - 180,
                                                      child: Text(
                                                        removeHtmlTags((state.searchedProperties ?? [])[index].address ?? ""),
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                          'DM Sans',
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                          height: 0,
                                                        ),
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
                              }): ListView.builder(
                              itemCount: (state.data ?? []).length,
                              shrinkWrap: true,
                              // physics:
                              // const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17.0, vertical: 17.0),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        RouteNames
                                            .purchaseDetailsScreen,
                                        arguments: index.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0),
                                    child: Container(
                                      width: size.width,
                                      height: 85,
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                  
                                          CustomNetworkImageWidget(
                                            width: 94.83,
                                            height: 94.83,
                                            image:
                                            "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                          ),
                                          // Container(
                                          //   width: 94.83,
                                          //   height: 94.83,
                                          //   decoration: ShapeDecoration(
                                          //     image:
                                          //         const DecorationImage(
                                          //       image: AssetImage(
                                          //           "assets/Yash/images/property_1.png"),
                                          //       fit: BoxFit.fill,
                                          //     ),
                                          //     shape:
                                          //         RoundedRectangleBorder(
                                          //       borderRadius:
                                          //           BorderRadius
                                          //               .circular(10),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Image.asset(
                                                //       "assets/images/iconamoon_profile-light.png",
                                                //       height: 12,
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //     const Text(
                                                //       'Villa',
                                                //       style: TextStyle(
                                                //         color: Colors
                                                //             .black,
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w300,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width:
                                                //           size.width -
                                                //               250,
                                                //     ),
                                                //     const Text(
                                                //       '₹ 80 Lac',
                                                //       style: TextStyle(
                                                //         color: Color(
                                                //             0xFF30469A),
                                                //         fontSize: 14,
                                                //         fontFamily:
                                                //             'DM Sans',
                                                //         fontWeight:
                                                //             FontWeight
                                                //                 .w800,
                                                //         height: 0,
                                                //       ),
                                                //     ),
                                                //     const SizedBox(
                                                //       width: 5,
                                                //     ),
                                                //   ],
                                                // ),
                                                // const SizedBox(
                                                //   height: 3,
                                                // ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width - 300,
                                                  child: Text(
                                                    (state.data ?? [])[index].title ?? "",
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                        'DM Sans',
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        height: 0,
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                  
                                                    const Icon(
                                                      Icons
                                                          .location_on_sharp,
                                                      size: 12,
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width - 180,
                                                      child: Text(
                                                        removeHtmlTags((state.data ?? [])[index].description ?? ""),
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontFamily:
                                                          'DM Sans',
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                          height: 0,
                                                        ),
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
                          // const SizedBox(
                          //   height: 20,
                          // ),
                        ]),
                  ),
                ],
              );
            },
          )
          //     BlocConsumer<WishlistCubit, WishlistState>(
          //   listener: (context, state) {
          //
          //   },
          //   builder: (context, state) {
          //     // final wishlist = state.wishlistState;
          //
          //     return SingleChildScrollView(
          //       physics: const NeverScrollableScrollPhysics(),
          //       child: Column(
          //         children: [
          //           const SizedBox(height: 20,),
          //            Padding(
          //              padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //              child: Row(
          //               children: [
          //                 const Text(
          //                   '14 results found',
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontFamily: 'DM Sans',
          //                     fontWeight: FontWeight.w300,
          //                     height: 0,
          //                   ),
          //                 ),
          //                 const Spacer(),
          //                 GestureDetector(
          //                   onTap: (){
          //                     showModalBottomSheet(
          //                       isDismissible: false,
          //                       constraints:  BoxConstraints(
          //                         minWidth:  MediaQuery.of(context).size.height * 0.8,
          //                     ),
          //                       context: context,
          //                       builder: (context) {
          //                         return CustomBottomSheet();
          //                       },
          //                     );
          //                   },
          //                   child: Container(
          //                     width: 75.31,
          //                     height: 25.82,
          //                     decoration: ShapeDecoration(
          //                       color: const Color(0x1930469A),
          //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          //                     ),
          //                     child: const Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           'Filter',
          //                           style: TextStyle(
          //                             color: Color(0xFF30469A),
          //                             fontSize: 14,
          //                             fontFamily: 'DM Sans',
          //                             fontWeight: FontWeight.w300,
          //                             height: 0,
          //                           ),
          //                         ),
          //                         SizedBox(width: 10,),
          //                         ImageIcon(AssetImage("assets/Yash/images/settings_filter.png",),size: 15,)
          //                       ],
          //                     ),
          //                   ),
          //                 )
          //               ],
          //                                ),
          //            ),
          //           SizedBox(
          //             height: size.height * 5,
          //             width: size.width,
          //             child: TabBarView(
          //                 controller: widget.tabController,
          //                 children:  [
          //                   SingleChildScrollView(
          //                     child: Column(
          //                       children: [
          //                         ListView.builder(
          //                           itemCount: 60,
          //                           shrinkWrap: true,
          //                             physics: const NeverScrollableScrollPhysics(),
          //                             padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
          //                             itemBuilder: (context, index) {
          //                           return GestureDetector(
          //                             onTap: (){
          //                               Navigator.pushNamed(
          //                                   context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
          //                             },
          //                             child: Padding(
          //                               padding: const EdgeInsets.only(bottom: 8.0),
          //                               child: Container(
          //                                 width: size.width,
          //                                 height: 94.83,
          //                                 decoration: ShapeDecoration(
          //                                   color: const Color(0x0C398BCB),
          //                                   shape: RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.circular(10),
          //                                   ),
          //                                 ),
          //                                 child: Row(
          //                                   children: [
          //                                     Container(
          //                                       width: 94.83,
          //                                       height: 94.83,
          //                                       decoration: ShapeDecoration(
          //                                         image: const DecorationImage(
          //                                           image: AssetImage("assets/Yash/images/property_1.png"),
          //                                           fit: BoxFit.fill,
          //                                         ),
          //                                         shape: RoundedRectangleBorder(
          //                                           borderRadius: BorderRadius.circular(10),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     const SizedBox(width: 10,),
          //                                      Padding(
          //                                        padding: const EdgeInsets.only(top: 5.0),
          //                                        child: Column(
          //                                          crossAxisAlignment: CrossAxisAlignment.start,
          //                                         children: [
          //                                           const SizedBox(height: 13,),
          //                                           Row(
          //                                             children: [
          //                                               Image.asset(
          //                                                 "assets/images/iconamoon_profile-light.png",
          //                                                 height: 12,
          //                                               ),
          //                                               const SizedBox(
          //                                                 width: 5,
          //                                               ),
          //                                               const Text(
          //                                                 'Villa',
          //                                                 style: TextStyle(
          //                                                   color:
          //                                                   Colors.black,
          //                                                   fontSize: 14,
          //                                                   fontFamily:
          //                                                   'DM Sans',
          //                                                   fontWeight:
          //                                                   FontWeight
          //                                                       .w300,
          //                                                   height: 0,
          //                                                 ),
          //                                               ),
          //                                               SizedBox(width: size.width - 250,),
          //                                               const Text(
          //                                                 '₹ 80 Lac',
          //                                                 style: TextStyle(
          //                                                   color: Color(0xFF30469A),
          //                                                   fontSize: 14,
          //                                                   fontFamily: 'DM Sans',
          //                                                   fontWeight: FontWeight.w800,
          //                                                   height: 0,
          //                                                 ),
          //                                               ),
          //                                               const SizedBox(
          //                                                 width: 5,
          //                                               ),
          //                                             ],
          //                                           ),
          //                                           const SizedBox(height: 3,),
          //                                           const Text(
          //                                             'Modern Green',
          //                                             style: TextStyle(
          //                                               color: Colors.black,
          //                                               fontSize: 16,
          //                                               fontFamily: 'DM Sans',
          //                                               fontWeight: FontWeight.w700,
          //                                               height: 0,
          //                                             ),
          //                                           ),
          //                                           const Row(
          //                                             mainAxisAlignment:
          //                                             MainAxisAlignment
          //                                                 .start,
          //                                             children: [
          //                                               Icon(
          //                                                 Icons
          //                                                     .location_on_sharp,
          //                                                 size: 12,
          //                                               ),
          //                                               Text(
          //                                                 'A7, 180C, Mayur Vihar, New Delhi',
          //                                                 style: TextStyle(
          //                                                   color:
          //                                                   Colors.black,
          //                                                   fontSize: 14,
          //                                                   fontFamily:
          //                                                   'DM Sans',
          //                                                   fontWeight:
          //                                                   FontWeight
          //                                                       .w300,
          //                                                   height: 0,
          //                                                 ),
          //                                               )
          //                                             ],
          //                                           ),
          //
          //                                         ],
          //                                                                            ),
          //                                      )
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                           );
          //                         }),
          //                         const SizedBox(height: 20,),
          //                       ],
          //                     ),
          //                   ),
          //                   SingleChildScrollView(
          //                     child: Column(
          //                       children: [
          //                         ListView.builder(
          //                             itemCount: 60,
          //                             shrinkWrap: true,
          //                             physics: const NeverScrollableScrollPhysics(),
          //                             padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
          //                             itemBuilder: (context, index) {
          //                               return GestureDetector(
          //                                 onTap: (){
          //                                   Navigator.pushNamed(
          //                                       context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
          //                                 },
          //                                 child: Padding(
          //                                   padding: const EdgeInsets.only(bottom: 8.0),
          //                                   child: Container(
          //                                     width: size.width,
          //                                     height: 94.83,
          //                                     decoration: ShapeDecoration(
          //                                       color: const Color(0x0C398BCB),
          //                                       shape: RoundedRectangleBorder(
          //                                         borderRadius: BorderRadius.circular(10),
          //                                       ),
          //                                     ),
          //                                     child: Row(
          //                                       children: [
          //                                         Container(
          //                                           width: 94.83,
          //                                           height: 94.83,
          //                                           decoration: ShapeDecoration(
          //                                             image: const DecorationImage(
          //                                               image: AssetImage("assets/Yash/images/property_1.png"),
          //                                               fit: BoxFit.fill,
          //                                             ),
          //                                             shape: RoundedRectangleBorder(
          //                                               borderRadius: BorderRadius.circular(10),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         const SizedBox(width: 10,),
          //                                         Padding(
          //                                           padding: const EdgeInsets.only(top: 5.0),
          //                                           child: Column(
          //                                             crossAxisAlignment: CrossAxisAlignment.start,
          //                                             children: [
          //                                               const SizedBox(height: 13,),
          //                                               Row(
          //                                                 children: [
          //                                                   Image.asset(
          //                                                     "assets/images/iconamoon_profile-light.png",
          //                                                     height: 12,
          //                                                   ),
          //                                                   const SizedBox(
          //                                                     width: 5,
          //                                                   ),
          //                                                   const Text(
          //                                                     'Villa',
          //                                                     style: TextStyle(
          //                                                       color:
          //                                                       Colors.black,
          //                                                       fontSize: 14,
          //                                                       fontFamily:
          //                                                       'DM Sans',
          //                                                       fontWeight:
          //                                                       FontWeight
          //                                                           .w300,
          //                                                       height: 0,
          //                                                     ),
          //                                                   ),
          //                                                   SizedBox(width: size.width - 250,),
          //                                                   const Text(
          //                                                     '₹ 80 Lac',
          //                                                     style: TextStyle(
          //                                                       color: Color(0xFF30469A),
          //                                                       fontSize: 14,
          //                                                       fontFamily: 'DM Sans',
          //                                                       fontWeight: FontWeight.w800,
          //                                                       height: 0,
          //                                                     ),
          //                                                   ),
          //                                                   const SizedBox(
          //                                                     width: 5,
          //                                                   ),
          //                                                 ],
          //                                               ),
          //                                               const SizedBox(height: 3,),
          //                                               const Text(
          //                                                 'Modern Green',
          //                                                 style: TextStyle(
          //                                                   color: Colors.black,
          //                                                   fontSize: 16,
          //                                                   fontFamily: 'DM Sans',
          //                                                   fontWeight: FontWeight.w700,
          //                                                   height: 0,
          //                                                 ),
          //                                               ),
          //                                               const Row(
          //                                                 mainAxisAlignment:
          //                                                 MainAxisAlignment
          //                                                     .start,
          //                                                 children: [
          //                                                   Icon(
          //                                                     Icons
          //                                                         .location_on_sharp,
          //                                                     size: 12,
          //                                                   ),
          //                                                   Text(
          //                                                     'A7, 180C, Mayur Vihar, New Delhi',
          //                                                     style: TextStyle(
          //                                                       color:
          //                                                       Colors.black,
          //                                                       fontSize: 14,
          //                                                       fontFamily:
          //                                                       'DM Sans',
          //                                                       fontWeight:
          //                                                       FontWeight
          //                                                           .w300,
          //                                                       height: 0,
          //                                                     ),
          //                                                   )
          //                                                 ],
          //                                               ),
          //
          //                                             ],
          //                                           ),
          //                                         )
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                               );
          //                             }),
          //                         const SizedBox(height: 20,),
          //                       ],
          //                     ),
          //                   ),
          //                 ]),
          //           ),
          //         ],
          //       ),
          //     );
          //     // return const Center(
          //     //     child: CustomTextStyle(text: 'Something went wrong'));
          //   },
          //   // buildWhen: (previous, current) {
          //   //   print('pre $previous');
          //   //   print('cur $current');
          //   //   return previous != current;
          //   // },
          // )
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
