import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/widget/page_refresh.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/create_update_button.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';
import 'component/add_additional_information.dart';
import 'component/add_property_aminities.dart';
import 'component/add_property_image_view.dart';
import 'component/add_property_location_view.dart';
import 'component/add_property_nearest_location.dart';
import 'component/add_property_plan_view.dart';
import 'component/add_property_seo.dart';
import 'component/add_property_type_view.dart';
import 'component/add_property_video_view.dart';
import 'component/basic_input_field.dart';

class NewPropertyCreateScreen extends StatefulWidget {
  const NewPropertyCreateScreen({super.key, required this.id});

  final String id;

  @override
  State<NewPropertyCreateScreen> createState() =>
      _NewPropertyCreateScreenState();
}

class _NewPropertyCreateScreenState extends State<NewPropertyCreateScreen> {
  late AddPropertyCubit addProperty;

  _initState() {
    addProperty = context.read<AddPropertyCubit>();
    if (widget.id.isNotEmpty) {
      Future.microtask(() => addProperty.getEditedProperty(widget.id));
    }
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: widget.id.isEmpty ? 'Add New Property' : 'Update Property',
        bgColor: whiteColor,
      ),
      body: PageRefresh(
        onRefresh: () async => addProperty.getEditedProperty(widget.id),
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteInfoCubit, DeleteInfoState>(
              listener: (context, state) {
                if (state is DeleteInfoError) {
                  if (state.statusCode == 401) {
                    Utils.logout(context);
                  } else {
                    Utils.errorSnackBar(context, state.errorMessage);
                  }
                } else if (state is DeleteInfoSuccess) {
                  Utils.showSnackBar(context, state.message);
                }
              },
            ),
            BlocListener<LoginBloc, LoginModelState>(
              listener: (context, state) {
                final logout = state.state;
                if (logout is LoginStateLogOutLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (logout is LoginStateSignOutError) {
                    Utils.errorSnackBar(context, logout.errorMsg);
                  } else if (logout is LoginStateLogOut) {
                    Utils.showSnackBar(context, logout.msg);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.loginScreen,
                      (route) => false,
                    );
                  }
                }
              },
            ),
          ],
          child: BlocConsumer<AddPropertyCubit, AddPropertyModel>(
            listener: (context, state) {
              final property = state.addState;
              if (property is AddPropertyEditingError) {
                if (property.statusCode == 503 ||
                    addProperty.editedInfo == null) {
                  addProperty.getEditedProperty(widget.id);
                }
                if (property.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, state) {
              final property = state.addState;
              if (property is AddPropertyEditing) {
                return const LoadingWidget();
              } else if (property is AddPropertyEditingError) {
                if (property.statusCode == 503 ||
                    addProperty.editedInfo != null) {
                  return const AddPropertyForm();
                } else {
                  return FetchErrorText(text: property.message);
                }
              } else if (property is AddPropertyEdited) {
                return const AddPropertyForm();
              }
              if (addProperty.editedInfo != null) {
                return const AddPropertyForm();
              } else {
                if (widget.id.isEmpty) {
                  return const AddPropertyForm();
                } else {
                  return const FetchErrorText(text: 'Something went wrong!');
                }
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddPropertyCubit, AddPropertyModel>(
          listener: (context, state) {
        final property = state.addState;
        if (property is AddPropertyLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (property is AddPropertyError) {
            if (property.statusCode == 401) {
              Utils.logout(context);
            } else {
              Utils.errorSnackBar(context, property.message);
            }
          } else if (property is AddPropertyLoaded) {
            Navigator.of(context).pop(true);
            Utils.showSnackBar(context, property.message);
          }
        }
      }, builder: (context, state) {
        final property = state.addState;

        if (property is AddPropertyEditing) {
          return const SizedBox.shrink();
        } else if (property is AddPropertyEdited) {
          return _submitButton();
        }
        if (addProperty.editedInfo != null) {
          return _submitButton();
        } else {
          if (widget.id.isEmpty) {
            return _submitButton();
          } else {
            return const SizedBox.shrink();
          }
        }
      }),
    );
  }

  Widget _submitButton() {
    return CreateUpdateSubmitButton(
      title: widget.id.isEmpty ? 'Submit Property' : 'Update Property',
      press: () {
        if (widget.id.isNotEmpty) {
          addProperty.updateProperty(widget.id);
        } else {
          addProperty.addProperty();
        }
      },
    );
  }
}

class AddPropertyForm extends StatefulWidget {
  const AddPropertyForm({super.key});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {
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
    return ListView(
      padding: Utils.symmetric(),
      children: [
        // AdditionalImageView(),

        // if (addProperty.state.purpose == 'rent') ...[
        //   const AddRentPeriodView(),
        // ] else ...[
        //   Utils.verticalSpace(20.0),
        //   const AddPropertyTypeView(),
        // ],
        const AddPropertyTypeView(),
        Utils.verticalSpace(20.0),
        const BasicInputField(),
        Utils.verticalSpace(20.0),
        const AddPropertyImageView(),
        Utils.verticalSpace(20.0),
        const AddPropertyVideoView(),
        Utils.verticalSpace(20.0),
        const AddPropertyLocationView(),
        Utils.verticalSpace(20.0),
        const AddPropertyAminities(),
        Utils.verticalSpace(20.0),
        const AddPropertyNearestLocation(),
        Utils.verticalSpace(20.0),
        const AddAdditionalInformation(),
        Utils.verticalSpace(20.0),
        const AddPropertyPlanView(),
        Utils.verticalSpace(20.0),
        const AddPropertySeo(),
      ],
    );
  }
}
