import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/data/model/product/aminit_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/add_property_model.dart' as room;
import '../../../data/model/home/home_data_model.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/custom_theme.dart';
import '../../widget/customnetwork_widget.dart';
import '../home/home_screen.dart';
import '../support/contact_us.dart';
import '/presentation/utils/utils.dart';
import '../../../data/model/order/single_order_model.dart';
import '../../../logic/cubit/order/order_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';

class PurchaseDetailScreen extends StatelessWidget {
  const PurchaseDetailScreen({super.key, required this.propertiesDetails});

  final dynamic propertiesDetails;

  @override
  Widget build(BuildContext context) {
    // final orderCubit = context.read<OrderCubit>();
    // orderCubit.getOrderDetails(propertiesDetails);
    return Scaffold(
      extendBody: true,
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(
          360,
          200,
        ),
        child: Container(
            width: 360,
            height: 200,
            decoration: BoxDecoration(
              color: CustomTheme.theme.scaffoldBackgroundColor,
              boxShadow: [
                const BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                        ),
                        Text(
                          'Property Details',
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
                )
              ],
            )),
      ),
      body: propertyDetailsLoaded(
          propertyDetails: propertiesDetails //orderCubit.singleOrder!
          ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUs(isSendingEnquiry: true,propertyId: propertiesDetails.id.toString())),
                      );

                    },
                    child: const Text(
                      'Send Eqnuiry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class propertyDetailsLoaded extends StatefulWidget {
  const propertyDetailsLoaded({super.key, this.propertyDetails});

  final dynamic propertyDetails;

  @override
  State<propertyDetailsLoaded> createState() => _propertyDetailsLoadedState();
}

class _propertyDetailsLoadedState extends State<propertyDetailsLoaded> {


  List<room.Category> categories = [];
  Set<room.Category> subCategoriesResidential = {};
  Set<room.Category> subCategoriesCommercial = {};
  Set<room.Category> subCategoriesPlotLand = {};
  Set<room.Category> subCategoriesAgricultural = {};

  String PropertyType = "";


  List<String> Images = [];
 String categoryName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.propertyDetails.purpose == "2"){

      context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
        debugPrint("element ==> ${element.id}");
      });
      context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
        debugPrint("Category Id ${widget.propertyDetails.categoryId.toString()}");
        context.read<AddPropertyCubit>().state.staticInfo?.purpose?.rent?.forEach((rent) {

          if(rent.categoryId == category.id){
            categories.add(category);
            if(category.id.toString() ==  widget.propertyDetails.categoryId.toString()){
              categoryName = category.name ?? "";
            }
          }

          if(rent.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
            context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
            if(category.id.toString() ==  widget.propertyDetails.categoryId.toString()){
              categoryName = category.name ?? "";
            }
            // if(category.id.toString() ==  widget.propertyDetails.categoryId.toString()){
            //   categoryName = category.name ?? "";
            // }

          }
        });
      });


      context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
        // debugPrint("key ==> $key");

        categories.forEach((categories){
          if(element.purpose!.contains(2)){

            if(element.parentId.toString() == "1" ){

              subCategoriesResidential.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }

            }
            else {
              // debugPrint("Commercial ==> ${element.name}");
              subCategoriesCommercial.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
            }
          }

        });



      });
    } else {

      context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
        debugPrint("element ==> ${element.id}");
      });
      context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
        context.read<AddPropertyCubit>().state.staticInfo?.purpose?.sell?.forEach((rent) {

          if(rent.categoryId == category.id){
            categories.add(category);
            if(category.id.toString() ==  widget.propertyDetails.categoryId.toString()){
              categoryName = category.name ?? "";
            }
          }

          if(rent.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
            context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
            if(category.id.toString() ==  widget.propertyDetails.categoryId.toString()){
              categoryName = category.name ?? "";
            }
          }
        });
      });


      context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
        // debugPrint("key ==> $key");

        categories.forEach((categories){
          if(element.purpose!.contains(1)){

            if(element.parentId.toString() == "1" ){

              subCategoriesResidential.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }

            }
            if(element.parentId.toString() == "2"){
              // debugPrint("Commercial ==> ${element.name}");
              subCategoriesCommercial.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
            }
            if (element.parentId.toString() == "3"){
              subCategoriesAgricultural.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
              // debugPrint("Agricultural ==> ${element.name}");
              // debugPrint("Agricultural ==> ${element.name}");
            }
            if (element.parentId.toString() == "4"){
              subCategoriesPlotLand.add(element);
              if(element.id.toString() ==  widget.propertyDetails.propertyTypeId.toString()){
                PropertyType = element.name ?? "";
              }
            }
          }

        });



      });





    }


    widget.propertyDetails.sliders.forEach((element) {
      if((element.image ?? "").isNotEmpty) {
        Images.add("${RemoteUrls.rootUrl}${element.image}");
      }
    });
    Images.add("${RemoteUrls.rootUrl}${widget.propertyDetails.thumbnailImage}");

  }
  CarouselSliderController? carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    // final user = context.read<OrderCubit>().orders!.user;
    // log("${ widget.propertyDetails.sliders.length}", name: "Length of Slider Images");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            // CustomNetworkImageWidget(
            //   width: 500,
            //   height: 160.69,
            //   image:
            //   "${RemoteUrls.rootUrl}${propertyDetails.thumbnailImage}",
            // ),

            CarouselSlider(
              items: Images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return CustomNetworkImageWidget(
                      width: MediaQuery.of(context).size.width * 0.95,
                      image:
                      i,
                    );

                      Container(
                      width: double.infinity,
                      // height: 220,
                      decoration: ShapeDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            i,
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: widget.propertyDetails.isFeatured == "enable"
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: widget.propertyDetails.isFeatured == "enable",
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0))),
                                      onPressed: () {},
                                      child: const Text(
                                        'Featured',
                                        style: TextStyle(
                                          color: Color(0xFFFAFAFA),
                                          fontSize: 12,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0.12,
                                        ),
                                      )),
                                ),
                                // Container(
                                //   width: 32,
                                //   height: 32,
                                //   decoration: const ShapeDecoration(
                                //     color: Colors.white,
                                //     shape: OvalBorder(),
                                //     shadows: [
                                //       BoxShadow(
                                //         color: Color(0x194D5454),
                                //         blurRadius: 15,
                                //         offset: Offset(0, 2),
                                //         spreadRadius: 0,
                                //       )
                                //     ],
                                //   ),
                                //   child: Center(
                                //     child: SvgPicture.asset(
                                //         "assets/Yash/images/heartShape.svg"),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: Images.length>1?const BouncingScrollPhysics():const NeverScrollableScrollPhysics(),
                autoPlay:Images.length>1? true:false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.4,
                initialPage: 1,
              ),
            ),

            SizedBox(
              height: 20.h,
            ),


            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                       // width: ,
                    // height: 150,
                    decoration: ShapeDecoration(
                      color: const Color(0x19087C7C),
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Center(child: Text( widget.propertyDetails.purpose.toString() == "1"?"For Sell":"For Rent",textAlign: TextAlign.center,),),
                  ),
                ),
              SizedBox(
                width: 5,
              ),
                Expanded(
                  child: Container(
                    // margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                       // width: ,
                    // height: 150,
                    decoration: ShapeDecoration(
                      color: const Color(0x19087C7C),
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Center(child: Text(categoryName,textAlign: TextAlign.center,)),
                  ),
                ),
                Visibility(
                  visible: PropertyType.isNotEmpty,
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: PropertyType.isNotEmpty,
                    child: Container(
                      // margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      // width: ,
                      // height: 150,
                      decoration: ShapeDecoration(
                        color: const Color(0x19087C7C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${PropertyType.toString()}",
                          // style: const TextStyle(
                          //   // color: Color(0x7F4D5454),
                          //   fontSize: 14,
                          //   fontFamily: 'DM Sans',
                          //   fontWeight: FontWeight.w400,
                          //   height: 0.10,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.propertyDetails.title,
                    style: const TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Price: ₹${widget.propertyDetails.price}',
                    style: const TextStyle(
                      color: Color(0xFF30469A),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      // height: 0.09,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 25,
                // ),
                Expanded(
                  child: Text(
                    'Area: ${widget.propertyDetails.totalArea} sqft',
                    style: const TextStyle(
                      color: Color(0xFF30469A),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      // height: 0.09,
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    'Unit: ${widget.propertyDetails.totalUnit}',
                    style: const TextStyle(
                      color: Color(0xFF30469A),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      // height: 0.09,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'About this Property',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            ReadMoreText(
              text: removeHtmlTags(widget.propertyDetails.description),
              style: const TextStyle(
                color: Color(0x7F4D5454),
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty || (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
              child: const SizedBox(
                height: 15,
              ),
            ),

            Visibility(
              visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty || (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: (widget.propertyDetails.totalBedroom ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/BedRoom.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bedroom',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalBedroom} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (widget.propertyDetails.totalBathroom ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:
                              SvgPicture.asset("assets/Yash/images/Bathroom.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bathroom',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalBathroom} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                  // SizedBox(
                  //   width: 0,
                  // )
                ],
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty || (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
              child: const SizedBox(
                height: 15,
              ),
            ),
            Visibility(
              visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty || (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: (widget.propertyDetails.totalGarage ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/Garage.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Garage',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalGarage} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (widget.propertyDetails.totalKitchen ?? "").isNotEmpty,
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SvgPicture.asset("assets/Yash/images/kitchen.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kitchen',
                              style: TextStyle(
                                color: Color(0x7F4D5454),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.12,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.propertyDetails.totalKitchen} Rooms',
                              style: const TextStyle(
                                color: Color(0xFF4D5454),
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                  // SizedBox(
                  //   width: 0,
                  // )
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    ' Location',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15.0),
            Row(
              children: [
                SvgPicture.asset("assets/Yash/images/locationIcon.svg"),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "${widget.propertyDetails.address}",
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0x7F4D5454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.propertyDetails.aminityItemDto.any((element) => element.aminity != null),
             child: const SizedBox(
               height: 10,
             ),
           ),
            Visibility(
                visible: widget.propertyDetails.aminityItemDto.any((element) => element.aminity != null),
               child: const Text("Aminities")),
            Visibility(
              visible: widget.propertyDetails.aminityItemDto.any((element) => element.aminity != null),
              child: const SizedBox(
                height: 10,
              ),
            ),
            Visibility(
              visible: widget.propertyDetails.aminityItemDto.any((element) => element.aminity != null),
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: ListView.builder(
                  itemCount: widget.propertyDetails.aminityItemDto.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    // log("aminity ==> ${widget.propertyDetails.aminityItemDto[index].aminity.aminity}",name: "Aminity");
                      return Visibility(
                        visible: widget.propertyDetails.aminityItemDto[index].aminity != null,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          // width: 150,
                          // height: 150,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                            //   ),
                            //   fit: BoxFit.fill,
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Center(child: Text((widget.propertyDetails.aminityItemDto[index].aminity ?? const AminityModel(id: 0, aminity: '')).aminity)),
                        ),
                      );
                    }),
              ),
            ),
            Visibility(
              visible: widget.propertyDetails.propertyLocation.any((element) => element.location != null),
             child: const SizedBox(
               height: 10,
             ),
           ),
            Visibility(
                visible: widget.propertyDetails.propertyLocation.any((element) => element.location != null),
               child: const Text("Nearest Locations")),
            Visibility(
              visible: widget.propertyDetails.propertyLocation.any((element) => element.location != null),
              child: const SizedBox(
                height: 10,
              ),
            ),
            Visibility(
              visible: widget.propertyDetails.propertyLocation.any((element) => element.location != null),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ListView.builder(
                  itemCount: widget.propertyDetails.propertyLocation.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    // log("aminity ==> ${widget.propertyDetails.aminityItemDto[index].aminity.aminity}",name: "Aminity");
                      return Visibility(
                        visible: widget.propertyDetails.propertyLocation.any((element) => element.location != null),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          // width: 150,
                          // height: 150,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                            //   ),
                            //   fit: BoxFit.fill,
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text((widget.propertyDetails.propertyLocation[index].location ?? Location(id: '', location: '', status: '')).location)),
                              Center(child: Text("Distance:"+widget.propertyDetails.propertyLocation[index].distance)),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Visibility(
              visible: widget.propertyDetails.propertyAdditionInfo.any((element) => element.addKey != null || element.addValue != null),
             child: const SizedBox(
               height: 10,
             ),
           ),
            Visibility(
                visible: widget.propertyDetails.propertyAdditionInfo.any((element) => element.addKey != null || element.addValue != null),
               child: const Text("Additional Information")),
            Visibility(
              visible: widget.propertyDetails.propertyAdditionInfo.any((element) => element.addKey != null || element.addValue != null),
              child: const SizedBox(
                height: 10,
              ),
            ),
            Visibility(
              visible: widget.propertyDetails.propertyAdditionInfo.any((element) => element.addKey != null || element.addValue != null),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  itemCount: widget.propertyDetails.propertyAdditionInfo.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    // log("aminity ==> ${widget.propertyDetails.aminityItemDto[index].aminity.aminity}",name: "Aminity");
                      return Visibility(
                        visible: widget.propertyDetails.propertyAdditionInfo.any((element) => element.addKey != null || element.addValue != null),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          // width: 150,
                          // height: 150,
                          decoration: ShapeDecoration(
                            color: const Color(0x19087C7C),
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //     "${RemoteUrls.rootUrl}${widget.propertyDetails.images![int].image}",
                            //   ),
                            //   fit: BoxFit.fill,
                            // ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Center(child: Text((widget.propertyDetails.propertyAdditionInfo[index].addKey ?? "")+": "+ widget.propertyDetails.propertyAdditionInfo[index].addValue)),
                        ),
                      );
                    }),
              ),
            ),

            const SizedBox(height: 80.0),
            // Container(
            //   width: double.infinity,
            //   height: 175,
            //   decoration: ShapeDecoration(
            //     image: const DecorationImage(
            //       image: AssetImage("assets/Yash/images/mapImage.png"),
            //       fit: BoxFit.fill,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(18),
            //     ),
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     height: 175,
            //     decoration: ShapeDecoration(
            //       color: const Color(0x354D5454),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(18),
            //       ),
            //     ),
            //     child: Center(
            //       child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: primaryColor,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10.0))),
            //           onPressed: () {},
            //           child: const Text(
            //             'View on map',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 12,
            //               fontFamily: 'DM Sans',
            //               fontWeight: FontWeight.w400,
            //               height: 0.12,
            //             ),
            //           )),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }

  String getRemainingDay(String date) {
    if (date.contains('/') || date.contains('-') || date.contains(':')) {
      return Utils.formatDate(date);
    } else {
      return date;
    }
  }

  Widget tableContent(String text, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0)
              .copyWith(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyle(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
              CustomTextStyle(
                text: value,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: isLast ? transparent : borderColor,
        ),
      ],
    );
  }

  Widget paymentContent(String text, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0)
              .copyWith(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyle(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                    color: value == 'success' ? greenColor : redColor,
                    borderRadius: borderRadius),
                child: CustomTextStyle(
                  text: value,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: isLast ? transparent : borderColor,
        ),
      ],
    );
  }

  Widget _addressComponent(String text, String value) {
    return Row(
      children: [
        CustomTextStyle(
          text: '$text: ',
          color: blackColor,
          fontSize: 15.0,
        ),
        CustomTextStyle(
          text: value,
          color: grayColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }

  Widget _propertyComponent(String text, String value) {
    return Row(
      children: [
        CustomTextStyle(
          text: '$text: ',
          color: blackColor,
          fontSize: 15.0,
        ),
        CustomTextStyle(
          text: value,
          color: primaryColor,
          fontSize: 16.0,
          maxLine: 2,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;

  const ReadMoreText({
    Key? key,
    required this.text,
    this.maxLines = 3,
    required this.style,
  }) : super(key: key);

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  int _currentMaxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final span = TextSpan(text: widget.text, style: widget.style);
            final tp = TextPainter(
              text: span,
              maxLines: widget.maxLines,
              textDirection: TextDirection.ltr,
            );
            tp.layout(maxWidth: constraints.maxWidth);
            final textExceedsMaxLines = tp.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: widget.style,
                  maxLines: _currentMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                if (textExceedsMaxLines || _currentMaxLines > widget.maxLines)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentMaxLines += 3;
                      });
                    },
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: widget.style.fontSize ?? 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
