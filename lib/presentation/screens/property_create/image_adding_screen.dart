import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/data/data_provider/remote_url.dart';
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
    final pickedFiles = await _picker.pickMultiImage(
      limit: 10,
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      int totalSelected = sliderImages.length + pickedFiles.length;

      if (totalSelected > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only select up to 10 images.'),
          ),
        );
        return;
      }

      setState(() {
        sliderImages.addAll(pickedFiles.map((file) => File(file.path)));
      });

      context.read<AddPropertyCubit>().addSliders(List<File>.from(sliderImages));
    }
  }


  void removeThumbnailImage() {
    setState(() {
      thumbnailImage = null;
    });
    context.read<AddPropertyCubit>().addThumbNails('');
  }

  void removeSliderImage(int index) {
    setState(() {
      sliderImages.removeAt(index);
    });
    context.read<AddPropertyCubit>().addSliders(List<File>.from(sliderImages));
  }

  @override
  void initState() {
    super.initState();
    final cubitState = context.read<AddPropertyCubit>().state;

    thumbnailImage = cubitState.thumbNailImage.isNotEmpty
        ? File(cubitState.thumbNailImage)
        : null;
     debugPrint("Length of slider images: ${cubitState.sliderImages.length}");
    sliderImages = List<File>.from(cubitState.sliderImages);
    debugPrint('https://lab6.invoidea.in/zingcity/${thumbnailImage?.path.toString()}');
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
                  Text(
                    'Thumbnail Image',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
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
                          if (thumbnailImage?.path  != null)
                            Stack(
                              children: [
                                thumbnailImage?.path is String &&
                                    (thumbnailImage?.path as String).startsWith('uploads/')
                                    ? Image.network(
                                  'https://lab6.invoidea.in/zingcity/${thumbnailImage?.path.toString()}',
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                )
                                    : Image.file(
                                  thumbnailImage as File,
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: removeThumbnailImage,
                                  ),
                                ),
                              ],
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
                  Text(
                    'More Images',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
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
                            'Add Images',
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
                              children: sliderImages.asMap().entries.map((entry) {
                                final index = entry.key;
                                final image = entry.value;
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: image?.path is String &&
                                          (image?.path as String).startsWith('uploads/')
                                          ? Image.network(
                                        'https://lab6.invoidea.in/zingcity/${image?.path.toString()}',
                                        width: screenWidth,
                                        fit: BoxFit.cover,
                                      )
                                          :


                                      Image.file(
                                        image,
                                        width: screenWidth / 3 - 16,
                                        height: screenWidth / 3 - 16,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => removeSliderImage(index),
                                      ),
                                    ),
                                  ],
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