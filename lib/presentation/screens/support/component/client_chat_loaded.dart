import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../../data/model/ticket/ticket_model.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/support/support_cubit.dart';
import '../../../utils/k_images.dart';
import '../../../widget/empty_widget.dart';
import 'message_input_field.dart';
import 'single_chat_component.dart';

class LoadedChatWidgetClient extends StatefulWidget {
  const LoadedChatWidgetClient(
      {super.key, required this.messages, required this.controller});

  final List<TicketModel> messages;
  final ScrollController controller;

  @override
  State<LoadedChatWidgetClient> createState() => _LoadedChatWidgetClientState();
}

class _LoadedChatWidgetClientState extends State<LoadedChatWidgetClient> {
  late SupportCubit inboxCubit;
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    inboxCubit = context.read<SupportCubit>();
    loginBloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, TicketModel>(
      builder: (context, state) {
        return Column(
          children: [
            Utils.verticalSpace(10.0),
            if (widget.messages.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  controller: widget.controller,
                  shrinkWrap: true,
                  itemCount: widget.messages.length,
                  itemBuilder: (context, index) {
                    final m = widget.messages[index];
                    final isSeller = m.messageFrom == 'user';
                    // final isSeller = m.messageFrom == 'buyer' || m.isQuestion == true;
                    return SingleChat(m: m, isSeller: isSeller);
                  },
                ),
              ),
            ] else ...[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const EmptyWidget(
                      icon: KImages.emptyReview, title: 'No Message Found!'),
                ),
              )
            ],
            MessageInputField(),
          ],
        );
      },
    );
  }
}
