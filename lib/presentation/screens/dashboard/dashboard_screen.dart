import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/home/cubit/home_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/bottomSheet.dart';
import '../../widget/customnetwork_widget.dart';

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
    // loginBloc = context.read<LoginBloc>();
    // cCubit = context.read<CompanyCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String removeHtmlTags(String htmlText) {
      final RegExp exp =
          RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
      return htmlText.replaceAll(exp, '');
    }

    return Scaffold(
        backgroundColor: scaffoldBackground,
        body: BlocBuilder<HomeCubit, HomeState>(
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
                      Visibility(
                        visible: (state.searchedProperties ?? []).isNotEmpty,
                        child: Text(
                          '${(state.searchedProperties ?? []).length} results found ${(state.searchedProperties ?? []).isNotEmpty?"from Search":""}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            constraints: const BoxConstraints(
                                // minWidth:
                                //     MediaQuery.of(context).size.w * 0.8,
                                ),
                            context: context,
                            builder: (context) {
                              return CustomBottomSheet(
                                isRent: false,
                                typeOfProperty: widget.tabController?.index == 0
                                    ? 'Residential'
                                    : widget.tabController?.index == 1
                                        ? 'Commercial'
                                        : widget.tabController?.index == 2
                                            ? "Agricultural"
                                            : "Plot/Land",
                              );
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
                  child:
                      TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: widget.tabController, children: [
                        (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):
                        (state.searchedProperties ?? []).isNotEmpty?
                        ListView.builder(
                            itemCount: (state.searchedProperties ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {


                              String PropertyType = "";

                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.searchedProperties ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  PropertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.searchedProperties ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              '$PropertyType',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }):
                        ListView.builder(
                            itemCount: (state.data ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {

                              String propertyType = "";
                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.data ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  propertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.data ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                            Text(
                                              propertyType,
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }),
                        (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):
                        (state.searchedProperties ?? []).isNotEmpty?
                        ListView.builder(
                            itemCount: (state.searchedProperties ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {


                              String PropertyType = "";

                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.searchedProperties ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  PropertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.searchedProperties ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              '$PropertyType',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }):
                        ListView.builder(
                            itemCount: (state.data ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {

                              String propertyType = "";
                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.data ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  propertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.data ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                            Text(
                                              propertyType,
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }),
                        (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):
                        (state.searchedProperties ?? []).isNotEmpty?
                        ListView.builder(
                            itemCount: (state.searchedProperties ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {


                              String PropertyType = "";

                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.searchedProperties ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  PropertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.searchedProperties ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              '$PropertyType',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }):
                        ListView.builder(
                            itemCount: (state.data ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {

                              String propertyType = "";
                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.data ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  propertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.data ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                            Text(
                                              propertyType,
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }),
                        (state.isLoading ?? true) ?const Center(child: CircularProgressIndicator()):
                        (state.searchedProperties ?? []).isNotEmpty?
                        ListView.builder(
                            itemCount: (state.searchedProperties ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {


                              String PropertyType = "";

                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.searchedProperties ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  PropertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.searchedProperties ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.searchedProperties ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              '$PropertyType',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }):
                        ListView.builder(
                            itemCount: (state.data ?? []).length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 17.0),
                            itemBuilder: (context, index) {

                              String propertyType = "";
                              context
                                  .read<AddPropertyCubit>()
                                  .state
                                  .staticInfo
                                  ?.subcategories!
                                  .forEach((key, element) {
                                // debugPrint("key ==> $key");

                                if (element.id.toString() ==
                                    (state.data ?? [])[index]
                                        .propertyTypeId.toString()) {
                                  propertyType = element.name ?? "";
                                }
                              });

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
                                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                      margin: const EdgeInsets.only(
                                          bottom: 5),
                                      decoration: ShapeDecoration(
                                        color: const Color(0x0C398BCB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child:  ListTile(

                                        leading: CustomNetworkImageWidget(
                                          width: 94.83,
                                          height: 94.83,
                                          image:
                                          "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                        ),
                                        title: Text(
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

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                                Expanded(
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

                                            Text(
                                              '₹ ${Utils.convertNumber((state.data ?? [])[index].price ?? "")}',
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                            Text(
                                              propertyType,
                                              style: TextStyle(
                                                color: Color(0xFF30469A),
                                                fontSize: 16,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),


                                          ],
                                        ),

                                      )


                                    // Row(
                                    //   children: [
                                    //
                                    //     CustomNetworkImageWidget(
                                    //    width: 94.83,
                                    //      height: 94.83,
                                    //       image:
                                    //       "${RemoteUrls.rootUrl}${(state.data ?? [])[index].thumbnailImage}",
                                    //     ),
                                    //     // Container(
                                    //     //   width: 94.83,
                                    //     //   height: 94.83,
                                    //     //   decoration: ShapeDecoration(
                                    //     //     image:
                                    //     //         const DecorationImage(
                                    //     //       image: AssetImage(
                                    //     //           "assets/Yash/images/property_1.png"),
                                    //     //       fit: BoxFit.fill,
                                    //     //     ),
                                    //     //     shape:
                                    //     //         RoundedRectangleBorder(
                                    //     //       borderRadius:
                                    //     //           BorderRadius
                                    //     //               .circular(10),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     const SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(
                                    //               top: 5.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment
                                    //                 .start,
                                    //         children: [
                                    //           const SizedBox(
                                    //             height: 13,
                                    //           ),
                                    //           // Row(
                                    //           //   children: [
                                    //           //     Image.asset(
                                    //           //       "assets/images/iconamoon_profile-light.png",
                                    //           //       height: 12,
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       'Villa',
                                    //           //       style: TextStyle(
                                    //           //         color: Colors
                                    //           //             .black,
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w300,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     SizedBox(
                                    //           //       width:
                                    //           //           size.width -
                                    //           //               250,
                                    //           //     ),
                                    //           //     const Text(
                                    //           //       '₹ 80 Lac',
                                    //           //       style: TextStyle(
                                    //           //         color: Color(
                                    //           //             0xFF30469A),
                                    //           //         fontSize: 14,
                                    //           //         fontFamily:
                                    //           //             'DM Sans',
                                    //           //         fontWeight:
                                    //           //             FontWeight
                                    //           //                 .w800,
                                    //           //         height: 0,
                                    //           //       ),
                                    //           //     ),
                                    //           //     const SizedBox(
                                    //           //       width: 5,
                                    //           //     ),
                                    //           //   ],
                                    //           // ),
                                    //           // const SizedBox(
                                    //           //   height: 3,
                                    //           // ),
                                    //            SizedBox(
                                    //              width: MediaQuery.of(context).size.width - 300,
                                    //              child: Text(
                                    //               (state.data ?? [])[index].title ?? "",
                                    //               maxLines: 1,
                                    //               style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //                 fontFamily:
                                    //                     'DM Sans',
                                    //                 fontWeight:
                                    //                     FontWeight.w700,
                                    //                 height: 0,
                                    //                 overflow: TextOverflow.ellipsis
                                    //               ),
                                    //                                                                      ),
                                    //            ),
                                    //            Row(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment
                                    //                     .start,
                                    //             crossAxisAlignment: CrossAxisAlignment.start,
                                    //             children: [
                                    //
                                    //               const Icon(
                                    //                 Icons
                                    //                     .location_on_sharp,
                                    //                 size: 12,
                                    //               ),
                                    //               SizedBox(
                                    //                 width: MediaQuery.of(context).size.width - 180,
                                    //                 child: Text(
                                    //                   removeHtmlTags((state.data ?? [])[index].address ?? ""),
                                    //                   maxLines: 2,
                                    //                   style: const TextStyle(
                                    //                     color: Colors
                                    //                         .black,
                                    //                     fontSize: 14,
                                    //                     fontFamily:
                                    //                         'DM Sans',
                                    //                     fontWeight:
                                    //                         FontWeight
                                    //                             .w300,
                                    //                     height: 0,
                                    //                   ),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ),
                                ),
                              );
                            }),
                  ]),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            );
          },
        ));
  }
}

class DashboardComponents extends StatelessWidget {
  const DashboardComponents({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0), color: whiteColor),
        child: Padding(
          padding: Utils.symmetric(h: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: const Color(0xFFF5F4FF),
                    ),
                    child: Padding(
                      padding: Utils.all(value: 10.0),
                      child: CustomImage(
                        path: icon,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  CustomTextStyle(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF5F4FF),
                ),
                child: Padding(
                  padding: Utils.all(value: 8.0),
                  child: const Center(
                      child: CustomImage(
                    path: KImages.arrowIcon,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
