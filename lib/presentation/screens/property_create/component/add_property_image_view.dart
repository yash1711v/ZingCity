import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/edit_info/existing_slider.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';
import '../../../widget/form_header_title.dart';
import '../../../widget/item_add_delete_btn.dart';

class AddPropertyImageView extends StatefulWidget {
  const AddPropertyImageView({super.key});

  @override
  State<AddPropertyImageView> createState() => _AddPropertyImageViewState();
}

class _AddPropertyImageViewState extends State<AddPropertyImageView> {
  late DeleteInfoCubit deleteCubit;

  // NearestLocationModel? model;

  _initState() {
    deleteCubit = context.read<DeleteInfoCubit>();
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addProperty = context.read<AddPropertyCubit>();
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
        builder: (context, state) {
      // final existImage = addProperty.state.tempGalleryImage.isNotEmpty
      //     ? addProperty.state.tempGalleryImage
      //     : state.galleryImage;

      // //print('existImage $existImage');
      // final pickImage =
      //     state.galleryImage.isNotEmpty ? state.galleryImage : existImage;
      //print('pickImage ${state.galleryImage}');
      return Container(
        //padding: Utils.symmetric(h: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.black),
        ),
        child: Column(
          children: [
            const FormHeaderTitle(title: "Gallery Image"),
            const AdditionalImageView(),
            if (state.galleryImage.isNotEmpty) ...[
              Padding(
                padding: Utils.symmetric(h: 0.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  spacing: 10.0,
                  children: List.generate(
                    state.galleryImage.length,
                    (index) {
                      return _buildGalleryImages(addProperty, index);
                    },
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    final image = await Utils.pickMultipleImage();
                    if (image.isNotEmpty) {
                      for (int i = 0; i < image.length; i++) {
                        if (image[i].isNotEmpty) {
                          final slider = ExistingSlider(
                              id: 0, propertyId: 0, image: image[i]);
                          addProperty.addGalleryImage(slider);
                        }
                      }
                    }
                  },
                  child: const ItemAddBtn(title: 'Add More Image')),
            ] else ...[
              GestureDetector(
                onTap: () async {
                  final image = await Utils.pickMultipleImage();
                  if (image.isNotEmpty) {
                    for (int i = 0; i < image.length; i++) {
                      if (image[i].isNotEmpty) {
                        final slider = ExistingSlider(
                            id: 0, propertyId: 0, image: image[i]);
                        addProperty.addGalleryImage(slider);
                      }
                    }
                  }
                },
                child: Container(
                  height: Utils.hSize(70.0),
                  margin: Utils.symmetric(v: 16.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image_outlined,
                        color: primaryColor,
                      ),
                      Utils.horizontalSpace(5.0),
                      const CustomTextStyle(
                        text: "Add Gallery Image",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildGalleryImages(AddPropertyCubit addProperty, int index) {
    final item = addProperty.state.galleryImage[index].image;
    String sliderImage = item.isEmpty ? KImages.placeholderImage : item;
    bool isSliderFile = item.isNotEmpty
        ? item.contains('https://')
            ? false
            : true
        : false;
    return Stack(
      children: [
        Container(
          height: 80.0,
          margin: Utils.symmetric(v: 6.0, h: 0.0),
          width: 106.0,
          child: ClipRRect(
            borderRadius: Utils.borderRadius(r: 6.0),
            child: CustomImage(
              path: sliderImage,
              isFile: isSliderFile,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 4,
          top: 10,
          child: InkWell(
            onTap: () async {
              final image = await Utils.pickSingleImage();
              if (image != null && image.isNotEmpty) {
                final slider = addProperty.state.galleryImage[index]
                    .copyWith(image: image);
                addProperty.updateGalleryImage(index, slider);
              }
            },
            child: const CircleAvatar(
              maxRadius: 10.0,
              backgroundColor: Color(0xff18587A),
              child: Icon(Icons.edit, color: Colors.white, size: 12.0),
            ),
          ),
        ),
        Positioned(
          right: 4,
          top: 10,
          child: InkWell(
            onTap: () {
              final itemId = addProperty.state.galleryImage[index].id;
              if (itemId > 0) {
                //print('exis-itemId $itemId');
                deleteCubit.deleteSliderImage(itemId.toString());
              }
              addProperty.deleteGalleryImage(index);
            },
            child: const CircleAvatar(
              maxRadius: 10.0,
              backgroundColor: Color(0xff18587A),
              child: Icon(Icons.delete, color: Colors.red, size: 12.0),
            ),
          ),
        )
      ],
    );
  }
}

class AdditionalImageView extends StatelessWidget {
  const AdditionalImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceCubit = context.read<AddPropertyCubit>();
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        final existImage = serviceCubit.state.tempImage.isNotEmpty
            ? serviceCubit.state.tempImage
            : state.image;

        final pickImage = state.image.isNotEmpty ? state.image : existImage;
        // print('pickImage $pickImage');
        final edit = state.addState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state.image.isEmpty && state.tempImage.isEmpty) ...[
              GestureDetector(
                onTap: () async {
                  final image = await Utils.pickSingleImage();
                  if (image!.isNotEmpty) {
                    serviceCubit.propertyImage(image);
                  }
                },
                child: Container(
                  height: Utils.hSize(70.0),
                  margin: Utils.symmetric(v: 16.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.15),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.image_outlined,
                        color: primaryColor,
                      ),
                      Utils.horizontalSpace(5.0),
                      const CustomTextStyle(
                        text: "Browser Image",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              )
            ] else ...[
              Stack(
                children: [
                  Container(
                    height: Utils.hSize(180.0),
                    margin: Utils.symmetric(v: 16.0, h: 8.0),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: Utils.borderRadius(),
                      child: CustomImage(
                        path: pickImage,
                        // path: state.thumbnailImage,
                        isFile: state.image.isNotEmpty,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 20,
                    child: InkWell(
                      onTap: () async {
                        final path = await Utils.pickSingleImage();
                        if (path != null && path.isNotEmpty) {
                          serviceCubit.propertyImage(path);
                        }
                      },
                      child: const CircleAvatar(
                        maxRadius: 16.0,
                        backgroundColor: Color(0xff18587A),
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 20.0),
                      ),
                    ),
                  )
                ],
              )
            ],
            if (edit is AddPropertyFormError) ...[
              if (edit.errors.thumbnailImage.isNotEmpty)
                ErrorText(text: edit.errors.thumbnailImage.first),
            ]
          ],
        );
      },
    );
  }
}
