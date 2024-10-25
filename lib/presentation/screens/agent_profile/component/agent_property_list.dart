import 'package:flutter/material.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';

import '../../../utils/k_images.dart';
import '/presentation/widget/custom_test_style.dart';
import '../../../../data/model/agent/agent_single_property_model.dart';
import '../../../router/route_names.dart';
import 'agent_single_property.dart';

class AgentPropertyList extends StatelessWidget {
  const AgentPropertyList({super.key, required this.properties});
  final List<AgentSingleProperty> properties;

  @override
  Widget build(BuildContext context) {
    print('llll ${properties.length}');
    if (properties.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const CustomTextStyle(text: 'My Listing', fontSize: 18,fontWeight: FontWeight.w600,),
        ListView.builder(
        itemCount: properties.length,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, RouteNames.propertyDetailsScreen,
                arguments: properties[index].slug),
            child: AgentProperty(property: properties[index]),
          ),
        ),
        ],),
      );
    } else {
      return  const Center(
        child: Column(children: [
          SizedBox(height: 30.0,),
          CustomImage(path: KImages.emptyIcon, height: 50,),
          SizedBox(height: 10.0,),
          CustomTextStyle(text: 'No Listing', fontSize: 24,fontWeight: FontWeight.w500,)
        ],)
      );
    }
  }
}
