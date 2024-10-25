import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/property_plan_dto.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit()
      : super(const PlanState([
          PropertyPlanDto(planImages: '', planTitles: '', planDescriptions: '')
        ])) {
    planImages.add('');
    planTitles.add(TextEditingController());
    planDescription.add(TextEditingController());
    final updatedItem = List<PropertyPlanDto>.from(state.propertyPlan);
    updatedItem[0] = PropertyPlanDto(
        planImages: planImages[0],
        planTitles: planTitles[0].text,
        planDescriptions: planDescription[0].text);
    emit(PlanState(List.from(updatedItem)));
  }

  List<String> planImages = <String>[];
  List<TextEditingController> planTitles = <TextEditingController>[];
  List<TextEditingController> planDescription = <TextEditingController>[];

  void addFormItem(PropertyPlanDto services) {
    final List<PropertyPlanDto> additionalItem = List.from(state.propertyPlan)
      ..add(services);
    String img = '';
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    planImages.add(img);
    planTitles.add(titleController);
    planDescription.add(descriptionController);

    print('additionalItem ${additionalItem.length}');
    emit(PlanState(additionalItem));
  }

  void removeFormItem(int index) {
    planImages[index] = '';
    planTitles[index].dispose();
    planDescription[index].dispose();

    planImages[index] = '';
    planTitles.removeAt(index);
    planDescription.removeAt(index);

    final List<PropertyPlanDto> additionalItem = List.from(state.propertyPlan)
      ..removeAt(index);
    emit(PlanState(additionalItem));
  }

  void updateImage(int index, String image) {
    planImages[index] = image;
    final updatedItems = List<PropertyPlanDto>.from(state.propertyPlan);
    updatedItems[index] = PropertyPlanDto(
      planTitles: planTitles[index].text,
      planDescriptions: planDescription[index].text,
      planImages: image,
    );
    emit(PlanState(List.from(updatedItems)));
  }

  void updateControllers(int index, String text, String fieldType) {
    final updatedItems = List<PropertyPlanDto>.from(state.propertyPlan);
    if (fieldType == 'title') {
      updatedItems[index] = PropertyPlanDto(
        planTitles: text,
        planDescriptions: planDescription[index].text,
        planImages: planImages[index],
      );
    }
    if (fieldType == 'description') {
      updatedItems[index] = PropertyPlanDto(
        planTitles: planTitles[index].text,
        planDescriptions: text,
        planImages: planImages[index],
      );
    }

    emit(PlanState(List.from(updatedItems)));
  }

  void reset() {
    debugPrint('reset-called');
    planImages = <String>[''];
    planTitles = <TextEditingController>[TextEditingController()];
    planDescription = <TextEditingController>[TextEditingController()];
  }
}
