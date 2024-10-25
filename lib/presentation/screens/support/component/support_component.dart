import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/ticket/ticket_model.dart';
import '/presentation/utils/utils.dart';
import '../../../../data/model/order/single_order_model.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/primary_button.dart';

class SupportComponent extends StatelessWidget {
  const SupportComponent({super.key, required this.singleOrder});

  final TicketModel singleOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      //height: 200.0.h,
      margin: EdgeInsets.symmetric(vertical: 8.0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextStyle(
                text: Utils.formatDate(singleOrder.createdAt),
                fontSize: 14.0,
                color: const Color(0xFF7E8BA0),
              ),
              PrimaryButton(
                text: singleOrder.priority,
                onPressed: () {},
                fontSize: 15.0,
                bgColor: greenColor,
                borderRadiusSize: 3.0,
                minimumSize: Size(64.0.w, 36.0.h),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextStyle(
                text: singleOrder.subject,
                fontSize: 18.0,
                color: blackColor,
                fontWeight: FontWeight.w500,
              ),
              // CustomTextStyle(
              //   text: Utils.formatPrice(context, '2121'),
              //   fontSize: 15.0,
              //   color: blackColor,
              //   fontWeight: FontWeight.w500,
              // )
            ],
          ),
          SizedBox(height: 16.0.h),
          PrimaryButton(
              text: 'Show Support',
              onPressed: () => Navigator.pushNamed(
                  context, RouteNames.singleSupportScreen,
                  arguments: singleOrder.id.toString())),
        ],
      ),
    );
  }
}
