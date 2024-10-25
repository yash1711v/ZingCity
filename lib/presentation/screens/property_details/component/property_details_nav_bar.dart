import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/booking/booking_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/create_property/cities_model.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/contact_button.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/primary_button.dart';
import 'date_time_view.dart';

class PropertyDetailNavBar extends StatelessWidget {
  const PropertyDetailNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.read<LoginBloc>();
    void getErrorMessage() {
      return Utils.showSnackBar(context, 'WhatsApp is not installed yet!');
    }

    return BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
      builder: (context, state) {
        if (state is PropertyDetailsLoaded) {
          final agent = state.singlePropertyModel.propertyAgent;
          return Container(
            width: size.width,
            // height: 190.0,
            height: 230.0,
            padding: const EdgeInsets.only(bottom: 5.0),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Align(
                //   alignment: Alignment.center,
                //   child: GestureDetector(
                //     onTap: () {
                //       if (loginBloc.userInfo != null &&
                //           loginBloc.userInfo!.accessToken.isNotEmpty) {
                //         context.read<BookingCubit>().clear();
                //         Navigator.pushNamed(
                //             context, RouteNames.createBookingScreen);
                //       } else {
                //         Utils.showSnackBarWithLogin(context);
                //       }
                //     },
                //     // onTap: () => _bookingDialog(context),
                //     child: Container(
                //      // margin: const EdgeInsets.symmetric(horizontal: 20.0),
                //      //  padding: const EdgeInsets.symmetric(
                //      //      horizontal: 22.0, vertical: 12.0),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: whiteColor),
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(4.0)),
                //       ),
                //       child: const CustomTextStyle(
                //         text: 'Booking',
                //         color: whiteColor,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 18.0,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: Utils.symmetric(h: 20.0),
                  child: PrimaryButton(
                      bgColor: yellowColor,
                      textColor: blackColor,
                      text: "Book Now", onPressed: (){
                    if (loginBloc.userInfo != null &&
                        loginBloc.userInfo!.accessToken.isNotEmpty) {
                      context.read<BookingCubit>().clear();
                      Navigator.pushNamed(
                          context, RouteNames.createBookingScreen);
                    } else {
                      Utils.showSnackBarWithLogin(context);
                    }
                  }),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //           horizontal: 20.0, vertical: 12.0)
                //       .copyWith(bottom: 0.0),
                //   child: const DottedLine(
                //     direction: Axis.horizontal,
                //     alignment: WrapAlignment.center,
                //     lineLength: double.infinity,
                //     lineThickness: 1.0,
                //     dashLength: 4.0,
                //     dashGapLength: 6.0,
                //     dashGapColor: transparent,
                //     dashColor: whiteColor,
                //   ),
                // ),
                Utils.verticalSpace(6.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 14.0)
                      .copyWith(top: 4.0),
                  // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0).copyWith(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(agent!.image),
                          height: size.height * 0.08,
                          width: size.height * 0.08,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: CustomTextStyle(
                                    text: agent.name,
                                    fontSize: 20.0,
                                    maxLine: 1,
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor,
                                  ),
                                ),
                                Utils.horizontalSpace(
                                    agent.kycStatus == 1 ? 4.0 : 0),
                                if (agent.kycStatus == 1) ...[
                                  const Icon(
                                    Icons.verified_rounded,
                                    color: Color(0xFF01BF8B),
                                    size: 18.0,
                                  )
                                ],
                              ],
                            ),
                            CustomTextStyle(
                              text: agent.designation,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ContactButton(
                    //   onPressed: () {
                    //     if (loginBloc.userInfo != null &&
                    //         loginBloc.userInfo!.accessToken.isNotEmpty) {
                    //       Navigator.pushNamed(
                    //           context, RouteNames.sendMessageScreen,
                    //           arguments: agent.email);
                    //     } else {
                    //       Utils.showSnackBarWithLogin(context);
                    //     }
                    //   },
                    //   bgColor: whiteColor,
                    //   text: 'Message',
                    //   icon: KImages.messageIcon,
                    //   iconTextColor: blackColor,
                    // ),
                   GestureDetector(
                     onTap: (){
                       if (loginBloc.userInfo != null &&
                               loginBloc.userInfo!.accessToken.isNotEmpty) {
                             Navigator.pushNamed(
                                 context, RouteNames.sendMessageScreen,
                                 arguments: agent.email);
                           } else {
                             Utils.showSnackBarWithLogin(context);
                           }
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(8.0),
                         color: whiteColor
                       ),
                       child: Padding(
                         padding: Utils.symmetric(h: 30.0, v: 10.0),
                         child: Row(children: [
                             const CustomImage(path: KImages.messageIcon),
                             Utils.horizontalSpace(8.0),
                             const CustomTextStyle(text: "Message",fontSize: 16.0,fontWeight: FontWeight.w500,),
                         ],),
                       ),
                     ),
                   ),

                    GestureDetector(
                      onTap: ()async{
                        if (loginBloc.userInfo != null &&
                            loginBloc.userInfo!.accessToken.isNotEmpty) {
                          //Uri uri = Uri(scheme: 'call', path: agent.phone);
                          final android =
                              "whatsapp://send?phone=${agent.phone}&text=Hello, ${agent.name} ";
                          final ios =
                              "https://wa.me/${agent.phone}?text=${Uri.parse('Hello, I need your help')}";
                          final androidUrl = Uri.parse(android);
                          final iosUrl = Uri.parse(ios);
                          try {
                            if (agent.phone.isNotEmpty) {
                              if (Platform.isIOS) {
                                await launchUrl(iosUrl,
                                mode: LaunchMode.externalApplication);
                              } else {
                                await launchUrl(androidUrl,
                                mode: LaunchMode.externalApplication);
                              }
                            } else {
                              Utils.showSnackBar(
                                  context, 'Phone number is not available');
                            }
                          } catch (e) {
                            debugPrint('exception-occurred ${e.toString()}');
                            getErrorMessage();
                          }
                        } else {
                          Utils.showSnackBarWithLogin(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xFF00bc144),
                        ),
                        child: Padding(
                          padding: Utils.symmetric(h: 30.0, v: 10.0),
                          child: Row(children: [
                            const CustomImage(path: KImages.whatsAppIcon,color: whiteColor,height: 20,),
                            Utils.horizontalSpace(8.0),
                            const CustomTextStyle(text: "What\'s App",fontSize: 16.0,fontWeight: FontWeight.w500,color: whiteColor,),
                          ],),
                        ),
                      ),
                    ),


                    // ContactButton(
                    //   onPressed: () async {
                    //     if (loginBloc.userInfo != null &&
                    //         loginBloc.userInfo!.accessToken.isNotEmpty) {
                    //       //Uri uri = Uri(scheme: 'call', path: agent.phone);
                    //       final android =
                    //           "whatsapp://send?phone=${agent.phone}&text=Hello, ${agent.name} ";
                    //       final ios =
                    //           "https://wa.me/${agent.phone}?text=${Uri.parse('Hello, I need your help')}";
                    //       final androidUrl = Uri.parse(android);
                    //       final iosUrl = Uri.parse(ios);
                    //       try {
                    //         if (agent.phone.isNotEmpty) {
                    //           if (Platform.isIOS) {
                    //             await launchUrl(iosUrl,
                    //                 mode: LaunchMode.externalApplication);
                    //           } else {
                    //             await launchUrl(androidUrl,
                    //                 mode: LaunchMode.externalApplication);
                    //           }
                    //         } else {
                    //           Utils.showSnackBar(
                    //               context, 'Phone number is not available');
                    //         }
                    //       } catch (e) {
                    //         debugPrint('exception-occurred ${e.toString()}');
                    //         getErrorMessage();
                    //       }
                    //     } else {
                    //       Utils.showSnackBarWithLogin(context);
                    //     }
                    //   },
                    //   bgColor: const Color(0xFF0bc144),
                    //   text: 'What\'s App',
                    //   icon: KImages.whatsAppIcon,
                    //   iconTextColor: whiteColor,
                    // ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

// _bookingDialog(BuildContext context) {
//   final cubit = context.read<CreateInfoCubit>();
//   const spacer = SizedBox(height: 10.0);
//   Utils.showCustomDialog(
//     context,
//     hp: 16.0,
//     child: SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const CustomTextStyle(
//                   text: 'Booking',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.0,
//                   color: blackColor,
//                 ),
//                 GestureDetector(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: const CustomImage(path: KImages.cancelIcon))
//               ],
//             ),
//             const SizedBox(height: 14.0),
//             const DateTimeView(),
//             spacer,
//             DropdownButtonFormField<CitiesModel>(
//               isDense: true,
//               isExpanded: true,
//               //value: citiesModel,
//               decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: borderWithOpacityColor,
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: borderColor),
//                 ),
//               ),
//               hint: const CustomTextStyle(
//                 text: 'Select City',
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16.0,
//               ),
//               icon: const Icon(Icons.keyboard_arrow_down_sharp,
//                   color: blackColor),
//               items: cubit.createPropertyInfo!.cities!
//                   .map<DropdownMenuItem<CitiesModel>>(
//                     (e) => DropdownMenuItem(
//                       value: e,
//                       child: CustomTextStyle(
//                         text: e.name,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   )
//                   .toList(),
//               onChanged: (val) {},
//             ),
//             spacer,
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Name'),
//               keyboardType: TextInputType.name,
//             ),
//             spacer,
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             spacer,
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Phone'),
//               keyboardType: TextInputType.phone,
//             ),
//             spacer,
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Description'),
//               keyboardType: TextInputType.multiline,
//               maxLines: 4,
//             ),
//             const SizedBox(height: 20.0),
//             PrimaryButton(
//                 text: 'Confirm Booking',
//                 onPressed: () => Navigator.of(context).pop(),
//                 textColor: blackColor,
//                 fontSize: 20.0,
//                 borderRadiusSize: radius,
//                 bgColor: yellowColor)
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
