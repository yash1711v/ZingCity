import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/additional_info_dto.dart';

part 'additional_state.dart';

class AdditionalCubit extends Cubit<AdditionalState> {
  AdditionalCubit()
      : super(const AdditionAdded(
            [AdditionalInfoDto(addKeys: '', addValues: '')]));
  List<TextEditingController> keys = [TextEditingController()];
  List<TextEditingController> values = [TextEditingController()];
  List<AdditionalInfoDto> cubitAdditional = [
    const AdditionalInfoDto(addKeys: '', addValues: '')
  ];

  void addAdditional(AdditionalInfoDto additionalInfo) {
    final updatedAdditional = List.of(cubitAdditional)..add(additionalInfo);
    final updatedKeys = List.of(keys)..add(TextEditingController());
    final updatedValues = List.of(values)..add(TextEditingController());

    cubitAdditional = updatedAdditional;
    keys = updatedKeys;
    values = updatedValues;
    emit(AdditionAdded(updatedAdditional));
  }

  void removeAdditional(int index) {
    if (index >= 0 && index < cubitAdditional.length) {
      final updatedAdditional = List.of(cubitAdditional)..removeAt(index);
      final updatedKeys = List.of(keys);
      final removedKeys = updatedKeys.removeAt(index);
      removedKeys.dispose();

      final updatedValues = List.of(values);
      final removedValues = updatedValues.removeAt(index);
      removedValues.dispose();

      cubitAdditional = updatedAdditional;
      keys = updatedKeys;
      values = updatedValues;

      emit(AdditionAdded(updatedAdditional));
    }
  }

  void reset() {
    keys = <TextEditingController>[TextEditingController()];
    values = <TextEditingController>[TextEditingController()];
  }
}
