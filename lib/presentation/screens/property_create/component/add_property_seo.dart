import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/utils/utils.dart';
import '../../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../../widget/form_header_title.dart';

class AddPropertySeo extends StatelessWidget {
  const AddPropertySeo({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddPropertyCubit>();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.black)),
      child: Column(
        children: [
          const FormHeaderTitle(title: "SEO Information"),
          Utils.verticalSpace(14.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CreateInfoCubit, CreateInfoState>(
              builder: (context, state) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue: state.seoTitle,
                            onChanged: (value) => bloc.changeSeoTitle(value),
                            decoration: const InputDecoration(
                                hintText: 'SEO Title',
                                labelText: 'SEO Title',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          );
                        },
                      ),
                      Utils.verticalSpace(16),
                      BlocBuilder<AddPropertyCubit, AddPropertyModel>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue: state.seoMetaDescription,
                            onChanged: (value) =>
                                bloc.changeSeoDescription(value),
                            decoration: const InputDecoration(
                                hintText: 'SEO Description',
                                labelText: 'SEO Description',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          );
                        },
                      ),
                    ]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
