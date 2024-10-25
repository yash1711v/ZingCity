import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.logo, required this.image});

  final String logo;
  final String image;

  @override
  Widget build(BuildContext context) {
    final login = context.read<LoginBloc>();
    final profile = context.read<ProfileCubit>();
    return Container(
      height: 80.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            path: RemoteUrls.imageUrl(logo),
            height: 45.0,
            width: 120.0,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (login.userInfo!.user.ownerId == 0) {
                    Navigator.pushNamed(
                        context, RouteNames.premiumMembershipScreen);
                  } else {
                    Utils.showCustomDialog(context,
                        barrierDismissible: true,
                        child: const SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: CustomTextStyle(
                                text: "Only Your Agency Can Buy a Plan.",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: redColor,
                              ))
                            ],
                          ),
                        ));
                  }
                },
                child: Container(
                  height: 50.0,
                  width: 110.0,
                  margin: const EdgeInsets.only(right: 14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: whiteColor, width: 2.0),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: CustomTextStyle(
                        text: 'Buy Plan',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (login.userInfo != null &&
                      login.userInfo!.accessToken.isNotEmpty &&
                      profile.users != null) {
                    Navigator.pushNamed(context, RouteNames.updateProfileScreen,
                        arguments: profile.users);
                  } else {
                    Utils.showSnackBarWithLogin(context);
                  }
                },
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
                      path: RemoteUrls.imageUrl(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
