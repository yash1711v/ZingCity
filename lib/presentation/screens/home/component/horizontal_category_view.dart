import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate/data/model/product/property_item_model.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/category/home_category_model.dart';
import '../../../router/route_names.dart';
import 'headline_text.dart';
import 'single_category_circle.dart';

class HorizontalCategoryView extends StatelessWidget {
  const HorizontalCategoryView({super.key, required this.category});

  final List<PropertyItemModel> category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineText(
          text: 'Featured Properties',
          onTap: () =>
              Navigator.pushNamed(context, RouteNames.allCategoryScreen),
        ),
        SizedBox(
          width: double.infinity,
          height: 174.69,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 0),
              shrinkWrap: true,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.purchaseDetailsScreen,
                          arguments: index.toString());
                    },
                    child: Container(
                      width: 350,
                      height: 174.69,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "${RemoteUrls.rootUrl}${category[index].thumbnailImage}"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 42.08,
                                  decoration: ShapeDecoration(
                                    color: Colors.black
                                        .withOpacity(0.6000000238418579),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                category[index].title,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_sharp,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                category[index].address,
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(
                                                          0.699999988079071),
                                                  fontSize: 10,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
