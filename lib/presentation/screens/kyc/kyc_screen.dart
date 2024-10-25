import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/kyc/kyc_model.dart';
import '../../../logic/cubit/kyc/kyc_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_images.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/error_text.dart';
import '../../widget/primary_button.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  late KycCubit kycCubit;
  KycItem? _kycItem;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    kycCubit = context.read<KycCubit>();
    if (kycCubit.kycModel != null && kycCubit.kycModel!.kycType!.isNotEmpty) {
      _kycItem = kycCubit.kycModel!.kycType!.first;
      kycCubit.kycType(_kycItem!.id);
    } else {
      _kycItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'KYC Submit',
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Utils.verticalSpace(20.0),
             if(kycCubit.kycModel != null && kycCubit.kycModel!.kycType!.isNotEmpty)...[   DropdownButtonFormField<KycItem>(
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
                 kycCubit.kycType(val.id);
               },

               items: kycCubit.kycModel!.kycType!.isNotEmpty?kycCubit.kycModel!.kycType!
                   .map<DropdownMenuItem<KycItem>>((KycItem value) =>
                   DropdownMenuItem<KycItem>(
                       value: value,
                       child: CustomTextStyle(text: value.name)))
                   .toList():[],
             ),],
                BlocBuilder<KycCubit, KycItem>(
                  builder: (context, state) {
                    final editState = state.kycState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: state.message,
                          decoration: InputDecoration(
                              hintText: Utils.translatedText(
                                  context, 'message', true)),
                          keyboardType: TextInputType.text,
                          maxLines: 2,
                          onChanged: (String name) => kycCubit.kycMessage(name),
                        ),
                        if (editState is KycSubmitFormError) ...[
                          if (editState.errors.phone.isNotEmpty)
                            ErrorText(text: editState.errors.phone.first)
                        ]
                      ],
                    );
                  },
                ),
                BlocBuilder<KycCubit, KycItem>(
                  builder: (context, state) {
                    //print('file ${state.file}');
                    final editState = state.kycState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.file.isNotEmpty) ...[
                          Stack(
                            children: [
                              if (state.file.endsWith('.jpg') ||
                                  state.file.endsWith('.jpeg') ||
                                  state.file.endsWith('.png')) ...[
                                Container(
                                  height: Utils.hSize(180.0),
                                  margin: Utils.symmetric(v: 16.0, h: 0.0),
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: Utils.borderRadius(),
                                    child: CustomImage(
                                      path: state.file,
                                      isFile: state.file.isNotEmpty,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 20,
                                  child: InkWell(
                                    onTap: () => kycCubit.kycFileClear(),
                                    child: const CircleAvatar(
                                      maxRadius: 16.0,
                                      backgroundColor: Color(0xff18587A),
                                      child: Icon(Icons.clear,
                                          color: Colors.white, size: 20.0),
                                    ),
                                  ),
                                )
                              ] else ...[
                                Container(
                                  padding: Utils.symmetric(v: 16.0, h: 10.0),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: Utils.borderRadius(r: 6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextStyle(
                                        text: state.file.split('/').last,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      InkWell(
                                        onTap: () => kycCubit.kycFileClear(),
                                        child: const Icon(Icons.clear,
                                            color: blackColor, size: 26.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          )
                        ] else ...[
                          GestureDetector(
                            onTap: () async {
                              final image = await Utils.pickSingleFile();
                              if (image != null && image.isNotEmpty) {
                                kycCubit.kycFile(image);
                              }
                            },
                            child: Container(
                              height: Utils.hSize(50.0),
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: Utils.borderRadius(),
                              ),
                              child: DottedBorder(
                                padding: Utils.symmetric(v: 14.0),
                                borderType: BorderType.RRect,
                                radius: Radius.circular(Utils.radius(10.0)),
                                color: primaryColor,
                                dashPattern: const [6, 3],
                                strokeCap: StrokeCap.square,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_box_rounded,
                                      color: grayColor,
                                    ),
                                    Utils.horizontalSpace(5.0),
                                    CustomTextStyle(
                                      text: Utils.translatedText(
                                          context, 'Add New file'),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: grayColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                        if (editState is KycSubmitFormError) ...[
                          if (editState.errors.file.isNotEmpty)
                            ErrorText(text: editState.errors.file.first)
                        ],
                        Utils.verticalSpace(24.0),
                      ],
                    );
                  },
                ),
                BlocListener<KycCubit, KycItem>(
                  listener: (context, kyc) {
                    final state = kyc.kycState;
                    if (state is KycSubmitLoading) {
                      Utils.loadingDialog(context);
                    } else {
                      Utils.closeDialog(context);
                      if (state is KycSubmitError) {
                        Utils.errorSnackBar(context, state.message);
                      } else if (state is KycSubmitLoaded) {
                        Utils.showSnackBar(context, state.message);
                        kycCubit.getKycInfo();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: PrimaryButton(
                      text: Utils.translatedText(context, 'Submit'),
                      onPressed: () {
                        Utils.closeKeyBoard(context);
                        kycCubit.submitKyc();
                      }),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
