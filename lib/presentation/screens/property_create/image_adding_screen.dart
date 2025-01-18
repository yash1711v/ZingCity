import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_cubit.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

class ImageAddingScreen extends StatefulWidget {
  const ImageAddingScreen({super.key});

  @override
  _ImageAddingScreenState createState() => _ImageAddingScreenState();
}

class _ImageAddingScreenState extends State<ImageAddingScreen> {
  File? thumbnailImage;
  List<File> sliderImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickThumbnailImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        thumbnailImage = File(pickedFile.path);
      });
      context.read<AddPropertyCubit>().addThumbNails(thumbnailImage!.path);
    }
  }

  Future<void> pickSliderImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        // Create a new modifiable list by combining the existing and newly picked images
        sliderImages = [
          ...sliderImages,
          ...pickedFiles.map((file) => File(file.path))
        ];
      });
      context.read<AddPropertyCubit>().addSliders(List<File>.from(sliderImages));
    }
  }

  @override
  void initState() {
    super.initState();
    final cubitState = context.read<AddPropertyCubit>().state;

    thumbnailImage = cubitState.thumbNailImage.isNotEmpty
        ? File(cubitState.thumbNailImage)
        : null;

    // Ensure sliderImages is initialized as a modifiable list
    sliderImages = List<File>.from(cubitState.sliderImages);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
  builder: (context, state) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Container: Add Thumbnail Image
              GestureDetector(
                onTap: pickThumbnailImage,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [


                      if (thumbnailImage != null)
                        Image.file(
                          thumbnailImage!,
                          width: screenWidth,
                          fit: BoxFit.cover,
                        )
                      else
                        Column(
                          children: [
                            const Icon(Icons.image, size: 50, color: Colors.grey),
                            const SizedBox(height: 8),
                            const Text(
                              'Add Thumbnail Image',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Second Container: Add Slider Images
              GestureDetector(
                onTap: pickSliderImages,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Add Slider Images',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (sliderImages.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: sliderImages.map((image) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                image,
                                width: screenWidth / 3 - 16,
                                height: screenWidth / 3 - 16,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        )
                      else
                        const Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
