import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/nearest_location_dto.dart';
import '../../../../data/model/product/nearest_location_model.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/form_header_title.dart';
import '../../../widget/item_add_delete_btn.dart';

class AddPropertyNearestLocation extends StatefulWidget {
  const AddPropertyNearestLocation({super.key});

  @override
  State<AddPropertyNearestLocation> createState() =>
      _AddPropertyNearestLocationState();
}

class _AddPropertyNearestLocationState
    extends State<AddPropertyNearestLocation> {
  late AddPropertyCubit addProperty;
  late CreateInfoCubit infoCubit;
  late DeleteInfoCubit deleteCubit;
  late NearestLocationDto locationDto;

  // NearestLocationModel? model;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
    infoCubit = context.read<CreateInfoCubit>();
    deleteCubit = context.read<DeleteInfoCubit>();

    if (infoCubit.createPropertyInfo != null &&
        infoCubit.createPropertyInfo!.nearestLocations!.isNotEmpty) {
      final location = infoCubit.createPropertyInfo!.nearestLocations!.first;
      locationDto = NearestLocationDto(locationId: location.id, distances: '');
      if (addProperty.locationModel.isEmpty) {
        addProperty.locationModel
            .addAll(infoCubit.createPropertyInfo!.nearestLocations!);
      }
    } else {
      locationDto = const NearestLocationDto(locationId: 0, distances: '');
    }
    if (addProperty.state.nearestLocationList.isEmpty) {
      addProperty.addNearestLocation(locationDto);
    }
  }

  ///second tried
  // _initState() {
  //   addProperty = context.read<AddPropertyCubit>();
  //   infoCubit = context.read<CreateInfoCubit>();
  //
  //   if (infoCubit.createPropertyInfo != null &&
  //       infoCubit.createPropertyInfo!.nearestLocations!.isNotEmpty) {
  //     final location = infoCubit.createPropertyInfo!.nearestLocations!.first;
  //     locationDto = NearestLocationDto(locationId: location.id, distances: '');
  //     if (addProperty.locationModel.isEmpty) {
  //       addProperty.locationModel.add(location);
  //     }
  //   } else {
  //     locationDto = const NearestLocationDto(locationId: 0, distances: '');
  //   }
  //   if (addProperty.state.nearestLocationList.isEmpty) {
  //     addProperty.addNearestLocation(locationDto);
  //   }
  //   // for (int i = 0; i < addProperty.state.nearestLocationList.length; i++) {
  //   //   final cubitLocation = addProperty.state.nearestLocationList[i];
  //   //   final cLoc = NearestLocationModel(
  //   //       id: cubitLocation.id,
  //   //       location: cubitLocation.locationId.toString(),
  //   //       status: 1);
  //   //   addProperty.locationModel.insert(i, cLoc);
  //   // }
  //   // else{
  //   model = infoCubit.createPropertyInfo!.nearestLocations!.first;
  //   // }
  //   print('cubit-location ${addProperty.locationModel}');
  // }

  // _initState() {
  //   addProperty = context.read<AddPropertyCubit>();
  //   infoCubit = context.read<CreateInfoCubit>();
  //
  //   if (infoCubit.createPropertyInfo != null &&
  //       infoCubit.createPropertyInfo!.nearestLocations!.isNotEmpty) {
  //     final location = infoCubit.createPropertyInfo!.nearestLocations!.first;
  //     locationDto = NearestLocationDto(locationId: location.id, distances: '');
  //     addProperty.locationModel.insert(0, location);
  //   } else {
  //     locationDto = const NearestLocationDto(locationId: 0, distances: '');
  //   }
  //   if (addProperty.state.nearestLocationList.isEmpty) {
  //     addProperty.addNearestLocation(locationDto);
  //   }
  //
  //   // if (infoCubit.createPropertyInfo != null &&
  //   //     infoCubit.createPropertyInfo!.nearestLocations.isNotEmpty) {
  //   //   final location = infoCubit.createPropertyInfo!.nearestLocations.first;
  //   //   if (addProperty.state.nearestLocationList.isEmpty) {
  //   //     locationDto = NearestLocationDto(locationId: location.id, distances: location.location);
  //   //     addProperty.addNearestLocation(locationDto);
  //   //   } else {
  //   //     locationDto = const NearestLocationDto(locationId: 0, distances: '');
  //   //   }
  //   //   addProperty.locationModel.insert(0, location);
  //   // }
  // }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        if (infoCubit.createPropertyInfo != null &&
            infoCubit.createPropertyInfo!.nearestLocations!.isNotEmpty &&
            addProperty.locationModel.isEmpty) {
          final location =
              infoCubit.createPropertyInfo!.nearestLocations!.first;
          addProperty.locationModel.insert(0, location);
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FormHeaderTitle(title: "Nearest Location"),
              Utils.verticalSpace(14.0),
              ...List.generate(
                state.nearestLocationList.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (index != 0) ...[
                          GestureDetector(
                              onTap: () {
                                final itemId = addProperty
                                    .state.nearestLocationList[index].id;
                                if (itemId > 0) {
                                  print('existing-item $itemId');
                                  deleteCubit.deleteSingleNearestLocation(
                                      itemId.toString());
                                }
                                addProperty.deleteNearestLocation(index);
                              },
                              child: const DeleteIconBtn()),
                        ],
                        Row(
                          children: [
                            if (infoCubit.createPropertyInfo != null &&
                                infoCubit.createPropertyInfo!.nearestLocations!
                                    .isNotEmpty) ...[
                              _buildCity(index, state),
                            ] else ...[
                              const Center(
                                  child: CustomTextStyle(
                                      text: 'No Location available!'))
                            ],
                            Utils.horizontalSpace(10.0),
                            _buildDistance(index, state),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                  onTap: () {
                    addProperty.addNearestLocation(locationDto);
                  },
                  child: const ItemAddBtn()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDistance(int index, AddPropertyModel state) {
    return Expanded(
      child: TextFormField(
        onChanged: (v) {
          // print('onChanged-text-field$v');
          //addProperty.distanceChange(v, index);
          addProperty.updateNearestLocation(
            index,
            state.nearestLocationList[index].copyWith(distances: v),
          );
        },
        initialValue: state.nearestLocationList[index].distances,
        decoration: InputDecoration(
            hintText: index == 0 ? 'Value' : 'Value ${index + 1}',
            labelText: index == 0 ? 'Value' : 'Value ${index + 1}',
            hintStyle: const TextStyle(color: Colors.black38),
            labelStyle: const TextStyle(color: Colors.black38)),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.deny('a'),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Widget _buildCity(int index, AddPropertyModel state) {
    NearestLocationModel? selectedModel;
    if (index < addProperty.state.nearestLocationList.length) {
      selectedModel =
          infoCubit.createPropertyInfo!.nearestLocations!.firstWhere(
        (element) =>
            element.id ==
            addProperty.state.nearestLocationList[index].locationId,
        orElse: () => infoCubit.createPropertyInfo!.nearestLocations!.first,
      );
    }
    return Expanded(
      child: DropdownButtonFormField<NearestLocationModel>(
        isDense: true,
        isExpanded: true,
        value: selectedModel!,
        //value: addProperty.locationModel[index],
        // value: index < addProperty.locationModel.length
        //     ? addProperty.locationModel[index]
        //     : model!,
        decoration: const InputDecoration(
          filled: true,
          fillColor: borderColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
        ),
        hint: const CustomTextStyle(
          text: 'Select City',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_sharp, color: blackColor),
        items: infoCubit.createPropertyInfo!.nearestLocations!
            .map<DropdownMenuItem<NearestLocationModel>>(
              (e) => DropdownMenuItem(
                value: e,
                child: CustomTextStyle(
                  text: e.location,
                  fontSize: 16.0,
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          if (val == null) return;
          addProperty.updateNearestLocation(
            index,
            state.nearestLocationList[index].copyWith(locationId: val.id),
          );
        },
      ),
    );
  }
}
