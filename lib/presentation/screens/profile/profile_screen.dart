import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/order/order_cubit.dart';

import '../home/component/agent_search.dart';
import '/presentation/utils/utils.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../../presentation/widget/primary_button.dart';
import '../../../data/model/agent/agent_profile_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../router/route_names.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import 'component/person_information.dart';
import 'component/person_single_property.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<ProfileCubit>().getAgentProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final loginBloc = context.read<LoginBloc>();
    final order = context.read<OrderCubit>();
    //profileCubit.getAgentProfile();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: PageRefresh(
        onRefresh: () async => profileCubit.getAgentProfile(),
        child: MultiBlocListener(
          listeners: [
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
                    //Navigator.of(context).pop();
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.loginScreen, (route) => false);
                    Utils.showSnackBar(context, logout.msg);
                  }
                }
              },
            ),
            BlocListener<AddPropertyCubit, AddPropertyModel>(
              listener: (context, state) {
                final updateState = state.addState;
                if (updateState is AddPropertyLoaded) {
                  profileCubit.getAgentDashboardInfo();
                }
              },
            ),
          ],
          child: BlocConsumer<ProfileCubit, ProfileStateModel>(
            listener: (context, state) {
              final profile = state.profileState;
              if (profile is ProfileUpdateLoaded) {
                Utils.showSnackBar(context, profile.message);
                //profileCubit.users = context.read<LoginBloc>().userInfo!.user;
                //final newUser = profileCubit.users;
                //profileCubit.getAgentDashboardInfo();
                profileCubit.getAgentProfile();
              } else if (profile is ProfileError) {
                if (profile.statusCode == 503 ||
                    profileCubit.agentDetailModel == null) {
                  profileCubit.getAgentProfile();
                }
                if (profile.statusCode == 401) {
                  //Utils.showSnackBar(context, profile.message);
                  loginBloc.add(const LoginEventLogout());
                }
              }
            },
            builder: (context, state) {
              final profileState = state.profileState;
              if (profileState is ProfileLoading) {
                return const LoadingWidget();
              } else if (profileState is ProfileError) {
                if (profileState.statusCode == 503 ||
                    profileCubit.agentDetailModel != null) {
                  return ProfileLoadedWidget(
                      properties: profileCubit.agentDetailModel!);
                } else {
                  return Center(
                      child: CustomTextStyle(
                          text: profileState.message, color: redColor));
                }
              } else if (profileState is ProfileLoaded) {
                return ProfileLoadedWidget(properties: profileState.profile);
              }
              if (profileCubit.agentDetailModel != null) {
                return ProfileLoadedWidget(
                    properties: profileCubit.agentDetailModel!);
              } else {
                return const Center(
                    child: CustomTextStyle(
                        text: 'Something went wrong', color: redColor));
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<ProfileCubit, ProfileStateModel>(
        builder: (context, state) {
          final profileState = state.profileState;
          if (profileState is ProfileLoading) {
            return const SizedBox.shrink();
          } else if (profileState is ProfileLoaded) {
            return Container(
              height: size.height * 0.12,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: PrimaryButton(
                text: 'Create New Property',
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteNames.choosePropertyOptionScreen);

                },
                bgColor: yellowColor,
                borderRadiusSize: radius,
                textColor: blackColor,
                fontSize: 20.0,
              ),
            );
          }
          if (profileCubit.agentDetailModel != null) {
            return Container(
            //  height: size.height * 0.12,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 34.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: PrimaryButton(
                text: 'Add New Property',
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteNames.choosePropertyOptionScreen);
                },
                bgColor: yellowColor,
                borderRadiusSize: radius,
                textColor: blackColor,
                fontSize: 20.0,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class ProfileLoadedWidget extends StatelessWidget {
  const ProfileLoadedWidget({super.key, required this.properties});

  final AgentProfileModel properties;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // if (properties.properties == null) {
    //   print('null');
    // } else {
    //   print('not null');
    // }
    return ListView(
      clipBehavior: Clip.none,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: [
        PersonInformation(properties: properties),
        SizedBox(height: size.height * 0.04),
        Padding(
          padding: Utils.symmetric(h: 8.0),
        //  child: const AgentSearch(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CustomTextStyle(
                text: 'My Property List',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ],
          ),
        ),
        if (properties.properties != null) ...[
          PersonSingleProperty(properties: properties.properties!.data!),
        ],
        SizedBox(height: size.height * 0.07),
      ],
    );
  }
}
