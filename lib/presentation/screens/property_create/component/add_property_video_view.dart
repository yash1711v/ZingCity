import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/form_header_title.dart';
import '../../profile/component/person_single_property.dart';

class AddPropertyVideoView extends StatefulWidget {
  const AddPropertyVideoView({super.key});

  @override
  State<AddPropertyVideoView> createState() => _AddPropertyVideoViewState();
}

class _AddPropertyVideoViewState extends State<AddPropertyVideoView> {
  late AddPropertyCubit addProperty;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        final imageItem = state.propertyVideoDto.videoThumbnail;
        final thumbImage =
            imageItem.isEmpty ? KImages.placeholderImage : imageItem;

        bool isFile = imageItem.isNotEmpty
            ? imageItem.contains('https://')
                ? false
                : true
            : false;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              const FormHeaderTitle(title: "Property Video"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextStyle(text: "Video Thumbnail Image"),
                    Utils.verticalSpace(14.0),
                    Container(
                      height: 170.h,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5F4FF),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 0.2,
                            color: Colors.grey,
                          )),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CustomImage(
                                path: thumbImage,
                                // height: imageItem.isEmpty ? 60 : 170,
                                width: imageItem.isNotEmpty
                                    ? double.infinity
                                    : 100.0,
                                fit: BoxFit.cover,
                                isFile: isFile,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final image = await Utils.pickSingleImage();
                                if (image != null && image.isNotEmpty) {
                                  final pImage = state.propertyVideoDto
                                      .copyWith(videoThumbnail: image);
                                  addProperty.addVideoSection(pImage);
                                }
                              },
                              child: const EditBtn(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Utils.verticalSpace(16),
                    _buildVideoIdField(state),
                    Utils.verticalSpace(16),
                    _buildVideoDescriptionField(state),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoDescriptionField(AddPropertyModel state) {
    return TextFormField(
      onChanged: (value) {
        final videoTitle =
            state.propertyVideoDto.copyWith(videoDescription: value);
        addProperty.addVideoSection(videoTitle);
      },
      initialValue: state.propertyVideoDto.videoDescription,
      decoration: const InputDecoration(
          hintText: 'Video Description *',
          labelText: 'Video Description *',
          hintStyle: TextStyle(color: Colors.black38),
          labelStyle: TextStyle(
            color: Colors.black38,
          )),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildVideoIdField(AddPropertyModel state) {
    return TextFormField(
      initialValue: state.propertyVideoDto.videoId,
      onChanged: (value) {
        final videoTitle = state.propertyVideoDto.copyWith(videoId: value);
        addProperty.addVideoSection(videoTitle);
      },
      decoration: const InputDecoration(
          hintText: 'Video Id *',
          labelText: 'Video Id *',
          hintStyle: TextStyle(color: Colors.black38),
          labelStyle: TextStyle(
            color: Colors.black38,
          )),
      keyboardType: TextInputType.text,
    );
  }
}
