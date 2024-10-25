import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/create_property/additional_info_dto.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../../utils/utils.dart';
import '../../../widget/form_header_title.dart';
import '../../../widget/item_add_delete_btn.dart';

class AddAdditionalInformation extends StatefulWidget {
  const AddAdditionalInformation({super.key});

  @override
  State<AddAdditionalInformation> createState() =>
      _AddAdditionalInformationState();
}

class _AddAdditionalInformationState extends State<AddAdditionalInformation> {
  late AddPropertyCubit addProperty;
  late DeleteInfoCubit deleteCubit;

  late AdditionalInfoDto additional;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
    deleteCubit = context.read<DeleteInfoCubit>();
    additional = const AdditionalInfoDto(addKeys: '', addValues: '');
    if (addProperty.state.addtionalInfoList.isEmpty) {
      addProperty.addAdditionalInfo(additional);
    }
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
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const FormHeaderTitle(title: "Additional Information"),
            Utils.verticalSpace(14.0),
            ...List.generate(
              state.addtionalInfoList.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (index != 0) ...[
                        GestureDetector(
                          onTap: () {
                            final itemId =
                                addProperty.state.addtionalInfoList[index].id;
                            if (itemId > 0) {
                              print('ex-id $itemId');
                              deleteCubit
                                  .deleteSingleAddInfo(itemId.toString());
                            }
                            // else {
                            //   print('not-ex-id $itemId');
                            // }
                            addProperty.deleteAdditionalInfo(index);
                          },
                          child: const DeleteIconBtn(),
                        ),
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildKeyField(state, index),
                          Utils.horizontalSpace(10),
                          _buildValueField(state, index),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            GestureDetector(
                onTap: () => addProperty.addAdditionalInfo(additional),
                child: const ItemAddBtn()),
          ]),
        );
      },
    );
  }

  Widget _buildValueField(AddPropertyModel state, int index) {
    return Expanded(
      child: TextFormField(
        initialValue: state.addtionalInfoList[index].addValues,
        onChanged: (String value) {
          final addKeys =
              state.addtionalInfoList[index].copyWith(addValues: value);
          addProperty.updateAdditionalInfo(index, addKeys);
        },
        decoration: InputDecoration(
            hintText: index == 0 ? 'Value' : 'Value ${index + 1}',
            labelText: index == 0 ? 'Value' : 'Value ${index + 1}',
            hintStyle: const TextStyle(color: Colors.black38),
            labelStyle: const TextStyle(color: Colors.black38)),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildKeyField(AddPropertyModel state, int index) {
    return Expanded(
      child: TextFormField(
        initialValue: state.addtionalInfoList[index].addKeys,
        onChanged: (String key) {
          final addKeys = state.addtionalInfoList[index].copyWith(addKeys: key);
          addProperty.updateAdditionalInfo(index, addKeys);
        },
        decoration: InputDecoration(
            hintText: index == 0 ? 'Key' : 'Key ${index + 1}',
            labelText: index == 0 ? 'Key' : 'Key ${index + 1}',
            hintStyle: const TextStyle(color: Colors.black38),
            labelStyle: const TextStyle(color: Colors.black38)),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
