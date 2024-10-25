import 'package:intl/intl.dart';

import '../../../../data/model/booking/booking_model.dart';
import '../../../../logic/cubit/booking/booking_cubit.dart';
import '../../../../state_inject_package_names.dart';
import '../../../utils/constraints.dart';
import '../../../widget/error_text.dart';

class DateTimeView extends StatefulWidget {
  const DateTimeView({super.key});

  @override
  State<DateTimeView> createState() => _DateTimeViewState();
}

class _DateTimeViewState extends State<DateTimeView> {
  late BookingCubit bCubit;
  DateTime? selectedDate;
  late TimeOfDay dataTime;
  late TextEditingController startTimeController;
  late TextEditingController dateController;

  void init() {
    bCubit = context.read<BookingCubit>();
    dataTime = TimeOfDay.now();
    dateController = TextEditingController(text: 'Select data');
    startTimeController = TextEditingController(text: 'Select time');
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        bCubit.changeDate(formattedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: dataTime,
    );
    if (pickedTime != null && pickedTime != dataTime) {
      setState(() {
        dataTime = pickedTime;
        // Convert TimeOfDay to DateTime to format the time string correctly
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          dataTime.hour,
          dataTime.minute,
        );
        // Format the time to HH:mm:ss
        String formattedTime = DateFormat('HH:mm:ss').format(selectedDateTime);
        startTimeController.text = dataTime.format(context).toString();//formattedTime;
        bCubit.changeTime(formattedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingModel>(
      builder: (context, state) {
        final booking = state.bookState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                hintText: 'Select date',
                suffixIcon: Icon(
                  Icons.calendar_today,
                  size: 20.0,
                  color: blackColor,
                ),
              ),
            ),
            if (booking is BookingFormError) ...[
              if (booking.errors.bookingDate.isNotEmpty)
                ErrorText(text: booking.errors.bookingDate.first)
            ],
            const SizedBox(height: 12.0),
            TextFormField(
              readOnly: true,
              controller: startTimeController,
              decoration: InputDecoration(
                  hintText: dataTime.format(context).toString(),
                  suffixIcon: const Icon(
                    Icons.watch_later_outlined,
                    color: blackColor,
                  )),
              onTap:()=> _selectTime(context),
              // onTap: () async {
              //   TimeOfDay? time = await showTimePicker(
              //       context: context, initialTime: dataTime);
              //   if (time != null) {
              //     setState(() {
              //       dataTime = time;
              //       startTimeController.text =
              //           dataTime.format(context).toString();
              //       bCubit.changeTime(startTimeController.text);
              //     });
              //   }
              // },
            ),
            if(state.bookingDate.isNotEmpty)
            if (booking is BookingFormError) ...[
              if (booking.errors.bookingTime.isNotEmpty)
                ErrorText(text: booking.errors.bookingTime.first)
            ],
          ],
        );
      },
    );
  }
}
