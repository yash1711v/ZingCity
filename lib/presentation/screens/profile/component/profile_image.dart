import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key, required this.profilePicture});
  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileStateModel>(
      //buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        // String defaultImage =
        //     context.read<AppSettingCubit>().settingModel!.setting.defaultAvatar;
        // String profileImage = profilePicture.isNotEmpty
        //     ? RemoteUrls.imageUrl(profilePicture)
        //     : RemoteUrls.imageUrl(defaultImage);

        // profileImage = state.image.isNotEmpty ? state.image : profileImage;

        // final captureImage = state.image.isNotEmpty
        //     ?state.image: RemoteUrls.imageUrl(image);

        // print('userImage: ${widget.seller.user!.image}');
        // print('fileImagesss: ${state.image}');
        return Container(
          height: 170,
          width: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: state.image.isNotEmpty
                  ? FileImage(File(state.image))
                  : NetworkImage(profilePicture),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: CustomImage(
                //     path: profileImage,
                //     height: 170,
                //     width: 170,
                //     fit: BoxFit.cover,
                //     isFile: state.image.isNotEmpty,
                //   ),
                // ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      updateCubit.imageChange(imageSourcePath!);
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      // backgroundImage: updateCubit.state.image.isNotEmpty
                      //     ? FileImage(File(updateCubit.state.image))
                      //     : null,
                      child: const Icon(
                        Icons.edit,
                        color: whiteColor,
                        size: 22.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
