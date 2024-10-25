import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../utils/utils.dart';
import '../../../widget/error_text.dart';

class BasicInputField extends StatefulWidget {
  const BasicInputField({super.key});

  @override
  State<BasicInputField> createState() => _BasicInputFieldState();
}

class _BasicInputFieldState extends State<BasicInputField> {
  late AddPropertyCubit addProperty;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AddPropertyCubit, AddPropertyModel>(
          builder: (context, state) {
            final stateStatus = state.addState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: state.title,
                  onChanged: (value) => addProperty.changeTitle(value),
                  decoration: const InputDecoration(
                      hintText: 'Title *',
                      labelText: 'Title *',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is AddPropertyFormError) ...[
                  if (stateStatus.errors.title.isNotEmpty)
                    ErrorText(text: stateStatus.errors.title.first)
                ]
              ],
            );
          },
        ),
        // Utils.verticalSpace(20.0),
        // BlocBuilder<AddPropertyCubit, AddPropertyModel>(
        //   // buildWhen: (previous, current) => previous.slug != current.slug,
        //   builder: (context, state) {
        //     final stateStatus = state.addState;
        //     return Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         TextFormField(
        //           initialValue: state.slug,
        //           onChanged: (value) {
        //             final ss = value.replaceAll(' ', '-').toLowerCase().trim();
        //             //bloc.add(PropertySlugEvent(slug: ss));
        //             //print('ss $ss');
        //           },
        //           decoration: const InputDecoration(
        //               hintText: 'Slug *',
        //               labelText: 'Slug *',
        //               hintStyle: TextStyle(color: Colors.black38),
        //               labelStyle: TextStyle(
        //                 color: Colors.black38,
        //               )),
        //           keyboardType: TextInputType.text,
        //         ),
        //         if (stateStatus is AddPropertyFormError) ...[
        //           if (stateStatus.errors.slug.isNotEmpty)
        //             ErrorText(text: stateStatus.errors.slug.first)
        //         ]
        //       ],
        //     );
        //   },
        // ),
        Utils.verticalSpace(20.0),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                // buildWhen: (previous, current) =>
                //     previous.price != current.price,
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.price,
                        onChanged: (value) =>
                            addProperty.changeTotalPrice(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Price *',
                            labelText: 'Total Price *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.number,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.price.isNotEmpty)
                          ErrorText(text: stateStatus.errors.price.first)
                      ]
                    ],
                  );
                },
              ),
            ),
            Utils.horizontalSpace(8),
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalArea,
                        onChanged: (value) =>
                            addProperty.changeTotalArea(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Area *',
                            labelText: 'Total Area *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.totalArea.isNotEmpty)
                          ErrorText(text: stateStatus.errors.totalArea.first)
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Utils.verticalSpace(20.0),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalUnit,
                        onChanged: (value) =>
                            addProperty.changeTotalUnit(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Unit *',
                            labelText: 'Total Unit *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.totalUnit.isNotEmpty)
                          ErrorText(text: stateStatus.errors.totalUnit.first)
                      ]
                    ],
                  );
                },
              ),
            ),
            Utils.horizontalSpace(8),
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalBedroom,
                        onChanged: (value) =>
                            addProperty.changeTotalBedroom(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Bedroom *',
                            labelText: 'Total Bedroom *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.totalBedroom.isNotEmpty)
                          ErrorText(text: stateStatus.errors.totalBedroom.first)
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Utils.verticalSpace(20.0),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalGarage,
                        onChanged: (value) =>
                            addProperty.changeTotalGarage(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Garage *',
                            labelText: 'Total Garage *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.totalGarage.isNotEmpty)
                          ErrorText(text: stateStatus.errors.totalGarage.first)
                      ]
                    ],
                  );
                },
              ),
            ),
            Utils.horizontalSpace(8),
            Expanded(
              child: BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                builder: (context, state) {
                  final stateStatus = state.addState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.totalBathroom,
                        onChanged: (value) =>
                            addProperty.changeTotalBathroom(value),
                        decoration: const InputDecoration(
                            hintText: 'Total Bathroom *',
                            labelText: 'Total Bathroom *',
                            hintStyle: TextStyle(color: Colors.black38),
                            labelStyle: TextStyle(
                              color: Colors.black38,
                            )),
                        keyboardType: TextInputType.text,
                      ),
                      if (stateStatus is AddPropertyFormError) ...[
                        if (stateStatus.errors.slug.isNotEmpty)
                          ErrorText(text: stateStatus.errors.slug.first)
                      ]
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Utils.verticalSpace(20.0),
        BlocBuilder<AddPropertyCubit, AddPropertyModel>(
          builder: (context, state) {
            final stateStatus = state.addState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: state.totalKitchen,
                  onChanged: (value) => addProperty.changeTotalKitchen(value),
                  decoration: const InputDecoration(
                      hintText: 'Total Kitchen *',
                      labelText: 'Total Kitchen *',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is AddPropertyFormError) ...[
                  if (stateStatus.errors.totalKitchen.isNotEmpty)
                    ErrorText(text: stateStatus.errors.totalKitchen.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(20.0),
        BlocBuilder<AddPropertyCubit, AddPropertyModel>(
          builder: (context, state) {
            final stateStatus = state.addState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: state.description,
                  onChanged: (value) => addProperty.changeDescription(value),
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 5,
                ),
                if (stateStatus is AddPropertyFormError) ...[
                  if (stateStatus.errors.description.isNotEmpty)
                    ErrorText(text: stateStatus.errors.description.first)
                ]
              ],
            );
          },
        ),
      ],
    );
  }
}
