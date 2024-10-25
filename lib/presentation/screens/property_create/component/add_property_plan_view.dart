import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/property_plan_dto.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/form_header_title.dart';
import '../../../widget/item_add_delete_btn.dart';
import '../../profile/component/person_single_property.dart';

class AddPropertyPlanView extends StatefulWidget {
  const AddPropertyPlanView({super.key});

  @override
  State<AddPropertyPlanView> createState() => _AddPropertyPlanViewState();
}

class _AddPropertyPlanViewState extends State<AddPropertyPlanView> {
  late AddPropertyCubit addProperty;
  late CreateInfoCubit infoCubit;
  late PropertyPlanDto propertyPlan;
  late DeleteInfoCubit deleteCubit;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
    infoCubit = context.read<CreateInfoCubit>();
    deleteCubit = context.read<DeleteInfoCubit>();

    propertyPlan = const PropertyPlanDto(
        planImages: '', planTitles: '', planDescriptions: '');
    if (addProperty.state.propertyPlanDto.isEmpty) {
      addProperty.addPropertyPlan(propertyPlan);
    }
    // else {
    //   propertyPlan = const PropertyPlanDto(
    //       planImages: '', planTitles: '', planDescriptions: '');
    //   addProperty.addPropertyPlan(propertyPlan);
    // }
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
              const FormHeaderTitle(title: "Property Plan"),
              Utils.verticalSpace(14.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(state.propertyPlanDto.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (index != 0) ...[
                            GestureDetector(
                                onTap: () {
                                  final itemId = addProperty
                                      .state.propertyPlanDto[index].id;
                                  if (itemId > 0) {
                                    print('ex-id $itemId');
                                    deleteCubit
                                        .deleteSinglePlan(itemId.toString());
                                  }
                                  addProperty.deletePropertyPlan(index);
                                },
                                child: const DeleteIconBtn()),
                          ],
                          _buildImages(state, index),
                          Utils.verticalSpace(16),
                          _buildPlanTitles(state, index),
                          Utils.verticalSpace(16),
                          _buildPlanDistance(state, index),
                        ],
                      );
                    }),
                    GestureDetector(
                        onTap: () => addProperty.addPropertyPlan(propertyPlan),
                        child: const ItemAddBtn()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlanTitles(AddPropertyModel state, int index) {
    return TextFormField(
      initialValue: state.propertyPlanDto[index].planTitles,
      textInputAction: TextInputAction.done,
      onChanged: (String titles) {
        final title = state.propertyPlanDto[index].copyWith(planTitles: titles);
        addProperty.updatePropertyPlan(index, title);
      },
      decoration: InputDecoration(
          hintText: index != 0 ? 'title ${index + 1}' : 'title ',
          labelText: index != 0 ? 'Title ${index + 1}' : 'Title',
          hintStyle: const TextStyle(color: Colors.black38),
          labelStyle: const TextStyle(
            color: Colors.black38,
          )),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildPlanDistance(AddPropertyModel state, int index) {
    return TextFormField(
      initialValue: state.propertyPlanDto[index].planDescriptions,
      onChanged: (String titles) {
        final title =
            state.propertyPlanDto[index].copyWith(planDescriptions: titles);
        addProperty.updatePropertyPlan(index, title);
      },
      decoration: InputDecoration(
          hintText: index != 0 ? 'description ${index + 1}' : 'description',
          labelText: index != 0 ? 'Description ${index + 1}' : 'Description',
          hintStyle: const TextStyle(color: Colors.black38),
          labelStyle: const TextStyle(
            color: Colors.black38,
          )),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildImages(AddPropertyModel state, int index) {
    if (addProperty.state.propertyPlanDto[index].planImages.isNotEmpty) {
      //final planImages = addProperty.state.propertyPlanDto[index].planImages;
      final item = addProperty.state.propertyPlanDto[index].planImages;
      String sliderImage = item.isEmpty ? KImages.placeholderImage : item;
      bool isSliderFile = item.isNotEmpty
          ? item.contains('https://')
              ? false
              : true
          : false;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 0.2,
            color: Colors.grey,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 160.0,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomImage(
                  path: sliderImage,
                  height: 160.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // fit: isSliderFile ? BoxFit.cover : BoxFit.contain,
                  isFile: isSliderFile,
                  // isFile: state.propertyPlanDto[index].planImages.isNotEmpty,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () async {
                  final image = await Utils.pickSingleImage();
                  if (image != null && image.isNotEmpty) {
                    final pImage = state.propertyPlanDto[index]
                        .copyWith(planImages: image);
                    addProperty.updatePropertyPlan(index, pImage);
                  }
                },
                child: const EditBtn(),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 80.0,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () async {
            final image = await Utils.pickSingleImage();
            if (image != null && image.isNotEmpty) {
              final pImage =
                  state.propertyPlanDto[index].copyWith(planImages: image);
              addProperty.updatePropertyPlan(index, pImage);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.upload, size: 24, color: primaryColor),
              Utils.horizontalSpace(8.0),
              CustomTextStyle(
                text: index == 0
                    ? "Upload Plan Image"
                    : 'Upload Plan Image ${index + 1}',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              )
            ],
          ),
        ),
      );
    }
  }
}
