import 'package:flutter/material.dart';
import 'package:real_estate/logic/cubit/agency/agency_cubit.dart';
import 'package:real_estate/logic/cubit/agency/agency_state_model.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/dummy_data/dummy_data.dart';
import '../../../../state_inject_package_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/circle_image.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';
import '../../../widget/fetch_text_error.dart';
import '../../../widget/loading_widget.dart';

class CreateAgentScreen extends StatefulWidget {
  const CreateAgentScreen({super.key, required this.id});

  final String id;

  @override
  State<CreateAgentScreen> createState() => _CreateAgentScreenState();
}

class _CreateAgentScreenState extends State<CreateAgentScreen> {
  late AgencyCubit aCubit;

  @override
  void initState() {
    aCubit = context.read<AgencyCubit>();
    if (widget.id.isNotEmpty) {
      Future.microtask(() => aCubit.getEditAgencyAgent(widget.id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("createPage id : ${widget.id}");
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: widget.id.isEmpty ? 'Create Agent' : 'Update Agent',
        bgColor: whiteColor,
      ),
      body: BlocConsumer<AgencyCubit, AgencyStateModel>(
          listener: (context, state) {
        final agent = state.agencyState;
        if (agent is AgencyAgentEditingError) {
          if (agent.statusCode == 503 || aCubit.editAgencyAgent == null) {
            aCubit.getEditAgencyAgent(widget.id);
          }
          if (agent.statusCode == 401) {
            Utils.logout(context);
          }
        }
      }, builder: (context, state) {
        final agent = state.agencyState;
        if (agent is AgencyAgentEditing) {
          return const LoadingWidget();
        } else if (agent is AgencyAgentEditingError) {
          if (agent.statusCode == 503 || aCubit.editAgencyAgent != null) {
            return LoadedForm(
              id: widget.id.toString(),
            );
          } else {
            return FetchErrorText(text: agent.message);
          }
        } else if (agent is AgencyAgentEdited) {
          return LoadedForm(id: widget.id.toString());
        }
        if (aCubit.editAgencyAgent != null) {
          return LoadedForm(id: widget.id.toString());
        } else {
          if (widget.id.isEmpty) {
            return LoadedForm(id: widget.id.toString());
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        }
      }),
      bottomNavigationBar: Container(
        width: double.infinity,
        // height: 190.0,
        height: 100,
        padding: const EdgeInsets.only(bottom: 5.0),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Row(
          children: [
            BlocConsumer<AgencyCubit, AgencyStateModel>(
                listener: (context, state) {
              final agent = state.agencyState;
              if (agent is CreateAgencyAgentLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (agent is CreateAgencyAgentError) {
                  if (agent.statusCode == 401) {
                    Utils.logout(context);
                  } else {
                    Utils.errorSnackBar(context, agent.message);
                  }
                } else if (agent is CreateAgencyAgentLoaded) {
                  Navigator.of(context).pop(true);
                  Utils.showSnackBar(context, agent.message);

                  aCubit.getAgencyAgentList();
                }
              }
            }, builder: (context, state) {
              final agent = state.agencyState;
              if (agent is AgencyAgentEditing) {
                return const SizedBox.shrink();
              } else if (agent is AgencyAgentEdited) {
                return _submitButton();
              }
              if (aCubit.editAgencyAgent != null) {
                return _submitButton();
              } else {
                if (widget.id.isEmpty) {
                  return _submitButton();
                } else {
                  return const SizedBox.shrink();
                }
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: Utils.symmetric(h: 30.0),
      child: GestureDetector(
        onTap: () {
          if (widget.id.isNotEmpty) {
            aCubit.updateAgencyAgent(widget.id);
          } else {
            aCubit.createAgencyAgent();
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: yellowColor),
          child: Padding(
            padding: Utils.symmetric(v: 10.0, h: 100.0),
            child: CustomTextStyle(
              text: widget.id.isEmpty ? 'Submit Now' : 'Update Now',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadedForm extends StatefulWidget {
  const LoadedForm({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LoadedForm> createState() => _LoadedFormState();
}

class _LoadedFormState extends State<LoadedForm> {
  StatusCode? _statusCode;
  @override
  Widget build(BuildContext context) {
    // print("idddddd: $id");
    final aCubit = context.read<AgencyCubit>();
    return ListView(
      padding: Utils.symmetric(),
      children: [
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Agent Name'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.name,
                  onChanged: (value) => aCubit.nameChange(value),
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.name.isNotEmpty)
                    ErrorText(text: stateStatus.errors.name.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Agent Email'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.email,
                  onChanged: (value) => aCubit.emailChange(value),
                  decoration: const InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.email.isNotEmpty)
                    ErrorText(text: stateStatus.errors.email.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Agent Phone'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.phone,
                  onChanged: (value) => aCubit.phoneChange(value),
                  decoration: const InputDecoration(
                      hintText: 'phone',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.number,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.phone.isNotEmpty)
                    ErrorText(text: stateStatus.errors.phone.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Designation'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.designation,
                  onChanged: (value) => aCubit.designationChange(value),
                  decoration: const InputDecoration(
                      hintText: 'designation',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.designation.isNotEmpty)
                    ErrorText(text: stateStatus.errors.designation.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Address'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.designation,
                  onChanged: (value) => aCubit.addressChange(value),
                  decoration: const InputDecoration(
                      hintText: 'address',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.address.isNotEmpty)
                    ErrorText(text: stateStatus.errors.address.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'About Me'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  maxLines: 4,
                  initialValue: state.aboutMe,
                  onChanged: (value) => aCubit.aboutMeChange(value),
                  decoration: const InputDecoration(
                      hintText: 'about me',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.aboutMe.isNotEmpty)
                    ErrorText(text: stateStatus.errors.aboutMe.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Instagram url'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.instagram,
                  onChanged: (value) => aCubit.instagramChange(value),
                  decoration: const InputDecoration(
                      hintText: 'Instagram url',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.instagram.isNotEmpty)
                    ErrorText(text: stateStatus.errors.instagram.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Linkedin url'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.linkedin,
                  onChanged: (value) => aCubit.linkedinChange(value),
                  decoration: const InputDecoration(
                      hintText: 'linkedin url',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.linkedin.isNotEmpty)
                    ErrorText(text: stateStatus.errors.linkedin.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
            final stateStatus = state.agencyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Twitter url'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.linkedin,
                  onChanged: (value) => aCubit.twitterChange(value),
                  decoration: const InputDecoration(
                      hintText: 'twitter url',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateAgencyAgentFormError) ...[
                  if (stateStatus.errors.twitter.isNotEmpty)
                    ErrorText(text: stateStatus.errors.twitter.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        widget.id.isEmpty
            ? Column(
                children: [
                  BlocBuilder<AgencyCubit, AgencyStateModel>(
                    builder: (context, state) {
                      final stateStatus = state.agencyState;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextStyle(text: 'Password'),
                          Utils.verticalSpace(6.0),
                          TextFormField(
                            initialValue: state.password,
                            onChanged: (value) => aCubit.passwordChange(value),
                            decoration: const InputDecoration(
                                hintText: 'password',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          ),
                          if (stateStatus is CreateAgencyAgentFormError) ...[
                            if (stateStatus.errors.password.isNotEmpty)
                              ErrorText(text: stateStatus.errors.password.first)
                          ]
                        ],
                      );
                    },
                  ),
                  Utils.verticalSpace(10.0),
                  BlocBuilder<AgencyCubit, AgencyStateModel>(
                    builder: (context, state) {
                      final stateStatus = state.agencyState;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextStyle(text: 'Confirm Password'),
                          Utils.verticalSpace(6.0),
                          TextFormField(
                            initialValue: state.passwordConfirmation,
                            onChanged: (value) => aCubit.cPasswordChange(value),
                            decoration: const InputDecoration(
                                hintText: 'password',
                                hintStyle: TextStyle(color: Colors.black38),
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            keyboardType: TextInputType.text,
                          ),
                          if (stateStatus is CreateAgencyAgentFormError) ...[
                            if (stateStatus
                                .errors.passwordConfirmation.isNotEmpty)
                              ErrorText(
                                  text: stateStatus
                                      .errors.passwordConfirmation.first)
                          ]
                        ],
                      );
                    },
                  ),
                ],
              )
            : const SizedBox.shrink(),
        Utils.verticalSpace(10.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
          builder: (context, state) {
           // final isImage = state.image.isNotEmpty;
            //final capturedImage = state.image;
            final s = state.agencyState;

            final existImage = aCubit.state.tempImage.isNotEmpty
                ? RemoteUrls.imageUrl(aCubit.state.tempImage)
                : KImages.defImage;

            final pickImage = state.image.isNotEmpty ? state.image : existImage;


           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const CustomTextStyle(text: "Upload Image"),
               Center(
                  child: Stack(
                    children: [
                      CircleImage(

                          image: pickImage, size: 120.0, isFile: state.image.isNotEmpty, ),
                      Positioned(
                        right: 6.0,
                        bottom: 5.0,
                        child: GestureDetector(
                          onTap: () async {
                            final img = await Utils.pickSingleImage();
                            if (img != null && img.isNotEmpty) {
                              aCubit.imageChange(img);
                            }
                          },
                          child: const CircleAvatar(
                            maxRadius: 16.0,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: whiteColor,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             ],
           );

          },
        ),
        Utils.verticalSpace(14.0),
        BlocBuilder<AgencyCubit, AgencyStateModel>(
            builder: (context, state) {

              if (statusCodeList
                  .where((job) => job.id.toString() == state.status)
                  .isNotEmpty) {
                _statusCode = statusCodeList
                    .where((job) => job.id.toString() == state.status)
                    .first;
              } else {
                _statusCode =
                null; // Handle the case where no match is found
              }
              final payInfo = state.agencyState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextStyle(
                    text: "Agent Status ",

                    color: blackColor,
                  ),
                  Utils.verticalSpace(10.0),
                  DropdownButtonFormField<StatusCode>(
                    hint: const CustomTextStyle(text: "Agent Status"),
                    isDense: true,
                    isExpanded: true,
                    value: _statusCode,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Utils.radius(10.0))),
                      ),
                    ),
                    onTap: () => Utils.closeKeyBoard(context),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _statusCode = value;
                      });
                      aCubit.statusChange(value.id.toString());
                    },
                    items: statusCodeList
                        .map<DropdownMenuItem<StatusCode>>(
                          (StatusCode value) =>
                          DropdownMenuItem<StatusCode>(
                            value: value,
                            child: CustomTextStyle(text: value.name),
                          ),
                    )
                        .toList(),
                  ),
                  if (payInfo is CreateAgencyAgentFormError) ...[
                    if (payInfo.errors.status.isNotEmpty)
                      ErrorText(text: payInfo.errors.status.first),
                  ]
                ],
              );
            }),
        Utils.verticalSpace(20.0),
      ],
    );
  }
}
