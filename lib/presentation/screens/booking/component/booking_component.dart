import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../../data/model/booking/booking_model.dart';
import '../../../../data/model/product/property_item_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/favorite_button.dart';

class BookingComponent extends StatelessWidget {
  const BookingComponent({super.key, required this.property});

  final BookingModel property;

  @override
  Widget build(BuildContext context) {
    String dateTime(String? t, [bool isTime = true]) {
      if (t != null && t.isNotEmpty) {
        DateTime date;
        if (isTime) {
          // If t is a time string like "18:15:00"
          try {
            date = DateFormat("HH:mm:ss").parse(t);
          } catch (e) {
            return 'Invalid time format';
          }
          // Formatting the time to '5:08 PM'
          return DateFormat("h:mm a").format(date);
        } else {
          try {
            date = DateTime.parse(t);
          } catch (e) {
            return 'Invalid date format';
          }
          // Formatting the date to '15 Aug, 2024'
          return DateFormat("dd MMM, yyyy").format(date);
        }
      } else {
        return '';
      }
    }

    final status = property.status == 1;
    return Stack(
      children: [
        Container(
          height: 145.0.h,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 8.0),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      CustomImage(
                        path: RemoteUrls.imageUrl(
                            property.property!.thumbnailImage),
                        height: double.infinity,
                        width: 140.0,
                        fit: BoxFit.cover,
                      ),

                      // Positioned(
                      //   top: 8.0,
                      //   left: 8.0,
                      //   child: FavoriteButton(id: property.property!.id.toString()),
                      // )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     CustomTextStyle(
                    //       text: Utils.formatPrice(
                    //           context, property.price.toStringAsFixed(2)),
                    //       color: primaryColor,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 18.0,
                    //     ),
                    //     CustomTextStyle(
                    //       text: property.rentPeriod.isNotEmpty
                    //           ? '/${property.rentPeriod}'
                    //           : property.rentPeriod,
                    //       color: grayColor,
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14.0,
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 3.0),
                    Flexible(
                      child: CustomTextStyle(
                        text: property.property!.title,
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        maxLine: 2,
                        height: 1.6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    _buildInfo('Name', property.name),
                    const SizedBox(height: 3.0),
                    _buildInfo('Time',
                        '${dateTime(property.bookingDate, false)} ${dateTime(property.bookingTime)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8.0,
          left: 0.0,
          child: Container(
            padding: Utils.symmetric(h: 12.0, v: 8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
              color: status ? const Color(0xFF1fab5e) : redColor,
            ),
            child: CustomTextStyle(
              text: status ? 'Confirmed' : 'Pending',
              fontWeight: FontWeight.w600,
              color: whiteColor,
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 0.0,
          child: GestureDetector(
            onTap: ()=>_bookingDialog(context,property),
            child: Container(
              padding: Utils.symmetric(h: 10.0, v: 8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                ),
                color: grayColor,
              ),
              child: const Icon(Icons.visibility_rounded,color: whiteColor,),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildInfo(String name, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextStyle(
          text: '$name:',
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 4.0),
        Flexible(
          child: CustomTextStyle(
            text: date,
            color: grayColor,
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            maxLine: 1,
            height: 1.5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  Widget tableContent(String text, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0)
              .copyWith(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextStyle(
                text: '$text:',
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
              Utils.horizontalSpace(10.0),
              Flexible(
                child: CustomTextStyle(
                  text: value,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  maxLine: 1,
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

_bookingDialog(BuildContext context,BookingModel book) {
  String dateTime(String? t, [bool isTime = true]) {
    if (t != null && t.isNotEmpty) {
      DateTime date;
      if (isTime) {
        // If t is a time string like "18:15:00"
        try {
          date = DateFormat("HH:mm:ss").parse(t);
        } catch (e) {
          return 'Invalid time format';
        }
        // Formatting the time to '5:08 PM'
        return DateFormat("h:mm a").format(date);
      } else {
        try {
          date = DateTime.parse(t);
        } catch (e) {
          return 'Invalid date format';
        }
        // Formatting the date to '15 Aug, 2024'
        return DateFormat("dd MMM, yyyy").format(date);
      }
    } else {
      return '';
    }
  }
  Utils.showCustomDialog(
    context,
    hp: 16.0,
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const CustomTextStyle(
                  text: 'Booking Details',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: blackColor,
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CustomImage(path: KImages.cancelIcon))
              ],
            ),
            const SizedBox(height: 14.0),
            Container(
              width: double.infinity.w,
              //height: 300.0,
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: borderRadius,
              ),
              child: Column(
                children: [
                  tableContent('Property',book.property!.title),
                  tableContent('Name',book.name),
                  tableContent('Date',dateTime(book.bookingDate,false)),
                  tableContent('Time',dateTime(book.bookingTime)),
                  tableContent('Guests',book.guests.toString()),
                  tableContent('City',book.city),
                  tableContent('Zip Code',book.zipCode),
                  tableContent('Email',book.email),
                  tableContent('Phone',book.phone),
                  tableContent('Comment',book.comment),
                  tableContent('Status',book.status ==1 ?'Confirmed':'Pending'),
                ],
              ),
            ),

            //
            // PrimaryButton(
            //     text: 'Confirm Booking',
            //     onPressed: () => Navigator.of(context).pop(),
            //     textColor: blackColor,
            //     fontSize: 20.0,
            //     borderRadiusSize: radius,
            //     bgColor: yellowColor)
          ],
        ),
      ),
    ),
  );
}
}
