import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../see_all.dart';
import '/logic/cubit/home/cubit/home_cubit.dart';
import '/logic/cubit/profile/profile_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/loading_widget.dart';
import '/presentation/widget/page_refresh.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../router/route_names.dart';
import '../../widget/customnetwork_widget.dart';
import 'component/headline_text.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onTap;

  const HomeScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String removeHtmlTags(String htmlText) {
      final RegExp exp =
          RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
      return htmlText.replaceAll(exp, '');
    }



    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      //appBar: const HomeAppBar(),
      body: PageRefresh(
        onRefresh: () async => setInitialLocation(context),
        // onRefresh: () async {
        //
        // },
        child: BlocListener<ProfileCubit, ProfileStateModel>(
          listener: (context, state) {
            final profile = state.profileState;
            if (profile is ProfileUpdateLoaded) {
              Utils.showSnackBar(context, profile.message);
              // context.read<ProfileCubit>().getAgentProfile();
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

              if (state.isLoading ?? false) {
                return const LoadingWidget();
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0;
                              i <
                                  ((state.homeDataLoaded ?? HomeDataModel())
                                              .bannerImage ??
                                          [])
                                      .length;
                              i++)
                            CustomNetworkImageWidget(
                              width: MediaQuery.of(context).size.width * 0.95,
                              image:
                                  "${RemoteUrls.rootUrl}${(((state.homeDataLoaded ?? HomeDataModel()).bannerImage ?? [])[i].image ?? "")}",
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                onTap(2);
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
                                onTap(1);
                              },
                              child: Container(
                                // width: 153,
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
                    Visibility(
                      visible:  ((homeCubit.homeModel ?? HomeDataModel())
                          .propertyFeatured ?? []).isNotEmpty,
                        child: const SizedBox(height: 5)),

                    Visibility(
                      visible:  ((homeCubit.homeModel ?? HomeDataModel())
                          .propertyFeatured ?? []).isNotEmpty,
                      child: HeadlineText(
                        text: 'Properties Near You',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeAll(
                                properties: (homeCubit.homeModel ?? HomeDataModel())
                                    .propertyFeatured ?? [],
                                title: 'Properties Near You',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible:  ((homeCubit.homeModel ?? HomeDataModel())
                          .propertyFeatured ?? []).isNotEmpty,
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: (state.homeDataLoaded?.propertyFeatured
                                                ?.length ??
                                            0) >
                                        5
                                    ? 5
                                    : state.homeDataLoaded?.propertyFeatured
                                            ?.length ??
                                        0,
                                // state.homeDataLoaded?.propertyFeatured?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0,
                                        left: 16,
                                        bottom: 25,
                                        top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteNames.purchaseDetailsScreen,
                                            arguments: Properties.fromJson(state
                                                    .homeDataLoaded
                                                    ?.propertyFeatured?[index]
                                                    .toJson() ??
                                                {}));
                                      },
                                      child: Container(
                                        width: 299.52,
                                        height: 240,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 1))
                                            ]),
                                        child: Column(
                                          children: [
                                            CustomNetworkImageWidget(
                                              width: 500,
                                              height: 160.69,
                                              image:
                                                  "${RemoteUrls.rootUrl}${(((state.homeDataLoaded ?? HomeDataModel()).propertyFeatured ?? [])[index].thumbnailImage ?? "")}",
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state
                                                              .homeDataLoaded
                                                              ?.propertyFeatured?[
                                                                  index]
                                                              .title ??
                                                          "",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: 'DM Sans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.location_on_sharp,
                                                    size: 14,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      removeHtmlTags(state
                                                              .homeDataLoaded
                                                              ?.propertyFeatured?[
                                                                  index]
                                                              .address ??
                                                          ""),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.699999988079071),
                                                        fontSize: 14,
                                                        fontFamily: 'DM Sans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  // const Spacer(),
                                                  Text(
                                                    '₹ ${Utils.convertNumber(state.homeDataLoaded?.propertyFeatured?[index].price ?? 0)}',
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
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: HeadlineText(
                        isPadding: false,
                        text: 'Newly Added',
                        onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAll(
                            properties: (homeCubit.homeModel ?? HomeDataModel())
                                .latestProperties ?? [],
                            title: 'Newly Added',
                          ),
                        ),
                      );
                        },
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        itemCount: ((homeCubit.homeModel ?? HomeDataModel())
                                        .latestProperties
                                        ?.length ??
                                    0) >
                                5
                            ? 5
                            : ((homeCubit.homeModel ?? HomeDataModel())
                                    .latestProperties
                                    ?.length ??
                                0),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.purchaseDetailsScreen,
                                    arguments: Properties.fromJson(state
                                            .homeDataLoaded
                                            ?.latestProperties?[index]
                                            .toJson() ??
                                        {}));
                                // Navigator.pushNamed(
                                //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                              },
                              child: Container(
                                // width: 324,
                                // height: 68,
                                decoration: ShapeDecoration(
                                  color: const Color(0x0C398BCB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 78.93,
                                    //   height: 78.93,
                                    //   decoration: ShapeDecoration(
                                    //     image:
                                    //          DecorationImage(
                                    //       image: NetworkImage(
                                    //         "${RemoteUrls.rootUrl}${homeCubit
                                    //             .homeModel!
                                    //             .latestProperty![index]
                                    //             .thumbnailImage}"),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //     shape:
                                    //         RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(
                                    //               10),
                                    //     ),
                                    //   ),
                                    // ),

                                    CustomNetworkImageWidget(
                                      width: 78.93,
                                      height: 78.93,
                                      image:
                                          "${RemoteUrls.rootUrl}${(((state.homeDataLoaded ?? HomeDataModel()).latestProperties ?? [])[index].thumbnailImage ?? "")}",
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                state
                                                        .homeDataLoaded
                                                        ?.latestProperties?[
                                                            index]
                                                        .title ??
                                                    "",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on_sharp,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  removeHtmlTags(state
                                                          .homeDataLoaded
                                                          ?.latestProperties?[
                                                              index]
                                                          .address ??
                                                      ""),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w300,
                                                    height: 0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          Text(
                                            '₹ ${Utils.convertNumber(state.homeDataLoaded?.latestProperties?[index].price ?? 0)}',
                                            style: TextStyle(
                                              color: Color(0xFF30469A),
                                              fontSize: 16,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w800,
                                              height: 0,
                                            ),
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
                                          //      Text(
                                          //       state.homeDataLoaded?.latestProperties?[index]. ?? "",
                                          //       style: TextStyle(
                                          //         color:
                                          //             Colors.black,
                                          //         fontSize: 13,
                                          //         fontFamily:
                                          //             'DM Sans',
                                          //         fontWeight:
                                          //             FontWeight
                                          //                 .w300,
                                          //         height: 0,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

String removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
  return htmlText.replaceAll(exp, '');
}



Future<void> setInitialLocation(BuildContext context) async {
  context.read<HomeCubit>().startLoader();
  // Set loading to true
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


    debugPrint("lat ${position.latitude.toString()} long ${position.longitude.toString()}");
    context.read<AddPropertyCubit>().getData().then((value){
      context.read<HomeCubit>().getHomeData(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      );
      // context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((element) {
      //   debugPrint("element==> ${ context.read<AddPropertyCubit>().state.staticInfo?.}");
      // });
    });


  } catch (e) {

    // Handle the error or display a message
    print('Error: $e');
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