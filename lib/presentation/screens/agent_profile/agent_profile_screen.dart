import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/screens/agent_profile/profile_pages/about_screen.dart';
import 'package:real_estate/presentation/screens/agent_profile/profile_pages/agency_agent_list_screen.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/model/agent/agent_details_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/agent/agent_cubit.dart';
import '../../../logic/cubit/agent/agent_state_model.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import 'component/agent_information.dart';
import 'component/agent_property_list.dart';

class AgentProfileScreen extends StatelessWidget {
  const AgentProfileScreen({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final login = context.read<LoginBloc>();
    final agentListCubit = context.read<AgentCubit>();
    agentListCubit.getAgentDetails(userName);
    print('userName $userName');
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async => agentListCubit.getAgentDetails(userName),
        child: BlocListener<AgentCubit, AgentStateModel>(
          listener: (context, state) {
            final agent = state.agentState;
            if (agent is AgentDetailsError) {
              if (agent.statusCode == 503) {
                //Utils.errorSnackBar(context, 'Reloaded data after 500 ms');
                Future.delayed(const Duration(milliseconds: 500), () {
                  agentListCubit.getAgentDetails(userName);
                });
              }
            }
          },
          child: BlocBuilder<AgentCubit, AgentStateModel>(
            builder: (context, state) {
              final agent = state.agentState;
              if (agent is AgentDetailsLoading) {
                return const LoadingWidget();
              } else if (agent is AgentDetailsError) {
                if (agent.statusCode == 503) {
                  return LoadedAgentProfile(
                      agentDetails: agentListCubit.agentDetailsModel!);
                } else {
                  return Center(
                    child: CustomTextStyle(
                      text: state.message,
                      color: redColor,
                    ),
                  );
                }
              }
              // else if (state is AgentDetailsLoaded) {
              //   return LoadedAgentProfile(agentDetails: state.agentDetailsModel);
              // }
              return LoadedAgentProfile(
                  agentDetails: agentListCubit.agentDetailsModel!);
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        // height: 190.0,
        height: 80.0,
        padding: const EdgeInsets.only(bottom: 5.0),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                    if (login.userInfo != null &&
                        login.userInfo!.accessToken.isNotEmpty) {
                      Navigator.pushNamed(context, RouteNames.sendMessageScreen,
                          arguments: agentListCubit.agentDetailsModel!.agent!.email);
                    } else {
                      Utils.showSnackBarWithLogin(context);
                    }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: yellowColor),
                child: Padding(
                  padding: Utils.symmetric(v: 6.0, h: 28.0),
                  child: const Row(
                    children: [
                      CustomImage(path: KImages.messageIcon),
                      SizedBox(
                        width: 6.0,
                      ),
                      CustomTextStyle(
                        text: "Message",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (login.userInfo != null &&
                    login.userInfo!.accessToken.isNotEmpty) {
                  Uri uri = Uri(scheme: 'tel', path: agentListCubit.agentDetailsModel!.agent!.phone);
                  //print(uri.runtimeType);
                  if (agentListCubit.agentDetailsModel!.agent!.phone.isNotEmpty) {
                    launchUrl(uri);
                  } else {
                    Utils.showSnackBar(context, 'Phone number is Empty');
                  }
                } else {
                  Utils.showSnackBarWithLogin(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: blackColor),
                child: Padding(
                  padding: Utils.symmetric(v: 6.0, h: 48.0),
                  child: const Row(
                    children: [
                      CustomImage(path: KImages.callIcon),
                      SizedBox(
                        width: 6.0,
                      ),
                      CustomTextStyle(
                        text: "Call",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadedAgentProfile extends StatelessWidget {
  const LoadedAgentProfile({super.key, required this.agentDetails});

  final AgentDetailsModel agentDetails;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // clipBehavior: Clip.none,
      physics: const ClampingScrollPhysics(),
      children: [
        AgentInformation(agent: agentDetails.agent!, agentDetails:agentDetails,),
        const SizedBox(height: 50.0),
        ProfileTabInfo(
          agentDetails: agentDetails,
        ),
        //  PropertyCount(propertyCount: agentDetails),

        // AgentPropertyList(properties: agentDetails.properties!),
        // const SizedBox(height: 40.0),
      ],
    );
  }
}

class ProfileTabInfo extends StatefulWidget {
  const ProfileTabInfo({
    super.key,
    required this.agentDetails,
  });

  final AgentDetailsModel agentDetails;

  @override
  State<ProfileTabInfo> createState() => _ProfileTabInfoState();
}

class _ProfileTabInfoState extends State<ProfileTabInfo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> detailScreen = [
      AgentPropertyList(properties: widget.agentDetails.properties!),
     // const AgencyAgentList(),
       AboutScreen(agentDetails: widget.agentDetails,),
    ];
    final List<String> tabTitle = [
      Utils.translatedText(context, 'Listing'),
     // Utils.translatedText(context, 'Agent'),
      Utils.translatedText(context, 'About'),
    ];
    return ExpandablePageView.builder(
      itemCount: detailScreen.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: Utils.symmetric(h: 16.0),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: borderColor,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    tabTitle.length,
                    (index) {
                      final active = _currentIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _currentIndex = index),
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: primaryColor),
                            color: active ? primaryColor : Colors.transparent,
                          ),
                          duration: const Duration(seconds: 0),
                          padding: Utils.symmetric(v: 8.0, h: 26.0),
                          margin: Utils.only(
                              left: index == 0 ? 0.0 : 16.0,
                              bottom: 0.0,
                              top: 10.0),
                          child: CustomTextStyle(
                            text: tabTitle[index],
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: active ? whiteColor : blackColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Utils.verticalSpace(16.0),
            Padding(
              padding: Utils.symmetric(h: 0.0, v: 10.0).copyWith(top: 0.0),
              child: detailScreen[_currentIndex],
            ),
          ],
        );
      },
    );
  }
}
