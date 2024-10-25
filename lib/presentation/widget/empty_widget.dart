import 'package:flutter/material.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import 'custom_images.dart';
import 'custom_test_style.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
    required this.title,
    this.isSliver = false,
  });

  final String title;
  final String icon;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverToBoxAdapter(child: _emptyColum());
    } else {
      return _emptyColum();
    }
  }

  Widget _emptyColum() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomImage(path: icon),
        const SizedBox(height: 10.0),
        CustomTextStyle(
            text: title, fontSize: 24.0, fontWeight: FontWeight.w500),
      ],
    );
  }
}
