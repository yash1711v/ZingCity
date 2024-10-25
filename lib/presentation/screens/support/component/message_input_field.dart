import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/ticket/ticket_model.dart';
import '../../../../logic/cubit/support/support_cubit.dart';
import '../../../utils/constraints.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField({super.key});

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mCubit = context.read<SupportCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0)
          .copyWith(bottom: 8),
      child: BlocBuilder<SupportCubit, TicketModel>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  textInputAction: TextInputAction.done,
                  //initialValue: state.message,
                  controller: mCubit.messageController,
                  style: const TextStyle(fontSize: 16.0),
                  onChanged: (String text) {
                    //print('onChanged $text');
                    mCubit.changeSendMsg(text);
                  },
                  decoration: InputDecoration(
                    hintText: 'Type your message..',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    suffixIcon: IconButton(
                      splashRadius: 1.0,
                      onPressed: () {
                        mCubit.sendMessage();
                        mCubit.messageController.clear();
                        //mCubit.clear();
                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: state.messageFrom.trim().isNotEmpty
                            ? greenColor
                            : grayColor,
                        size: 30.0,
                      ),
                    ),
                    fillColor: const Color(0xffE2E8EB),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
