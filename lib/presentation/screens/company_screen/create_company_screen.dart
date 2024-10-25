import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/data/model/kyc/company_kyc_model.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/logic/cubit/company/company_state.dart';
import 'package:real_estate/logic/cubit/company/company_state_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../state_inject_package_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/circle_image.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_images.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/error_text.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';

class CreateCompanyScreen extends StatefulWidget {
  const CreateCompanyScreen({
    super.key,
  });

  @override
  State<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  late CompanyCubit cCubit;

  @override
  void initState() {
    cCubit = context.read<CompanyCubit>();
   // cCubit.getCompanyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: 'Create Company',

        bgColor: whiteColor,
      ),
      body:LoadedForm(),
      // BlocConsumer<CompanyCubit, CompanyStateModel>(
      //     listener: (context, state) {
      //   final company = state.companyState;
      //   if (company is GetCompanyProfileError) {
      //     if (company.statusCode == 503 || cCubit.profile == null) {
      //       cCubit.getCompanyProfile();
      //     }
      //     if (company.statusCode == 401) {
      //       Utils.logout(context);
      //     }
      //   }
      // }, builder: (context, state) {
      //   final company = state.companyState;
      //   if (company is GetCompanyProfileLoading) {
      //     return const LoadingWidget();
      //   } else if (company is GetCompanyProfileError) {
      //     if (company.statusCode == 503 || cCubit.profile != null) {
      //       return const LoadedForm();
      //     } else {
      //       return FetchErrorText(text: company.message);
      //     }
      //   } else if (company is GetCompanyProfileLoaded) {
      //     return const LoadedForm();
      //   }
      //   if (cCubit.profile != null) {
      //     return const LoadedForm();
      //   } else {
      //     return const FetchErrorText(text: 'Something went wrong!');
      //   }
      // }),
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
            BlocConsumer<CompanyCubit, CompanyStateModel>(
                listener: (context, state) {
              final agent = state.companyState;
              if (agent is CreateCompanyLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (agent is CreateCompanyError) {
                  if (agent.statusCode == 401) {
                    Utils.logout(context);
                  } else {
                    Utils.errorSnackBar(context, agent.message);
                  }
                } else if (agent is CreateCompanyLoaded) {
                  Navigator.of(context).pop(true);
                  Utils.showSnackBar(context, agent.message);

                }
              }
            }, builder: (context, state) {
              final agent = state.companyState;
                 return _submitButton();
              // if (agent is GetCompanyProfileLoading) {
              //   return const SizedBox.shrink();
              // } else if (agent is GetCompanyProfileLoaded) {
              //   return _submitButton();
              // }
              // if (cCubit.profile != null) {
              //   return _submitButton();
              // } else {
              //   return const SizedBox.shrink();
              // }
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
          // if (cCubit.profile != null) {
          //   cCubit.updateCompanyProfile(cCubit.profile!.id.toString());
          // } else {
             cCubit.createCompany();
          // }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: yellowColor),
          child: Padding(
            padding: Utils.symmetric(v: 10.0, h: 100.0),
            child: CustomTextStyle(
              text:  'Submit Now',
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
  });

  @override
  State<LoadedForm> createState() => _LoadedFormState();
}

class _LoadedFormState extends State<LoadedForm> {
  late CompanyCubit cCubit;

  KycListModel? _kycItem;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    cCubit = context.read<CompanyCubit>();
    if (cCubit.kycListModel.isNotEmpty) {
      _kycItem = cCubit.kycListModel.first;
      cCubit.kycIdChange(_kycItem!.id.toString());
    } else {
      _kycItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: Utils.symmetric(),
      children: [
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company Name'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.name,
                  onChanged: (value) => cCubit.nameChange(value),
                  decoration: const InputDecoration(
                      hintText: 'company name',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.name.isNotEmpty)
                    ErrorText(text: stateStatus.errors.name.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company Email'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.email,
                  onChanged: (value) => cCubit.emailChange(value),
                  decoration: const InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.email.isNotEmpty)
                    ErrorText(text: stateStatus.errors.email.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company Phone'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.phone,
                  onChanged: (value) => cCubit.phoneChange(value),
                  decoration: const InputDecoration(
                      hintText: 'phone',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.phone.isNotEmpty)
                    ErrorText(text: stateStatus.errors.phone.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company TagLine'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.tagLine,
                  onChanged: (value) => cCubit.tagLineChange(value),
                  decoration: const InputDecoration(
                      hintText: 'tagLine',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.tagLine.isNotEmpty)
                    ErrorText(text: stateStatus.errors.tagLine.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company AboutUs'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  maxLines: 4,
                  initialValue: state.aboutMe,
                  onChanged: (value) => cCubit.aboutUsChange(value),
                  decoration: const InputDecoration(
                      hintText: 'about us',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.aboutMe.isNotEmpty)
                    ErrorText(text: stateStatus.errors.aboutMe.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Company Address'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.address,
                  onChanged: (value) => cCubit.addressChange(value),
                  decoration: const InputDecoration(
                      hintText: 'address',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.address.isNotEmpty)
                    ErrorText(text: stateStatus.errors.address.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Instagram'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.instagram,
                  onChanged: (value) => cCubit.instagramChange(value),
                  decoration: const InputDecoration(
                      hintText: 'Instagram',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.instagram.isNotEmpty)
                    ErrorText(text: stateStatus.errors.instagram.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Twitter'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.twitter,
                  onChanged: (value) => cCubit.twitterChange(value),
                  decoration: const InputDecoration(
                      hintText: 'Twitter',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.twitter.isNotEmpty)
                    ErrorText(text: stateStatus.errors.twitter.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Linkedin'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.linkedin,
                  onChanged: (value) => cCubit.linkedinChange(value),
                  decoration: const InputDecoration(
                      hintText: 'Linkedin',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.linkedin.isNotEmpty)
                    ErrorText(text: stateStatus.errors.linkedin.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(10.0),
        // BlocBuilder<CompanyCubit, CompanyStateModel>(
        //   builder: (context, state) {
        //     final isImage = state.image.isNotEmpty;
        //     //final capturedImage = state.image;
        //     final s = state.companyState;
        //
        //     // final existImage = aCubit.state.tempImage.isNotEmpty
        //     //     ? RemoteUrls.imageUrl(aCubit.state.tempImage)
        //     //     : RemoteUrls.imageUrl(
        //     //   aCubit.editAgencyAgent!.image.isNotEmpty
        //     //       ? aCubit.editAgencyAgent!.image
        //     //       : KImages.defImage,
        //     // );
        //
        //     final pickImage =
        //         state.image.isNotEmpty ? state.image : KImages.defImage;
        //
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const CustomTextStyle(text: "Upload Image"),
        //         Center(
        //           child: Container(
        //             height: 150.0,
        //             margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
        //             width: 160.0,
        //             alignment: Alignment.center,
        //             decoration: const BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: Color(0XFFEBEBEB),
        //               //borderRadius: BorderRadius.circular(4.0),
        //             ),
        //             child: isImage
        //                 ? CustomImage(
        //                     path: pickImage,
        //                     isFile: isImage,
        //                   )
        //                 : Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       const CustomImage(path: KImages.defImage),
        //                       const SizedBox(width: 5.0),
        //                       GestureDetector(
        //                         onTap: () async {
        //                           final image = await Utils.pickSingleImage();
        //                           if (image != null && image.isNotEmpty) {
        //                             cCubit.imageChange(image);
        //                           }
        //                         },
        //                         child: const Text(
        //                           'Upload',
        //                           style: TextStyle(
        //                             color: Colors.blue,
        //                             fontWeight: FontWeight.w500,
        //                             fontSize: 16.0,
        //                             decoration: TextDecoration.underline,
        //                             decorationColor: Colors.blue,
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //           ),
        //         ),
        //         if (s is CreateCompanyFormError) ...[
        //           if (s.errors.image.isNotEmpty)
        //             ErrorText(text: s.errors.image.first)
        //         ],
        //         const SizedBox(height: 20.0),
        //       ],
        //     );
        //   },
        // ),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final edit = state.companyState;

            final existImage = cCubit.state.tempImage.isNotEmpty
                ? RemoteUrls.imageUrl(cCubit.state.tempImage)
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
                          image: pickImage, size: 140.0, isFile: state.image.isNotEmpty),
                      Positioned(
                        right: 6.0,
                        bottom: 5.0,
                        child: GestureDetector(
                          onTap: () async {
                            final img = await Utils.pickSingleImage();
                            if (img != null && img.isNotEmpty) {
                              cCubit.imageChange(img);
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextStyle(text: "Select Kyc"),
            Utils.verticalSpace(10.0),
            if (cCubit.kycListModel.isNotEmpty) ...[
              DropdownButtonFormField<KycListModel>(
                hint: CustomTextStyle(
                    text: Utils.translatedText(context, 'Select Type', true)),
                isDense: true,
                isExpanded: true,
                value: _kycItem,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Utils.radius(10.0))),
                  ),
                ),
                // onTap: () {
                //   Utils.closeKeyBoard(context);
                // },
                onChanged: (val) {
                  if (val == null) return;
                  cCubit.kycIdChange(val.id.toString());
                },

                items: cCubit.kycListModel.isNotEmpty
                    ? cCubit.kycListModel
                        .map<DropdownMenuItem<KycListModel>>(
                            (KycListModel value) =>
                                DropdownMenuItem<KycListModel>(
                                    value: value,
                                    child: CustomTextStyle(text: value.name)))
                        .toList()
                    : [],
              ),
            ],
          ],
        ),
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final edit = state.companyState;
            final existImage = cCubit.state.tempFile.isNotEmpty
                ? RemoteUrls.imageUrl(cCubit.state.tempFile)
                : KImages.defImage;

            final pickImage = state.file.isNotEmpty ? state.file : existImage;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: "Upload File"),
                Center(
                  child: Stack(
                    children: [
                      CircleImage(
                          image: pickImage, size: 140.0, isFile: state.file.isNotEmpty),
                      Positioned(
                        right: 6.0,
                        bottom: 5.0,
                        child: GestureDetector(
                          onTap: () async {
                            final img = await Utils.pickSingleFile();
                            if (img != null && img.isNotEmpty) {
                              cCubit.fileChange(img);
                            }
                          },
                          child: const CircleAvatar(
                            maxRadius: 16.0,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.edit,
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
        Utils.verticalSpace(10.0),
        BlocBuilder<CompanyCubit, CompanyStateModel>(
          builder: (context, state) {
            final stateStatus = state.companyState;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextStyle(text: 'Message'),
                Utils.verticalSpace(6.0),
                TextFormField(
                  initialValue: state.message,
                  onChanged: (value) => cCubit.messageChange(value),
                  decoration: const InputDecoration(
                      hintText: 'message',
                      hintStyle: TextStyle(color: Colors.black38),
                      labelStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: TextInputType.text,
                ),
                if (stateStatus is CreateCompanyFormError) ...[
                  if (stateStatus.errors.message.isNotEmpty)
                    ErrorText(text: stateStatus.errors.message.first)
                ]
              ],
            );
          },
        ),
        Utils.verticalSpace(20.0),
      ],
    );
  }
}
