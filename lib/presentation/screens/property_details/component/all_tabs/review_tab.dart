import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '/data/data_provider/remote_url.dart';
import '/logic/cubit/home/cubit/property_details_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/empty_widget.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../widget/custom_images.dart';
import '../../../../widget/custom_test_style.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  //double initialRating = 3.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final review = state.singlePropertyModel.reviews;
          if (review!.isNotEmpty) {
            return ListView.builder(
                itemCount: review.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20.0),
                itemBuilder: (context, index) {
                  final item = review[index];
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 20.0),
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: borderRadius,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: List.generate(
                                item.rating,
                                (index) => const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: CustomImage(path: KImages.starIcon),
                                ),
                              ),
                            ),
                            CustomTextStyle(
                              text: Utils.convertToAgo(item.createdAt),
                              //text: Utils.timeAgo(item.createdAt),
                              color: primaryColor,
                              fontSize: 16.0,
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        ReadMoreText(
                          item.review,
                          trimLines: 1,
                          trimLength: 60,
                          trimExpandedText: 'Show Less',
                          trimCollapsedText: 'Show More',
                          moreStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: primaryColor,
                          ),
                          lessStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: grayColor,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            ClipOval(
                              child: CustomImage(
                                //path: KImages.profilePicture,
                                path: RemoteUrls.imageUrl(item.user!.image),
                                height: size.height * 0.06,
                                width: size.height * 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextStyle(
                                  text: item.user!.name,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor,
                                ),
                                // CustomTextStyle(
                                //   text: item.user!.designation,
                                //   fontSize: 13.0,
                                //   fontWeight: FontWeight.w400,
                                //   color: grayColor,
                                // ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Center(
                child: Column(
                  children: [
                    EmptyWidget(
                        icon: KImages.emptyReview, title: 'No Review Found!'),
                    SizedBox(height: 16.0),
                    // PrimaryButton(
                    //     text: 'Submit Review',
                    //     onPressed: () => messageDialog(context,
                    //         state.singlePropertyModel.propertyItemModel!)),
                  ],
                ),
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

// messageDialog(BuildContext context, DetailsPropertyItem property) {
//   final reviewCubit = context.read<ReviewCubit>();
//   const spacer = SizedBox(height: 12.0);
//   Utils.showCustomDialog(
//     context,
//     child: SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const CustomTextStyle(
//                   text: 'Write Review',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.0,
//                   color: blackColor,
//                 ),
//                 GestureDetector(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: const CustomImage(path: KImages.cancelIcon))
//               ],
//             ),
//             spacer,
//             RatingBar.builder(
//                 itemCount: 5,
//                 initialRating: initialRating,
//                 allowHalfRating: false,
//                 glow: false,
//                 itemBuilder: (context, index) {
//                   return const Icon(Icons.star, color: yellowColor);
//                 },
//                 onRatingUpdate: (double rate) {
//                   initialRating = rate;
//                   print(initialRating);
//                 }),
//             //const SizedBox(height: 14.0),
//             // TextFormField(
//             //   decoration: const InputDecoration(hintText: 'Name'),
//             //   keyboardType: TextInputType.name,
//             // ),
//             // spacer,
//             // TextFormField(
//             //   decoration: const InputDecoration(hintText: 'Email'),
//             //   keyboardType: TextInputType.emailAddress,
//             // ),
//             // spacer,
//             // TextFormField(
//             //   decoration: const InputDecoration(hintText: 'Phone'),
//             //   keyboardType: TextInputType.phone,
//             // ),
//             spacer,
//             BlocBuilder<ReviewCubit, ReviewState>(
//               builder: (context, state) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: reviewCubit.messageController,
//                       decoration: const InputDecoration(hintText: 'Messages'),
//                       keyboardType: TextInputType.multiline,
//                       maxLines: 5,
//                     ),
//                     if (state is ReviewFieldError) ...[
//                       if (state.errors.review.isNotEmpty)
//                         ErrorText(text: state.errors.review.first)
//                     ]
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(height: 20.0),
//             BlocBuilder<ReviewCubit, ReviewState>(
//               builder: (context, state) {
//                 if (state is ReviewLoading) {
//                   return const LoadingWidget();
//                 }
//                 return PrimaryButton(
//                     text: 'Send Message',
//                     onPressed: () {
//                       // Navigator.of(context).pop();
//                       final body = {
//                         'agent_id': property.agentId.toString(),
//                         'property_id': property.id.toString(),
//                         'rating': initialRating.toStringAsFixed(0),
//                         'review': reviewCubit.messageController.text.trim(),
//                       };
//                       reviewCubit.storeReview(body);
//                     },
//                     textColor: blackColor,
//                     fontSize: 20.0,
//                     borderRadiusSize: radius,
//                     bgColor: yellowColor);
//               },
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
