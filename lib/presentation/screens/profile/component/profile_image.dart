import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
          // width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: (state.image ?? File("")).path.isNotEmpty
                  ? FileImage(File(state.image!.path))
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
                  right: 130,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        allowMultiple: false, // Ensures only one file is picked
                      );

                      if (result != null && result.files.isNotEmpty) {
                        // Get the selected file
                        PlatformFile file = result.files.first;
                        updateCubit.imageChange(File(file.path!));
                        // You can now access file properties like name, path, size, etc.
                        print('File Name: ${file.name}');
                        print('File Size: ${file.size} bytes');
                        print('File Path: ${file.path}');
                      } else {
                        // User canceled the picker
                        print('No file selected.');
                      }

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

  // Future<void> _pickFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false, // Allow multiple files to be selected
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       selectedFiles = result.paths.map((path) => File(path!)).toList();
  //     });
  //   }
  // }
}
