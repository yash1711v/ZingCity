import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/ticket/ticket_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/delete_info/delete_info_cubit.dart';
import '../../../logic/cubit/support/support_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_rounded_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/heading_dialog.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import '../../widget/primary_button.dart';
import 'component/support_component.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late SupportCubit supportCubit;
  String? priority;

  _initState() {
    supportCubit = context.read<SupportCubit>();
    Future.microtask(() => supportCubit.getAllTickets());
    if (supportCubit.priorities.isNotEmpty &&
        supportCubit.state.priority.isEmpty) {
      priority = supportCubit.priorities.first;
      supportCubit.changePriority(priority!);
    } else {
      priority = null;
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
      // backgroundColor: whiteColor,
      appBar: const CustomRoundedAppBar(text: 'Support'),
      body: PageRefresh(
        onRefresh: () async => supportCubit.getAllTickets(),
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
          child: BlocConsumer<SupportCubit, TicketModel>(
            listener: (context, state) {
              final property = state.supState;
              if (property is SupportTicketError) {
                if (property.statusCode == 503) {
                  supportCubit.getAllTickets();
                }
                if (property.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, state) {
              final property = state.supState;
              if (property is SupportTicketLoading) {
                return const LoadingWidget();
              } else if (property is SupportTicketError) {
                if (property.statusCode == 503) {
                  return LoadedTicketView(allTickets: supportCubit.allTickets);
                } else {
                  return FetchErrorText(text: property.message);
                }
              } else if (property is SupportTicketLoaded) {
                return LoadedTicketView(allTickets: property.tickets);
              }
              if (supportCubit.allTickets.isNotEmpty) {
                return LoadedTicketView(allTickets: supportCubit.allTickets);
              } else {
                return const FetchErrorText(text: 'Something went wrong!');
              }
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<SupportCubit, TicketModel>(
        builder: (context, state) {
          final property = state.supState;

          if (property is SupportTicketLoading) {
            return const SizedBox.shrink();
          } else if (property is SupportTicketLoaded) {
            return _submitButton();
          }
          return _submitButton();
        },
      ),
    );
  }

  Widget _submitButton() {
    return FloatingActionButton(
      onPressed: () {
        supportCubit.clear();
        _deleteDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }

  void _deleteDialog(BuildContext context) {
    Utils.showCustomDialog(
      hp: 20.0,
      context,
      child: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeading(
              title: 'Create New Support',
              onTap: () {
                Navigator.of(context).pop();
                supportCubit.clear();
              },
            ),
            BlocBuilder<SupportCubit, TicketModel>(
              builder: (context, state) {
                final validate = state.supState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (supportCubit.priorities.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        isDense: true,
                        isExpanded: true,
                        value: priority,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: borderColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: borderColor),
                          ),
                        ),
                        hint: const CustomTextStyle(
                          text: 'Select Type',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_sharp,
                            color: blackColor),
                        items: supportCubit.priorities.isNotEmpty
                            ? supportCubit.priorities
                                .map<DropdownMenuItem<String>>((e) =>
                                    DropdownMenuItem(
                                        value: e,
                                        child: CustomTextStyle(
                                            text: e, fontSize: 16.0)))
                                .toList()
                            : [],
                        onChanged: (val) {
                          if (val == null) return;
                          supportCubit.changePriority(val);
                        },
                      ),
                    ],
                    Utils.verticalSpace(12.0),
                    TextFormField(
                      onChanged: supportCubit.changeSubject,
                      decoration: const InputDecoration(
                        hintText: 'Subject',
                        filled: true,
                        //fillColor: scaffoldBgColor,
                      ),
                      initialValue: state.subject,
                      keyboardType: TextInputType.text,
                    ),
                    Utils.verticalSpace(12.0),
                    TextFormField(
                      onChanged: supportCubit.changeCreateMsg,
                      decoration: const InputDecoration(
                          hintText: 'Message', filled: true),
                      initialValue: state.subject,
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                );
              },
            ),
            Utils.verticalSpace(20.0),
            BlocConsumer<SupportCubit, TicketModel>(
              listener: (context, state) {
                final validate = state.supState;
                if (validate is SupportCreateInfoError) {
                  Navigator.pop(context);
                  Utils.errorSnackBar(context, validate.message);
                } else if (validate is SupportCreated) {
                  supportCubit.getAllTickets();
                  Navigator.pop(context);
                  Utils.showSnackBar(context, validate.tickets);
                  //bloc.add(const LoginEventClearUserCredential());
                }
              },
              builder: (context, state) {
                final validate = state.supState;
                final isEmpty = state.subject.trim().isNotEmpty &&
                    state.message.trim().isNotEmpty;
                if (validate is SupportCreating) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                    text: isEmpty ? 'Create' : 'Field is required',
                    bgColor: isEmpty ? primaryColor : grayColor,
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      if (isEmpty) {
                        supportCubit.createTicket();
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoadedTicketView extends StatelessWidget {
  const LoadedTicketView({super.key, required this.allTickets});

  final List<TicketModel> allTickets;

  @override
  Widget build(BuildContext context) {
    if (allTickets.isNotEmpty) {
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: allTickets.length,
        itemBuilder: (context, index) =>
            SupportComponent(singleOrder: allTickets[index]),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const EmptyWidget(
            icon: KImages.emptyReview, title: 'No Support Found!'),
      );
    }
  }
}
