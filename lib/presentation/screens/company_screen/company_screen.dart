import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/logic/cubit/agency/agency_cubit.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/presentation/widget/custom_app_bar.dart';
import 'package:real_estate/presentation/widget/primary_button.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/agency/agency_list_model.dart';
import '../../../logic/cubit/agency/agency_state_model.dart';
import '../../../logic/cubit/agency/delete_agent_cubit/delete_agent_cubit.dart';
import '../../../logic/cubit/agency/delete_agent_cubit/delete_agent_state.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_images.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/empty_widget.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  late AgencyCubit aCubit;
  late CompanyCubit cCubit;

  @override
  void initState() {
    aCubit = context.read<AgencyCubit>();
    cCubit = context.read<CompanyCubit>();
    aCubit.getAgencyAgentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTextStyle(text: "My Company",fontWeight: FontWeight.w500,fontSize: 18,),
      actions: [
        Padding(
          padding: Utils.only(right: 20.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteNames.updateCompanyScreen);
            },
            child: Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: borderColor
                )
              ), child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child:  CustomImage(path:RemoteUrls.imageUrl(cCubit.profile!.image))),
            ),
          ),
        )
      ],
      ),
      body: Padding(
        padding: Utils.symmetric(v: 10.0),
        child: Column(
          children: [
            PrimaryButton(
                text: "Add New Agent",
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.createAgentScreen, arguments: '');
                  aCubit.resetData();
                }),
            Utils.verticalSpace(10.0),
            MultiBlocListener(
              listeners: [
                BlocListener<AgencyDeleteCubit, AgencyDeleteState>(
                  listener: (context, state) {

                    if (state is DeleteAgencyAgentLoading) {
                      Utils.loadingDialog(context);
                    } else {
                      Utils.closeDialog(context);
                      if (state is DeleteAgencyAgentSuccess) {
                        Navigator.of(context).pop();
                        Utils.showSnackBar(context, state.message);
                      } else if (state is DeleteAgencyAgentError) {
                        if (state.statusCode == 403) {
                          Utils.closeDialog(context);
                        }
                        Utils.errorSnackBar(context, state.errorMessage);
                      }
                    }
                  },
                ),
              ],
              child: BlocConsumer<AgencyCubit, AgencyStateModel>(
                  listener: (context, state) {
                final agentList = state.agencyState;
                if (agentList is AgencyAgentListError) {
                  if (agentList.statusCode == 503 || aCubit.agencyAgent == null) {
                    aCubit.getAgencyAgentList();
                  }
                }
              }, builder: (context, state) {
                final agentList = state.agencyState;
                if (agentList is AgencyAgentListLoading) {
                  return const LoadingWidget();
                } else if (agentList is AgencyAgentListError) {
                  if (agentList.statusCode == 503 || aCubit.agencyAgent != null) {
                    return LoadedAgencyAgent(agency: aCubit.agencyAgent!);
                  } else {
                    return ErrorText(text: agentList.message);
                  }
                } else if (agentList is AgencyAgentListLoaded) {
                  return LoadedAgencyAgent(agency: aCubit.agencyAgent!);
                }
                if (aCubit.agencyAgent != null) {
                  return LoadedAgencyAgent(agency: aCubit.agencyAgent!);
                } else {
                  return const ErrorText(text: 'Something want wrong');
                }
              }),
            )


          ],
        ),
      ),
    );
  }
}

class LoadedAgencyAgent extends StatelessWidget {
  const LoadedAgencyAgent({
    super.key,
    required this.agency,
  });

  final List<AgencyListModel> agency;

  @override
  Widget build(BuildContext context) {
    final aCubit = context.read<AgencyCubit>();
    final dCubit = context.read<AgencyDeleteCubit>();
    return agency.isNotEmpty ? Expanded(
      child: GridView.builder(
          itemCount: agency.length,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0)
              .copyWith(bottom: 40.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.76),
          itemBuilder: (context, index) {
            final agent = agency[index];
            return Stack(
              children: [
                Container(
                  width: 160.0.w,
                  margin: const EdgeInsets.only(right: 0.0),
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                         height: 160.0,
                         child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3.0),
                            topRight: Radius.circular(3.0),
                          ),
                          child: CustomImage(
                            path: RemoteUrls.imageUrl(agent.image),
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                                               ),
                       ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0)
                            .copyWith(bottom: 6.0),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, RouteNames.agentProfileScreen,arguments: agent.userName);
                                    },
                                    child: CustomTextStyle(
                                      text: agent.name,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                      maxLine: 1,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                // Utils.horizontalSpace(agent.kycStatus == 1 ? 4.0 : 0),
                                // if (agent.kycStatus == 1) ...[
                                //   const Icon(
                                //     Icons.verified_rounded,
                                //     color: Color(0xFF01BF8B),
                                //     size: 18.0,
                                //   )
                                // ],
                              ],
                            ),
                            CustomTextStyle(
                              text: agent.designation,
                              // text: agent.designation.isNotEmpty
                              //     ? agent.designation
                              //     : 'Your Designation',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: grayColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 10,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            aCubit.resetData();
                            Navigator.pushNamed(context, RouteNames.createAgentScreen,arguments:agent.id.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: blackColor),
                            child: Padding(
                              padding: Utils.all(value: 6.0),
                              child: const CustomImage(
                                path: KImages.editIcon,
                                height: 20,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        Utils.verticalSpace(8.0),
                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (context)=>
                            //     Dialog(
                            //   child: SizedBox(
                            //     height: 250,
                            //     child: Padding(
                            //       padding: Utils.symmetric(h: 16.0, v: 20.0),
                            //       child: Column(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //         const CustomImage(path: KImages.delete, height: 50,),
                            //         Utils.verticalSpace(16.0),
                            //         const CustomTextStyle(text: "Are you really want to delete this agent ?", fontSize: 16,fontWeight: FontWeight.w500,textAlign: TextAlign.center,),
                            //         Expanded(
                            //           child: Row(children: [
                            //             Expanded(child: GestureDetector(
                            //               onTap: (){
                            //                 dCubit.deleteAgencyAgent(agent.id.toString());
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0),
                            //                 color: primaryColor
                            //                 ),
                            //                 child: Padding(
                            //                   padding: Utils.symmetric(h: 16.0, v: 8.0),
                            //                   child: const CustomTextStyle(text: "Yes,Delete it",textAlign: TextAlign.center,color: whiteColor,),
                            //                 ),
                            //               ),
                            //             )),
                            //             Utils.horizontalSpace(4.0),
                            //             Expanded(child: GestureDetector(
                            //               onTap: (){
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0),
                            //                     color: redColor
                            //                 ),
                            //                 child: Padding(
                            //                   padding: Utils.symmetric(h: 16.0, v: 8.0),
                            //                   child: const CustomTextStyle(text: "Cancel",textAlign: TextAlign.center,color: whiteColor,),
                            //                 ),
                            //               ),
                            //             )),
                            //           ],),
                            //         )
                            //       ],),
                            //     ),
                            //   ),
                            //
                            // ),
                            AlertDialog(
                              title: const CustomTextStyle(
                                text: 'Confirmation',
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                              ),
                              content: const CustomTextStyle(
                                text: 'Do you want to delete this Agent?',
                                fontSize: 16.0,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const CustomTextStyle(
                                    text: 'Cancel',
                                    color: blackColor,
                                  ),
                                  onPressed: () {
                                   Navigator.pop(context);// Dismiss alert dialog
                                  },
                                ),
                                TextButton(
                                  child: const CustomTextStyle(
                                    text: 'Delete',
                                    color: redColor,
                                  ),
                                  onPressed: () {
                                    dCubit.deleteAgencyAgent(agent.id.toString());
                                  },
                                ),
                              ],
                            ),

                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: redColor),
                            child: Padding(
                              padding: Utils.all(value: 6.0),
                              child: const Icon(Icons.delete_outline_outlined,color: whiteColor,size: 24,),
                              // child: const CustomImage(
                              //   path: KImages.delete,
                              //   height: 20,
                              //   color: whiteColor,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            );
          }),
    ) :  const EmptyWidget(icon: KImages.emptyAgent, title: 'No  Agents');
  }
}
