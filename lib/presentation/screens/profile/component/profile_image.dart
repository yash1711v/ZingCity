import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../state_inject_package_names.dart';
import '../../../utils/constraints.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key, required this.profilePicture});
  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileStateModel>(
      builder: (context, state) {
        return Container(
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: (state.image ?? File("")).path.isNotEmpty
                  ? FileImage(File(state.image!.path))
                  : NetworkImage(RemoteUrls.rootUrl + "/" + profilePicture) as ImageProvider,
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
                Positioned(
                  right: 130,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        updateCubit.imageChange(File(image.path));
                        print('File Name: ${image.name}');
                        print('File Path: ${image.path}');
                      } else {
                        print('No image selected.');
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
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