import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '/data/data_provider/remote_url.dart';
import '/data/model/auth/user_profile_model.dart';
import '/logic/cubit/setting/app_setting_cubit.dart';
import '../../../router/route_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';

class SingleBrokerAgentCartView extends StatelessWidget {
  const SingleBrokerAgentCartView({super.key, required this.agent});

  final UserProfileModel agent;

  @override
  Widget build(BuildContext context) {
    final defaultImage =
        context.read<AppSettingCubit>().settingModel!.setting.defaultAvatar;
    final image = agent.image.isNotEmpty ? agent.image : defaultImage;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.agentProfileScreen,
            arguments: agent.userName);
        //print(agent.userName);
      },
      child: Container(
        width: 160.0.w,
        margin: const EdgeInsets.only(right: 0.0),
         padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 165.0,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  topRight: Radius.circular(3.0),),
                child: CustomImage(
                  path: RemoteUrls.imageUrl(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      .copyWith(bottom: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextStyle(
                          text: agent.name,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          maxLine: 1,
                          color: blackColor,
                        ),
                      ),
                      Utils.horizontalSpace(agent.kycStatus == 1 ? 4.0 : 0),
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
                    text: agent.designation.isNotEmpty
                        ? agent.designation
                        : 'Your Designation',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: grayColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
