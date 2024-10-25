import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/presentation/utils/utils.dart';
import '../../../../router/route_names.dart';
import '../../../../utils/constraints.dart';
import '../../../../widget/custom_images.dart';
import '../../../../widget/custom_test_style.dart';
import '/data/data_provider/remote_url.dart';
import '/logic/cubit/setting/app_setting_cubit.dart';

class SingleAgencyCard extends StatelessWidget {
  const SingleAgencyCard({super.key, required this.agency});

  final AgencyListModel agency;

  @override
  Widget build(BuildContext context) {
    final defaultImage =
        context.read<AppSettingCubit>().settingModel!.setting.defaultAvatar;
    final image = agency.profile!.image.isNotEmpty ? agency.profile!.image : defaultImage;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.agencyDetailsScreen,
            arguments: agency.id.toString());
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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3.0),
                topRight: Radius.circular(3.0),
              ),
              child: CustomImage(
                path: RemoteUrls.imageUrl(image),
                width: double.infinity,
                height: 160.0,
                fit: BoxFit.fill,
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
                          text: agency.profile!.companyName,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          maxLine: 1,
                          color: blackColor,
                        ),
                      ),
                      Utils.horizontalSpace(agency.kycStatus == 1 ? 4.0 : 0),
                      if (agency.kycStatus == 1) ...[
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFF01BF8B),
                          size: 18.0,
                        )
                      ],
                    ],
                  ),
                  CustomTextStyle(
                    text: agency.profile!.tagLine.isNotEmpty
                        ? agency.profile!.tagLine
                        : 'Your Designation',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                    color: grayColor,
                    maxLine: 1,
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
