import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/data/model/auth/user_login_response_model.dart';
import 'package:real_estate/presentation/router/route_names.dart';

import '../../../data/model/auth/user_profile_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_images.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/error_text.dart';
import '../../widget/primary_button.dart';
import '../home/home_screen.dart';
import 'component/profile_image.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.profile});

  final dynamic profile;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    getExitingProfileData();
    super.initState();
  }

  getExitingProfileData() {
    debugPrint("fvf${widget.profile.phone}");
    final profile = context.read<ProfileCubit>();
    profile.nameChange(widget.profile.name ?? "");
    profile.phoneChange(widget.profile.phone ?? "");
    profile.addressChange(widget.profile.address ?? "");
    // profile.designationChange(widget.profile.designation ?? "");
    profile.aboutMeChange(widget.profile.address ?? "");
    profile.emailChange(widget.profile.email ?? "");
    // profile.instagramChange(widget.profile.instagram ?? "");
    // profile.twitterChange(widget.profile.twitter ?? "");
    // profile.linkedinChange(widget.profile.linkedin ?? "");
  }

  final _className = "UpdateProfileScreen";
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    //print('nameeee ${widget.profile.name}');
    final spacer = Utils.verticalSpace(20.0);
    final profileCubit = context.read<ProfileCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: widget.profile.name == null ? "Register" : 'Update Profile',
      ),
      body: BlocListener<ProfileCubit, ProfileStateModel>(
        listener: (context, state)
        {
          final update = state.profileState;
          // if (update is ProfileUpdateLoading) {
          //   log(_className, name: update.toString());
          // } else if (update is ProfileUpdateError) {
          //   Utils.errorSnackBar(context, update.message);
          // } else if (update is ProfileUpdateLoaded) {
          //   Navigator.of(context).pop();
          //   //Utils.showSnackBar(context, update.message);
          // }

          if (update is ProfileUpdateLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (update is ProfileUpdateError) {
              if (update.statusCode == 401) {
                Utils.logout(context);
              } else {
                Utils.errorSnackBar(context, update.message);
              }
            } else if (update is ProfileUpdateLoaded) {
              // Navigator.of(context).pop();

              Utils.showSnackBar(context, update.message);
            }
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: _controller,
          children: [
            const SizedBox(height: 20.0),
            ProfileImages(profilePicture: widget.profile.image ?? ""),
            const SizedBox(height: 35.0),
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: widget.profile.name,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (String text) {
                        profileCubit.nameChange(text);
                      },
                    ),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.name.isNotEmpty)
                        ErrorText(
                          text: update.error.name.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        readOnly: true,
                        initialValue: widget.profile.phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone',
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (String text) {
                          profileCubit.phoneChange(text);
                        }),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.phone.isNotEmpty)
                        ErrorText(
                          text: update.error.phone.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final update = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        initialValue: widget.profile.address,
                        decoration: const InputDecoration(
                          hintText: 'Address',
                        ),
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (String text) {
                          profileCubit.addressChange(text);
                        }),
                    if (update is ProfileUpdateFormValidate) ...[
                      if (update.error.address.isNotEmpty)
                        ErrorText(
                          text: update.error.address.first,
                        ),
                    ]
                  ],
                );
              },
            ),
            // spacer,
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     final update = state.profileState;
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         TextFormField(
            //             initialValue:"",
            //             decoration: const InputDecoration(
            //               hintText: 'Designation',
            //             ),
            //             keyboardType: TextInputType.text,
            //             onChanged: (String text) {
            //               // profileCubit.designationChange(text),
            //             }),
            //         if (update is ProfileUpdateFormValidate) ...[
            //           if (update.error.designation.isNotEmpty)
            //             ErrorText(
            //               text: update.error.designation.first,
            //             ),
            //         ]
            //       ],
            //     );
            //   },
            // ),
            // spacer,
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     final update = state.profileState;
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         TextFormField(
            //             initialValue: widget.profile.aboutMe,
            //             decoration: const InputDecoration(
            //               hintText: 'Address',
            //             ),
            //             keyboardType: TextInputType.text,
            //             maxLines: 3,
            //             onChanged: (String text) {
            //               profileCubit.addressChange(text);
            //             }),
            //         if (update is ProfileUpdateFormValidate) ...[
            //           if (update.error.aboutMe.isNotEmpty)
            //             ErrorText(
            //               text: update.error.aboutMe.first,
            //             ),
            //         ]
            //       ],
            //     );
            //   },
            // ),
            spacer,
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: widget.profile.email,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String text) {
                    profileCubit.emailChange(text);
                  },
                  validator: (value){
                    final RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    // Test the email against the regex
                    return emailRegex.hasMatch(value ?? "") ? "Enter Valid Email":null;
                  },
                );
              },
            ),
            spacer,
            // spacer,
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     return TextFormField(
            //       initialValue: widget.profile.twitter,
            //       decoration: const InputDecoration(
            //         hintText: 'Twitter',
            //       ),
            //       keyboardType: TextInputType.url,
            //       onChanged: (String text) {
            //         // profileCubit.twitterChange(text)
            //       },
            //     );
            //   },
            // ),
            // spacer,
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     return TextFormField(
            //       initialValue: widget.profile.linkedin,
            //       decoration: const InputDecoration(
            //         hintText: 'LinkedIn',
            //       ),
            //       keyboardType: TextInputType.url,
            //       onChanged: (String text) {
            //         // profileCubit.linkedinChange(text)
            //       }
            //       ,
            //     );
            //   },
            // ),
            // spacer,
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     return TextFormField(
            //       initialValue: widget.profile.instagram,
            //       decoration: const InputDecoration(
            //         hintText: 'Instagram',
            //       ),
            //       keyboardType: TextInputType.url,
            //       onChanged: (String text) {
            //           // profileCubit.instagramChange(text),
            //       }
            //     );
            //   },
            // ),
            // const SizedBox(height: 20.0),
            // BlocBuilder<ProfileCubit, ProfileStateModel>(
            //   builder: (context, state) {
            //     final update = state.profileState;
            //     if (update is ProfileUpdateLoading) {
            //       return const LoadingWidget();
            //     }
            //     return PrimaryButton(
            //         text: 'Update Profile',
            //         onPressed: () {
            //           Utils.closeKeyBoard(context);
            //           profileCubit.updateAgentProfileInfo();
            //         });
            //   },
            // ),
            // Utils.verticalSpace(20.0),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileStateModel>(
        builder: (context, state) {
          return Container(
            margin: Utils.only(bottom: 20.0),
            padding: EdgeInsets.only(
                left: 20.0,
                right: 30.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: state.isLoading ?? false
                ? const Center(child: CircularProgressIndicator())
                : Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          text: widget.profile.name == null
                              ? "Register"
                              : 'Update Profile',
                          onPressed: () {
                            Utils.closeKeyBoard(context);
                            profileCubit.updateAgentProfileInfo(
                                name: state.name,
                                number: state.phone,
                                address: state.address,
                                description: state.aboutMe,
                                email: state.email,
                                about: state.aboutMe,
                                image: state.image ?? File(""),
                                context: context,
                                Token: widget.profile.verifyToken ?? "").then((value) async {
                                  if(value){
                                    if( widget.profile.name !=null) await setInitialLocation(context);

                                    Fluttertoast.showToast(
                                        msg: "Profile Updated Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                    Navigator.pushReplacementNamed(
                                        context, RouteNames.mainPageScreen);

                                  }
                            });
                          }),
                    ),
                    // SizedBox(width: 10.0),
                    // Expanded(
                    //   child: PrimaryButton(
                    //       text: "Log Out",
                    //       bgColor: Colors.red,
                    //       onPressed: () {
                    //         logoutDialog(context);
                    //         // Utils.closeKeyBoard(context);
                    //         // profileCubit.updateAgentProfileInfo(
                    //         //     name: state.name,
                    //         //     number: state.phone,
                    //         //     address: state.address,
                    //         //     description: state.aboutMe,
                    //         //     email: state.email,
                    //         //     about: state.aboutMe,
                    //         //     image: state.image ?? File(""),
                    //         //     context: context,
                    //         //     Token: widget.profile.verifyToken ?? "").then((value){
                    //         //       if(value){
                    //         //         Navigator.pushReplacementNamed(
                    //         //             context, RouteNames.mainPageScreen);
                    //         //       }
                    //         // });
                    //       }),
                    // ),
                  ],
                ),
          );
        },
      ),
    );
  }
}

logoutDialog(BuildContext context) {
  final loginBloc = context.read<LoginBloc>();
  Utils.showCustomDialog(
    context,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomImage(path: KImages.logoutIcon),
          const SizedBox(height: 10.0),
          const CustomTextStyle(
            textAlign: TextAlign.center,
            text: 'Are you sure\nYou want to Logout?',
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoutButton(
                  'Not Now', () => Navigator.of(context).pop(), blackColor),
              const SizedBox(width: 14.0),
              logoutButton('Logout', () {
              debugPrint("Logout");
                Navigator.of(context).pushReplacementNamed(RouteNames.loginScreen);
                loginBloc.add(const LoginEventLogout());
              }, redColor),
            ],
          )
        ],
      ),
    ),
  );
}

Widget logoutButton(String text, VoidCallback onPressed, Color bgColor) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(100.0, 40.0)),
        backgroundColor: WidgetStateProperty.all(bgColor),
        elevation: WidgetStateProperty.all(0.0),
        shadowColor: WidgetStateProperty.all(transparent),
        splashFactory: NoSplash.splashFactory,
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: borderRadius))),
    child: CustomTextStyle(
      text: text,
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      color: whiteColor,
    ),
  );
}