import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/utils/utils.dart';

import '../../../data/model/booking/booking_model.dart';
import '../../../logic/cubit/booking/booking_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/error_text.dart';
import '../../widget/primary_button.dart';
import '../property_details/component/date_time_view.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  late BookingCubit addProperty;

  _initState() {
    addProperty = context.read<BookingCubit>();
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: 'Booking',
        bgColor: whiteColor,
      ),
      body: ListView(
        padding: Utils.symmetric(h: 16.0, v: 20.0),
        children: [
          const DateTimeView(),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              final stateStatus = state.bookState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.tempGuests,
                    onChanged: (value) => addProperty.changeGuest(value),
                    decoration: const InputDecoration(
                        hintText: 'Guest', labelText: 'Guest'),
                    keyboardType: TextInputType.phone,
                  ),
                  if(state.bookingTime.isNotEmpty)
                  if (stateStatus is BookingFormError) ...[
                    if (stateStatus.errors.guest.isNotEmpty)
                      ErrorText(text: stateStatus.errors.guest.first)
                  ]
                ],
              );
            },
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              final stateStatus = state.bookState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.name,
                    onChanged: (value) => addProperty.changeName(value),
                    decoration: const InputDecoration(
                        hintText: 'Name', labelText: 'Name'),
                    keyboardType: TextInputType.text,
                  ),
                  if(state.tempGuests.isNotEmpty)
                  if (stateStatus is BookingFormError) ...[
                    if (stateStatus.errors.name.isNotEmpty)
                      ErrorText(text: stateStatus.errors.name.first)
                  ]
                ],
              );
            },
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              final stateStatus = state.bookState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.phone,
                    onChanged: (value) => addProperty.changePhone(value),
                    decoration: const InputDecoration(
                        hintText: 'Phone', labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                  ),
                  if(state.name.isNotEmpty)
                  if (stateStatus is BookingFormError) ...[
                    if (stateStatus.errors.phone.isNotEmpty)
                      ErrorText(text: stateStatus.errors.phone.first)
                  ]
                ],
              );
            },
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              final stateStatus = state.bookState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.city,
                    onChanged: (value) => addProperty.changeCity(value),
                    decoration: const InputDecoration(
                        hintText: 'City', labelText: 'City'),
                    keyboardType: TextInputType.text,
                  ),
                  if(state.phone.isNotEmpty)
                  if (stateStatus is BookingFormError) ...[
                    if (stateStatus.errors.city.isNotEmpty)
                      ErrorText(text: stateStatus.errors.city.first)
                  ]
                ],
              );
            },
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.zipCode,
                onChanged: (value) => addProperty.changeZipcode(value),
                decoration: const InputDecoration(
                    hintText: 'Zip code', labelText: 'Zip code'),
                keyboardType: TextInputType.streetAddress,
              );
            },
          ),
          Utils.verticalSpace(16.0),
          BlocBuilder<BookingCubit, BookingModel>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.comment,
                onChanged: (value) => addProperty.changeComment(value),
                decoration: const InputDecoration(
                    hintText: 'Comment', labelText: 'Comment'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocListener<BookingCubit, BookingModel>(
          listener: (context, state) {
            final property = state.bookState;
            if (property is BookingCreating) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (property is BookingCreateError) {
                if (property.statusCode == 401) {
                  Utils.logout(context);
                } else {
                  Utils.errorSnackBar(context, property.message);
                }
              } else if (property is BookingCreated) {
                Navigator.of(context).pop(true);
                Utils.showSnackBar(context, property.message);
              }
            }
          },
          child: _submitButton()),
    );
  }

  Widget _submitButton() {
    return Container(
      padding: Utils.only(
        left: 20.0,
        right: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      margin: Utils.symmetric(h: 0.0, v: 20.0).copyWith(bottom: 20.0),
      child: PrimaryButton(
          text: 'Confirm Booking',
          onPressed: () {
            Utils.closeKeyBoard(context);
            addProperty.createBooking();
          },
          textColor: blackColor,
          fontSize: 20.0,
          borderRadiusSize: radius,
          bgColor: yellowColor),
    );
  }
}
