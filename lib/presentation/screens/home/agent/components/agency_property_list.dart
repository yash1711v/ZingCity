// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:real_estate/presentation/widget/custom_images.dart';
// import '../../../../../data/data_provider/remote_url.dart';
// import '../../../../../data/model/agency/agency_details_model.dart';
// import '../../../../../data/model/home/home_data_model.dart';
// import '../../../../router/route_names.dart';
// import '../../../../utils/constraints.dart';
// import '../../../../utils/k_images.dart';
// import '../../../../utils/utils.dart';
// import '../../../../widget/favorite_button.dart';
// import '../../../agent_profile/component/agent_single_property.dart';
// import '/presentation/widget/custom_test_style.dart';
//
//
// class AgencyPropertyList extends StatelessWidget {
//   const AgencyPropertyList({super.key, required this.properties});
//
//   final List<Properties> properties;
//
//   @override
//   Widget build(BuildContext context) {
//     print('llll ${properties.length}');
//     if (properties.isNotEmpty) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//         child: Column(
//
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomTextStyle(text: 'My Listing', fontSize: 18,fontWeight: FontWeight.w600,),
//             ListView.builder(
//               itemCount: properties.length,
//               padding: const EdgeInsets.symmetric(horizontal: 0.0),
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index) {
//                 final property = properties[index];
//                 return GestureDetector(
//                   onTap: () => Navigator.pushNamed(
//                       context, RouteNames.propertyDetailsScreen,
//                       arguments: properties[index].slug),
//
//                   child: AgencyProperty(property: property),
//                 );
//               }
//             ),
//           ],),
//       );
//     } else {
//       return   const Center(
//           child: Column(children: [
//             SizedBox(height: 30.0,),
//             CustomImage(path: KImages.emptyIcon, height: 50,),
//             SizedBox(height: 10.0,),
//             CustomTextStyle(text: 'No Listing', fontSize: 24,fontWeight: FontWeight.w500,)
//           ],)
//       );
//     }
//   }
// }
//
//
// class AgencyProperty extends StatelessWidget {
//   const AgencyProperty({super.key, required this.property});
//
//   final Properties property;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 140.0.h,
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       padding: const EdgeInsets.only(right: 10.0),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(radius),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ClipRRect(
//               borderRadius: borderRadius,
//               child: Stack(
//                 // fit: StackFit.expand,
//                 children: [
//                   CustomImage(
//                     path: RemoteUrls.imageUrl(property.thumbnailImage),
//                     height: double.infinity,
//                     width: 140.0,
//                     fit: BoxFit.cover,
//                   ),
//                   Positioned(
//                     top: 8.0,
//                     left: 8.0,
//                     child: FavoriteButton(id: property.id.toString()),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CustomTextStyle(
//                       text: Utils.formatPrice(
//                           context, property.price),
//                       color: primaryColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18.0,
//                     ),
//                     CustomTextStyle(
//                       text: property.rentPeriod.isNotEmpty
//                           ? '/${property.rentPeriod}'
//                           : property.rentPeriod,
//                       color: grayColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14.0,
//                     ),
//                   ],
//                 ),
//                 Flexible(
//                   child: CustomTextStyle(
//                     text: property.title,
//                     color: blackColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18.0,
//                     maxLine: 2,
//                     height: 1.6,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0),
//                       child: CustomImage(path: KImages.locationIcon),
//                     ),
//                     const SizedBox(width: 6.0),
//                     Flexible(
//                       child: CustomTextStyle(
//                         text: property.address,
//                         color: grayColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.0,
//                         maxLine: 2,
//                         height: 1.6,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
