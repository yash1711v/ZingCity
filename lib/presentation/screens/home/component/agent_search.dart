import 'package:flutter/material.dart';

import '/presentation/router/route_names.dart';
import '/presentation/widget/custom_test_style.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';

class AgentSearch extends StatelessWidget {
  final ValueChanged<String>
      onSearchChanged; // Callback to notify the search query

  const AgentSearch({
    super.key,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              child: Container(
                height: 52.0,
                padding: const EdgeInsets.only(left: 14.0),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: borderWithOpacityColor,
                  border: Border.all(color: whiteColor),
                ),
                child: Row(
                  children: [
                    const CustomImage(
                      path: KImages.searchIcon,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: TextField(
                        onChanged: onSearchChanged,
                        // Trigger callback when text changes
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Here...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
