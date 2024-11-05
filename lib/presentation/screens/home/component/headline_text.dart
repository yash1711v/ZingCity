import 'package:flutter/cupertino.dart';

import '../../../widget/custom_test_style.dart';

class HeadlineText extends StatelessWidget {
  const HeadlineText(
      {super.key,
      required this.text,
      required this.onTap,
      this.isPadding = true});
  final String text;
  final VoidCallback onTap;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
              horizontal: isPadding ? 15.0 : 0.0, vertical: isPadding ?12.0:0)
          .copyWith(top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextStyle(
            text: text,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text('See All',
                  style: TextStyle(
                    color: Color(0xFF30469A),
                    fontSize: 18,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                )
          ),
        ],
      ),
    );
  }
}
