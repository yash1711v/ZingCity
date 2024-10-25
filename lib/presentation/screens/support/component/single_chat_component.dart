import 'package:flutter/material.dart';


import '../../../../data/model/ticket/ticket_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_test_style.dart';

// ignore: must_be_immutable
class SingleChat extends StatelessWidget {
  SingleChat({super.key, required this.m, required this.isSeller});

  final TicketModel m;
  final bool isSeller;
  double radius = 14.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSeller ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: Utils.symmetric(h: 12.0, v: 12.0),
            margin: Utils.symmetric(h: 16.0, v: 6.0).copyWith(top: 0.0),
            decoration: BoxDecoration(
              color: isSeller ? Colors.blue : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
                bottomLeft: Radius.circular(isSeller ? radius : 0.0),
                bottomRight: Radius.circular(isSeller ? 0.0 : radius),
              ),
            ),
            child: CustomTextStyle(
              text: m.message,
              color: isSeller ? whiteColor : blackColor,
              fontSize: 16.0,
              maxLine: 20,
            ),
          ),
        ),
      ],
    );
  }
}
