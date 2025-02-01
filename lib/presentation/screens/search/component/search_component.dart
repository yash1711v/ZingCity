import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/home/home_data_model.dart';
import '/data/data_provider/remote_url.dart';
import '/presentation/utils/utils.dart';
import '../../../../data/model/search_response_model/search_property_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/favorite_button.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key, required this.property});
  final Properties property;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.all(10.0).copyWith(right: 10.0),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  CustomImage(
                    path: RemoteUrls.imageUrl(property.thumbnailImage ?? ""),
                    height: double.infinity,
                    width: 140.0,
                    fit: BoxFit.cover,
                  ),
                  // Positioned(
                  //   top: 8.0,
                  //   left: 8.0,
                  //   child:Row(
                  //     children: [
                  //       FavoriteButton(id: property.id.toString()),
                  //       Utils.horizontalSpace(10.0),
                  //       AddToCompare(id:property.id.toString()),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextStyle(
                      text: (property.price ?? 0.0).toStringAsFixed(2),
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                    // CustomTextStyle(
                    //   text: property.rentPeriod.isNotEmpty
                    //       ? '/${property.rentPeriod}'
                    //       : property.rentPeriod,
                    //   color: grayColor,
                    //   fontWeight: FontWeight.w400,
                    //   fontSize: 14.0,
                    // ),
                  ],
                ),
                Flexible(
                  child: CustomTextStyle(
                    text: property.title ?? "",
                    color: blackColor,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    maxLine: 2,
                    height: 1.5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: CustomImage(path: KImages.locationIcon),
                    ),
                    const SizedBox(width: 6.0),
                    Flexible(
                      child: CustomTextStyle(
                        text: property.address ?? "",
                        textAlign: TextAlign.left,
                        color: grayColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        maxLine: 2,
                        height: 1.6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
