import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';

import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/form_header_title.dart';

class AddPropertyAminities extends StatelessWidget {
  const AddPropertyAminities({super.key});

  @override
  Widget build(BuildContext context) {
    final addProperty = context.read<AddPropertyCubit>();
    final cubit = context.read<CreateInfoCubit>();
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              )),
          child: Column(
            children: [
              const FormHeaderTitle(title: "Aminities"),
              Utils.verticalSpace(14.0),
              Wrap(
                runSpacing: 0.0,
                spacing: 10.0,
                children: [
                  if (cubit.createPropertyInfo != null &&
                      cubit.createPropertyInfo!.aminities!.isNotEmpty) ...[
                    ...List.generate(
                        cubit.createPropertyInfo!.aminities!.length, (index) {
                      final element =
                          cubit.createPropertyInfo!.aminities![index];
                      return SizedBox(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                              value: state.aminities.contains(element.id),
                              activeColor: primaryColor,
                              onChanged: (v) {
                                addProperty.addAminities(element.id);
                                // bloc.add(PropertyPropertyAminitiesEvent(
                                //     propertyAminities: aminityList));
                              }),
                          CustomTextStyle(text: element.aminity),
                        ],
                      ));
                    })
                  ] else ...[
                    const Center(
                        child: CustomTextStyle(
                            text: 'No Location aminities available!'))
                  ]
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
