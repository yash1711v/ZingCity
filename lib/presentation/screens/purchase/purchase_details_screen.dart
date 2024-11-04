import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/presentation/utils/utils.dart';
import '../../../data/model/order/single_order_model.dart';
import '../../../logic/cubit/order/order_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';

class PurchaseDetailScreen extends StatelessWidget {
  const PurchaseDetailScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();
    orderCubit.getOrderDetails(orderId);
    return Scaffold(
      extendBody: true,
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size(360, 200,),
        child: Container(
            width: 360,
            height: 200,
            decoration: const BoxDecoration(
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
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0,left: 16,right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/Yash/images/ZingCityLogo.png",
                        width: 50.03,
                        height: 35.01,
                      ),
                      const Spacer(),
                      Container(
                        width: 95.65,
                        height: 30.90,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF30469A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 8,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/Yash/images/post_ad_button.png"),
                            const SizedBox(width: 5.0),
                            const Text(
                              'Post Ad',
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
                      const SizedBox(width: 10,),
                    ],
                  ),
                ),
                const SizedBox(height: 35,),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,),
                        Text(
                          'Purchase Details',
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
            )
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          // if (state is OrderLoading) {
          //   return const LoadingWidget();
          // } else if (state is OrderError) {
          //   if (state.statusCode == 503) {
          //     return OrderDetailLoaded(orderDetail: orderCubit.singleOrder!);
          //   } else {
          //     return Center(
          //         child: CustomTextStyle(text: state.message, color: redColor));
          //   }
          //
          //   //Utils.errorSnackBar(context, state.message);
          // }

          return const OrderDetailLoaded(orderDetail: null
              //orderCubit.singleOrder!
              );
        },
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

                    },
                    child: const Text(
                      'Contact Now',
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

class OrderDetailLoaded extends StatelessWidget {
  const OrderDetailLoaded({super.key, this.orderDetail});

  final SingleOrderModel? orderDetail;

  @override
  Widget build(BuildContext context) {
    // final user = context.read<OrderCubit>().orders!.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              height: 220,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/Yash/images/properties_near_1.png"),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
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
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x194D5454),
                                blurRadius: 15,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                                "assets/Yash/images/heartShape.svg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/Yash/images/banglowIcon.svg"),
                const SizedBox(
                  width: 5,
                ),
                const SizedBox(
                  width: 237,
                  child: Text(
                    'Bangalow',
                    style: TextStyle(
                      color: Color(0x7F4D5454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {},
                    child: const Text(
                      'Sell',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        height: 0.14,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 335,
                  child: Text(
                    'Luxurious Haven Banglow',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                  ),
                ),
                Text(
                  '4 months ago',
                  style: TextStyle(
                    color: Color(0x7F4D5454),
                    fontSize: 10,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w400,
                    height: 0.14,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            const SizedBox(
              width: 339,
              child: Text(
                '\$2,500,000',
                style: TextStyle(
                  color: Color(0xFF30469A),
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 3 columns
                childAspectRatio: 7 / 2, // Adjust as needed to fit your design
                mainAxisSpacing: 10,
                crossAxisSpacing: 50,
              ),
              itemCount: 6, // Total items (2 rows * 3 columns)
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                        child: SvgPicture.asset(
                            "assets/Yash/images/available${index + 1}.svg"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bedrooms',
                            style: TextStyle(
                              color: Color(0x7F4D5454),
                              fontSize: 12,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '4 Rooms',
                            style: TextStyle(
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
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              width: 339,
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
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: 339,
              height: 43,
              child: Text(
                'Brand New, About 550 Sqft Loft/ Bachelor With Simple Kitchen, Upgrade Glass Shower, Modern And',
                style: TextStyle(
                  color: Color(0x7F4D5454),
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: 339,
              child: Text(
                'Read More',
                style: TextStyle(
                  color: Color(0xFF30469A),
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              width: 339,
              child: Text(
                'Outdoor facilities',
                style: TextStyle(
                  color: Color(0xFF4D5454),
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: SvgPicture.asset(
                                "assets/Yash/images/available${index + 1}.svg"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Swimming Pool',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF4D5454),
                                    fontSize: 14,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 104,
                                height: 17,
                                child: Text(
                                  '2 KM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0x7F4D5454),
                                    fontSize: 12,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 0.12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 293,
                  child: Text(
                    'Photo Gallery',
                    style: TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0x7F4D5454),
                    fontSize: 10,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    height: 0.14,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: index == 3
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/Yash/images/photoGallery.png"),
                                  fit: BoxFit.contain,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: ShapeDecoration(
                                  color: const Color(0x7F4D5454),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '+3',
                                    style: TextStyle(
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w600,
                                      height: 0.09,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/Yash/images/photoGallery.png"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                    );
                  }),
            ),
            const SizedBox(height: 25.0),
            const SizedBox(
              width: 339,
              child: Text(
                'Location',
                style: TextStyle(
                  color: Color(0xFF4D5454),
                  fontSize: 16,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            const Text(
              'Address :',
              style: TextStyle(
                color: Color(0xFF4D5454),
                fontSize: 14,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
            ),
            const SizedBox(height: 25.0),
            Row(
              children: [
                SvgPicture.asset("assets/Yash/images/locationIcon.svg"),
                const SizedBox(
                  width: 5,
                ),
                const SizedBox(
                  width: 237,
                  child: Text(
                    '1234, 5th Avenue, New York, USA',
                    style: TextStyle(
                      color: Color(0x7F4D5454),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              height: 175,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/Yash/images/mapImage.png"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 175,
                decoration: ShapeDecoration(
                  color: const Color(0x354D5454),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {},
                      child: const Text(
                        'View on map',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
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
