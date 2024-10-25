import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/category/property_category_model.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../core/dummy_text.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';

class AddPropertyTypeView extends StatefulWidget {
  const AddPropertyTypeView({super.key});

  @override
  State<AddPropertyTypeView> createState() => _AddPropertyTypeViewState();
}

class _AddPropertyTypeViewState extends State<AddPropertyTypeView> {
  late AddPropertyCubit addProperty;
  late CreateInfoCubit infoCubit;
  PropertyCategory? categoryModel;
  String? value;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
    infoCubit = context.read<CreateInfoCubit>();

    if (infoCubit.createPropertyInfo != null &&
        infoCubit.createPropertyInfo!.types!.isNotEmpty) {
      if (addProperty.state.typeId.isNotEmpty) {
        categoryModel = infoCubit.createPropertyInfo!.types!
            .where((e) => e.id.toString() == addProperty.state.typeId)
            .first;
      } else {
        categoryModel = infoCubit.createPropertyInfo!.types!.first;
      }
      addProperty.changeTypeId(categoryModel!.id.toString());
    }
    if (addProperty.state.rentPeriod.isNotEmpty) {
      value = rendPeriodList
          .where((element) =>
              element.toLowerCase() ==
              addProperty.state.rentPeriod.toLowerCase())
          .first;
      // print('rent-period ${addProperty.state.rentPeriod}');
    } else {
      value = rendPeriodList.first;
      // print('rent-period-not-state $value');
    }
    addProperty.changeRentPeriod(value!.toLowerCase());
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (addProperty.state.purpose == 'sale') {
      return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
        builder: (context, state) {
          // PropertyCategory? categoryModel;
          // if (cubit.createPropertyInfo != null &&
          //     cubit.createPropertyInfo!.types!.isNotEmpty) {
          //   categoryModel = cubit.createPropertyInfo!.types!.first;
          // }
          // if (state.typeId.isNotEmpty) {
          //   categoryModel = infoCubit.createPropertyInfo!.types!
          //       .where((element) => element.id.toString() == state.typeId)
          //       .first;
          // }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (infoCubit.createPropertyInfo != null &&
                          infoCubit.createPropertyInfo!.types!.isNotEmpty) ...[
                        DropdownButtonFormField<PropertyCategory>(
                          isDense: true,
                          isExpanded: true,
                          value: categoryModel!,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: borderColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          hint: const CustomTextStyle(
                            text: 'Select Category',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp,
                              color: blackColor),
                          items: infoCubit.createPropertyInfo!.types!
                              .map<DropdownMenuItem<PropertyCategory>>(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: CustomTextStyle(
                                    text: e.name,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            //bloc.add(PropertyTypeEvent(type: val!.id.toString()));
                            if (val == null) return;
                            addProperty.changeTypeId(val.id.toString());
                          },
                        ),
                      ] else ...[
                        const Center(
                            child: CustomTextStyle(
                                text: 'No Rent type available!'))
                      ],
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.propertytypeId.isNotEmpty)
                          ErrorText(
                              text: stateStatus.errors.propertytypeId.first)
                      ]
                    ],
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
        builder: (context, state) {
          // String value = rendPeriodList.first;
          // if (state.rentPeriod.isNotEmpty) {
          //   value = rendPeriodList
          //       .where((element) => element.toLowerCase() == state.rentPeriod)
          //       .first;
          // }

          return DropdownButtonFormField<String>(
            isDense: true,
            isExpanded: true,
            decoration: const InputDecoration(
              filled: true,
              fillColor: borderColor,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
            ),
            value: value!,
            hint: const CustomTextStyle(
              text: 'Rent',
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
            icon:
                const Icon(Icons.keyboard_arrow_down_sharp, color: blackColor),
            items: rendPeriodList
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: CustomTextStyle(
                      text: e,
                      fontSize: 16.0,
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              if (val == null) return;
              addProperty.changeRentPeriod(val.toLowerCase());
            },
          );
        },
      );
    }
  }
}

// class AddRentPeriodView extends StatelessWidget {
//   const AddRentPeriodView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<AddPropertyCubit>();
//     return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
//       builder: (context, state) {
//         String value = rendPeriodList.first;
//         if (state.rentPeriod.isNotEmpty) {
//           value = rendPeriodList
//               .where((element) => element.toLowerCase() == state.rentPeriod)
//               .first;
//         }
//
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // heading('Select Category'),
//             DropdownButtonFormField<String>(
//               isDense: true,
//               isExpanded: true,
//               decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: borderColor,
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: borderColor),
//                 ),
//               ),
//               value: value,
//               hint: const CustomTextStyle(
//                 text: 'Rent',
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16.0,
//               ),
//               icon: const Icon(Icons.keyboard_arrow_down_sharp,
//                   color: blackColor),
//               items: rendPeriodList
//                   .map<DropdownMenuItem<String>>(
//                     (e) => DropdownMenuItem(
//                       value: e,
//                       child: CustomTextStyle(
//                         text: e,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   )
//                   .toList(),
//               onChanged: (val) {
//                 if (val == null) return;
//                 bloc.changeRentPeriod(val.toLowerCase());
//
//                 // bloc.add(PropertyRentPeriodEvent(rentPeriod: val!.toLowerCase()));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
