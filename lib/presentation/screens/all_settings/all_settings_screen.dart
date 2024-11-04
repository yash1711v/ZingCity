import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/profile/profile_state_model.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/utils/utils.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/booking/booking_cubit.dart';
import '../../../logic/cubit/kyc/kyc_cubit.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import '../../widget/error_text.dart';
import '../../widget/heading_dialog.dart';
import '../../widget/loading_widget.dart';
import 'component/single_elements.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 500,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: 10,
              itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0,left: 16,right: 16),
              child: Container(
                padding: const EdgeInsets.only(bottom: 4.46),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: Size.infinite.width,
                      height: 248.99,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                              "assets/Yash/images/properties_near_1.png"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            'Modern Green',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_sharp,
                            size: 10,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 6.0),
                            child: SizedBox(
                              width: 141,
                              child: Text(
                                'A7, 180C, Mayur Vihar, New Delhi',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(
                                      0.699999988079071),
                                  fontSize: 10,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹ 80 Lac',
                            style: TextStyle(
                              color: Color(0xFF30469A),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  editProfileDialog(BuildContext context) {
    const spacer = SizedBox(height: 12.0);
    Utils.showCustomDialog(
      context,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTextStyle(
                    text: 'Update your profile',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: blackColor,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomImage(path: KImages.cancelIcon))
                ],
              ),
              const SizedBox(height: 14.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.name,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              spacer,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                  text: 'Update Profile',
                  onPressed: () => Navigator.of(context).pop(),
                  textColor: blackColor,
                  fontSize: 20.0,
                  borderRadiusSize: radius,
                  bgColor: yellowColor)
            ],
          ),
        ),
      ),
    );
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

  deleteDialog(BuildContext context) {
    // final bloc = context.read<LoginBloc>();
    final loginBloc = context.read<ProfileCubit>();
    Utils.showCustomDialog(
      hp: 20.0,
      context,
      child: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeading(
              title: 'Account Delete',
              onTap: () {
                Navigator.of(context).pop();
                loginBloc.clear();
              },
            ),
            BlocBuilder<ProfileCubit, ProfileStateModel>(
              builder: (context, state) {
                final validate = state.profileState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (String password) =>
                          loginBloc.currentPassword(password),
                      decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: Utils.borderRadius(),
                          //   borderSide: const BorderSide(color: primaryColor),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: Utils.borderRadius(),
                          //   borderSide: const BorderSide(color: primaryColor),
                          // ),
                          // border: OutlineInputBorder(
                          //   borderRadius: Utils.borderRadius(),
                          //   borderSide: const BorderSide(color: primaryColor),
                          // ),
                          hintText: 'Your Password',
                          filled: true,
                          //fillColor: scaffoldBgColor,
                          suffixIcon: IconButton(
                            splashRadius: 16.0,
                            onPressed: () => loginBloc.showPassword(),
                            icon: Icon(
                                state.showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: grayColor),
                          )),
                      initialValue: state.currentPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: state.showPassword,
                    ),
                    if (validate is ProfileUpdateFormValidate) ...[
                      if (validate.error.currentPassword.isNotEmpty)
                        ErrorText(text: validate.error.currentPassword.first),
                    ]
                  ],
                );
              },
            ),
            Utils.verticalSpace(20.0),
            BlocConsumer<ProfileCubit, ProfileStateModel>(
              listener: (context, state) {
                final validate = state.profileState;
                if (validate is AccountDeleteError) {
                  Navigator.pop(context);
                  Utils.errorSnackBar(context, validate.message);
                } else if (validate is AccountDeleted) {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.loginScreen, (route) => false);
                  Utils.showSnackBar(context, validate.message);
                  //bloc.add(const LoginEventClearUserCredential());
                }
              },
              builder: (context, state) {
                final validate = state.profileState;
                if (validate is AccountDeleting) {
                  return const LoadingWidget();
                }
                final isNotEmpty = state.currentPassword.trim().isNotEmpty;
                return PrimaryButton(
                    text: isNotEmpty ? 'Delete Account' : 'Delete Account',
                    bgColor: isNotEmpty ? redColor : grayColor,
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      if (isNotEmpty) {
                        loginBloc.deleteAccount();
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  String? userImage;

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>().settingModel!.setting;
    final loginBloc = context.read<LoginBloc>();
    final profile = context.read<ProfileCubit>();
    final users = context.read<ProfileCubit>();
    if (users.users != null) {
      userImage = users.users!.image.isNotEmpty
          ? RemoteUrls.imageUrl(users.users!.image)
          : RemoteUrls.imageUrl(appSetting.defaultAvatar);
    } else {
      userImage = RemoteUrls.imageUrl(appSetting.defaultAvatar);
    }
    return AppBar(
      toolbarHeight: 100.0,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: SizedBox(
                height: 50.0,
                //width: 100.0,
                child: CustomImage(
                  //path: KImages.logo3,
                  path: RemoteUrls.imageUrl(appSetting.logo),
                  fit: BoxFit.cover,
                  color: whiteColor,
                )),
          ),
          GestureDetector(
            onTap: () {
              if (loginBloc.userInfo != null &&
                  loginBloc.userInfo!.accessToken.isNotEmpty &&
                  profile.users != null) {
                Navigator.pushNamed(
                    context, RouteNames.updateProfileScreen,
                    arguments: profile.users);
              } else {
                Utils.showSnackBarWithLogin(context);
              }
            },
            // onTap: () {
            //   if (loginBloc.userInfo != null &&
            //       loginBloc.userInfo!.accessToken.isNotEmpty) {
            //     Navigator.pushNamed(context, RouteNames.updateProfileScreen);
            //   } else {
            //     Utils.showSnackBarWithLogin(context);
            //   }
            //   // Navigator.pushNamed(context, RouteNames.profileScreen);
            // },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: whiteColor, width: 2.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CustomImage(
                  // path: KImages.profilePicture,
                  path: userImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
    );
  }
}
