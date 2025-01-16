import 'package:real_estate/presentation/router/route_names.dart';
import 'package:real_estate/presentation/widget/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/agent/agent_details_model.dart';
import '../../../../data/model/auth/user_profile_model.dart';
import '../../../../logic/cubit/agent/agent_state_model.dart';
import '../../../../state_inject_package_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/contact_button.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/error_text.dart';
import '../../../widget/primary_button.dart';

class AgentInformation extends StatelessWidget {
  const AgentInformation(
      {super.key, required this.agent, required this.agentDetails});

  final UserProfileModel agent;
  final AgentDetailsModel agentDetails;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final login = context.read<LoginBloc>();
    final agentImage = agent.image.isNotEmpty
        ? agent.image
        : context.read<AppSettingCubit>().settingModel!.setting.defaultAvatar;
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: CustomImage(
              path: KImages.profileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: Row(
              children: [
                //const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: whiteColor,
                    minRadius: 16.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: grayColor,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                const CustomTextStyle(
                  text: 'Agent Profile',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: whiteColor,
                )
              ],
            ),
          ),
          Positioned.fill(
              top: size.height / 12.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ClipOval(
                      child: CustomImage(
                        path: RemoteUrls.imageUrl(agentImage),
                        height: size.height * 0.16,
                        width: size.height * 0.16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CustomTextStyle(
                          text: agent.name,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: whiteColor,
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
                  // CustomTextStyle(
                  //   text: agent.name,
                  //   fontSize: 20.0,
                  //   fontWeight: FontWeight.w600,
                  //   color: whiteColor,
                  // ),
                  // CustomTextStyle(
                  //   text: agent.designation,
                  //   fontSize: 14.0,
                  //   fontWeight: FontWeight.w400,
                  //   color: whiteColor,
                  // ),
                ],
              )),
          // Positioned(
          //   bottom: -14.0,
          //   left: 0.0,
          //   right: 0.0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       ContactButton(
          //         onPressed: () {
          //           if (login.userInfo != null &&
          //               login.userInfo!.accessToken.isNotEmpty) {
          //             Navigator.pushNamed(context, RouteNames.sendMessageScreen,
          //                 arguments: agent.email);
          //           } else {
          //             Utils.showSnackBarWithLogin(context);
          //           }
          //         },
          //         bgColor: yellowColor,
          //         text: 'Message',
          //         icon: KImages.messageIcon,
          //         iconTextColor: blackColor,
          //       ),
          //       ContactButton(
          //         onPressed: () async {
          //           if (login.userInfo != null &&
          //               login.userInfo!.accessToken.isNotEmpty) {
          //             Uri uri = Uri(scheme: 'tel', path: agent.phone);
          //             //print(uri.runtimeType);
          //             if (agent.phone.isNotEmpty) {
          //               launchUrl(uri);
          //             } else {
          //               Utils.showSnackBar(context, 'Phone number is Empty');
          //             }
          //           } else {
          //             Utils.showSnackBarWithLogin(context);
          //           }
          //         },
          //         bgColor: blackColor,
          //         text: 'Call',
          //         icon: KImages.callIcon,
          //         iconTextColor: whiteColor,
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: -35.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: Utils.all(value: 10.0),
                  // height: 66,
                  width: 108,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: whiteColor),
                  child: Column(
                    children: [
                      CustomTextStyle(
                        text: agentDetails.totalProperty.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextStyle(
                        text: 'Property',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7E8BA0),
                      ),
                    ],
                  ),
                ),
                Utils.horizontalSpace(10.0),
                Container(
                  padding: Utils.all(value: 10.0),
                  // height: 66,
                  width: 108,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: whiteColor),
                  child: Column(
                    children: [
                      CustomTextStyle(
                        text: agentDetails.totalReview.toString(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const CustomTextStyle(
                        text: 'Review',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7E8BA0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SendMessageDialog extends StatelessWidget {
  const SendMessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final agentCubit = context.read<AgentCubit>();
    const spacer = SizedBox(height: 12.0);
    return Dialog(
      child: ListView(
        // mainAxisSize: MainAxisSize.min,

        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextStyle(
                text: 'Write Message',
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: blackColor,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CustomImage(path: KImages.cancelIcon))
            ],
          ),
          const SizedBox(height: 14.0),
          BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            final s = state.agentState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  onChanged: (String name) => agentCubit.nameChange(name),
                  initialValue: state.name,
                ),
                if (s is AgentSendMessageFormValidate) ...[
                  if (s.errors.name.isNotEmpty)
                    ErrorText(text: s.errors.name.first)
                ]
              ],
            );
          }),
          spacer,
          BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            final s = state.agentState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  onChanged: (String name) => agentCubit.emailChange(name),
                  initialValue: state.email,
                ),
                if (s is AgentSendMessageFormValidate) ...[
                  if (s.errors.email.isNotEmpty)
                    ErrorText(text: s.errors.email.first)
                ]
              ],
            );
          }),
          spacer,
          BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            final s = state.agentState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Agent Email',
                  ),
                  onChanged: (String name) => agentCubit.agentEmailChange(name),
                  initialValue: state.agentEmail,
                ),
                if (s is AgentSendMessageFormValidate) ...[
                  if (s.errors.agentEmail.isNotEmpty)
                    ErrorText(text: s.errors.agentEmail.first)
                ]
              ],
            );
          }),
          spacer,
          BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            final s = state.agentState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Subject',
                  ),
                  onChanged: (String name) => agentCubit.subjectChange(name),
                  initialValue: state.subject,
                ),
                if (s is AgentSendMessageFormValidate) ...[
                  if (s.errors.subject.isNotEmpty)
                    ErrorText(text: s.errors.subject.first)
                ]
              ],
            );
          }),
          spacer,
          BlocBuilder<AgentCubit, AgentStateModel>(builder: (_, state) {
            final s = state.agentState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Message',
                  ),
                  onChanged: (String name) => agentCubit.messageChange(name),
                  initialValue: state.message,
                ),
                if (s is AgentSendMessageFormValidate) ...[
                  if (s.errors.message.isNotEmpty)
                    ErrorText(text: s.errors.message.first)
                ]
              ],
            );
          }),
          const SizedBox(height: 20.0),
          BlocBuilder<AgentCubit, AgentStateModel>(
            builder: (context, state) {
              final s = state.agentState;
              if (s is AgentSendMessageLoading) {
                return const LoadingWidget();
              }
              return PrimaryButton(
                  text: 'Send Message',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    agentCubit.sendMessageToAgent();
                  },
                  textColor: blackColor,
                  fontSize: 20.0,
                  borderRadiusSize: radius,
                  bgColor: yellowColor);
            },
          )
        ],
      ),
    );
  }
}
