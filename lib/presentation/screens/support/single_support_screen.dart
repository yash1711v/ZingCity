import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/login/login_bloc.dart';

import '../../../data/model/ticket/ticket_model.dart';
import '../../../logic/cubit/support/support_cubit.dart';

import '../../router/route_names.dart';

import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_rounded_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/page_refresh.dart';
import 'component/client_chat_loaded.dart';

class SingleSupportScreen extends StatefulWidget {
  const SingleSupportScreen({super.key, required this.applicantId});

  final String applicantId;

  @override
  State<SingleSupportScreen> createState() => _SingleSupportScreenState();
}

class _SingleSupportScreenState extends State<SingleSupportScreen> {
  late SupportCubit inboxCubit;
  late ScrollController controller;
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    inboxCubit = context.read<SupportCubit>();
    loginBloc = context.read<LoginBloc>();
    inboxCubit.changeTicketId(widget.applicantId);
    Future.microtask(() => inboxCubit.showTicket(widget.applicantId));
    inboxCubit.isOpen(true);
    //controller.addListener(_scrollListener);
  }

  // void listenChatChannel() {
  //   final id = loginBloc.userInformation!.user!.id;
  //   LaravelEcho.instance
  //       .private('new_message.$id')
  //       .listen('NewMessageNotification', (e) {
  //     debugPrint("NewMessageNotification $e");
  //     if (e is PusherEvent) {
  //       if (e.data != null) {
  //         _handleNewMessage(jsonDecode(e.data!));
  //       }
  //       //inboxCubit.add(MessageEventShowChat());
  //     }
  //   }).error((err) {
  //     eLog(err);
  //   });
  // }
  //
  // void leaveChatChannel() {
  //   try {
  //     LaravelEcho.instance
  //         .leave('new_message.${loginBloc.userInformation!.user!.id}');
  //     debugPrint('chat-room-leaved');
  //   } catch (err) {
  //     debugPrint('chat-room-leaved-error $err');
  //     eLog(err);
  //   }
  // }
  //
  // void _handleNewMessage(Map<String, dynamic> data) {
  //   debugPrint('new-message-arrived $data');
  //   debugPrint('new-message-comes');
  //   inboxCubit.add(MessageEventShowChat());
  //   // _scrollToBottom();
  // }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    inboxCubit.isOpen(false);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('chat-id ${widget.applicantId}');
    return Scaffold(
      appBar: const CustomRoundedAppBar(text: 'My Conversation'),
      body: PageRefresh(
        onRefresh: () async {
          inboxCubit.showTicket(widget.applicantId);
          _scrollToBottom();
        },
        child: MultiBlocListener(
          listeners: [
            // BlocListener<ApprovalCubit, ApprovalState>(
            //   listener: (context, state) {
            //     if (state is ApprovalLoading) {
            //       Utils.loadingDialog(context);
            //     } else {
            //       Utils.closeDialog(context);
            //       if (state is ApprovalError) {
            //         Utils.errorSnackBar(context, state.message);
            //       } else if (state is ApprovalDemoLoaded) {
            //         inboxCubit.add(const MessageDemoStatus('success'));
            //         Utils.showSnackBar(
            //             context, state.message, whiteColor, 2500);
            //       } else if (state is ApprovalCompletedLoaded) {
            //         inboxCubit.add(const MessageCompletedStatus('success'));
            //         Utils.showSnackBar(
            //             context, state.message, whiteColor, 2500);
            //       }
            //     }
            //   },
            // ),
            BlocListener<SupportCubit, TicketModel>(
              listener: (context, state) {
                final sCubit = state.supState;

                if (sCubit is SupportMessageSent) {
                  //_scrollToBottom();
                  // debugPrint('reloaded $sCubit');
                  // inboxCubit.add(const MessageEventResetMsg());
                  // inboxCubit.add(MessageEventShowChat());
                  // _scrollToBottom();

                  inboxCubit..clear()..showTicket(widget.applicantId);
                }

                if (sCubit is RefreshStateEveryFive) {
                  inboxCubit.showTicket(widget.applicantId);
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
          child: BlocConsumer<SupportCubit, TicketModel>(
            listener: (context, state) {
              final package = state.supState;
              if (package is SupportShowTicketError) {
                if (package.statusCode == 503) {
                  inboxCubit.showTicket(widget.applicantId);
                }
                if (package.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, state) {
              final plan = state.supState;
              if (plan is SupportShowTicketError) {
                if (plan.statusCode == 501) {
                  return LoadedChatWidgetClient(
                      messages: inboxCubit.showTickets, controller: controller);
                } else {
                  return FetchErrorText(text: plan.message);
                }
              } else if (plan is SupportShowTickets) {
                _scrollToBottom();
                return LoadedChatWidgetClient(
                    messages: plan.tickets, controller: controller);
              }
              if (inboxCubit.showTickets.isNotEmpty) {
                return LoadedChatWidgetClient(
                    messages: inboxCubit.showTickets, controller: controller);
              } else {
                return const FetchErrorText(
                  text: 'Loading..',
                  textColor: blackColor,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
