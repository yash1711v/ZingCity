import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/logic/cubit/booking/booking_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/data/data_provider/remote_url.dart';
import '/presentation/utils/k_strings.dart';
import '/presentation/widget/custom_test_style.dart';
import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/cubit/setting/app_setting_cubit.dart';
import '../router/route_names.dart';
import '../widget/custom_images.dart';
import 'constraints.dart';
import 'k_images.dart';

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();
  static Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;

  static String convertNumber(dynamic value) {
    if (value < 1000) {
      return value.toString();
    } else if (value < 1000000) {
      double result = value / 1000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else if (value < 1000000000) {
      double result = value / 1000000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    } else {
      double result = value / 1000000000.0;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}B';
    }
  }
  static String translatedText(BuildContext context, String key,
      [bool lower = false]) {
    return key;
    // final webSetting = context.read<WebsiteSetupCubit>().setting;
    // if (lower == true) {
    //   if (webSetting != null && webSetting.lang![key] != null) {
    //     return webSetting.lang![key]!.toLowerCase();
    //   } else {
    //     return key.toLowerCase();
    //   }
    // } else {
    //   if (webSetting != null && webSetting.lang![key] != null) {
    //     return '${webSetting.lang![key]}';
    //   } else {
    //     return key;
    //   }
    // }
  }

  static String formatPrice(BuildContext context, var price) {
    final currency =
        context.read<AppSettingCubit>().settingModel!.setting.currencyIcon;

    String formatNumber(int value) {
      if (value < 1000) {
        return value.toString();
      } else if (value < 1000000) {
        double result = value / 1000.0;
        return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
      } else if (value < 1000000000) {
        double result = value / 1000000.0;
        return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
      } else {
        double result = value / 1000000000.0;
        return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}B';
      }
    }

    if (price is double) {
      int intValue = price.toInt();
      return '$currency${formatNumber(intValue)}';
    }
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      int intValue = p.toInt();
      return '$currency${formatNumber(intValue)}';
    }
    return '$currency${price.toStringAsFixed(1)}';
  }

  static String htmlTextConverter(String text) {
    var document = parse(text);
    String convertedText = parse(document.body!.text).documentElement!.text;
    return convertedText;
  }

  static Widget logoutListener({required Widget child}) {
    return BlocListener<LoginBloc, LoginModelState>(
      listener: (context, state) {
        final logout = state.state;
        if (logout is LoginStateLogOutLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (logout is LoginStateSignOutError) {
            Utils.errorSnackBar(context, logout.errorMsg);
          } else if (logout is LoginStateLogOut) {
            context.read<BookingCubit>().clearComId();
            Utils.showSnackBar(context, logout.msg);
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.loginScreen,
              (route) => false,
            );
          }
        }
      },
      child: child,
    );
  }
  static List<TextInputFormatter> allowDecimal = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}$'))
  ];

  static Future<void> logout(BuildContext context) async {
    context.read<LoginBloc>().add(const LoginEventLogout());
  }

  static void showSnackBarWithLogin(
    BuildContext context, {
    VoidCallback? onPress,
    Color textColor = Colors.white,
  }) {
    onPress ??= () => Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.loginScreen, (route) => false);

    final snackBar = SnackBar(
      content: const CustomTextStyle(
        text: 'Please login first',
        color: whiteColor,
        fontSize: 12.0,
        maxLine: 1,
      ),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Login',
        onPressed: onPress,
        textColor: Colors.yellow,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String formatPriceIcon(BuildContext context, var price) {
    final currency =
        context.read<AppSettingCubit>().settingModel!.setting.currencyIcon;
    if (price is double) return currency + price.toStringAsFixed(1);
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return currency + p.toStringAsFixed(1);
    }
    return currency + price.toStringAsFixed(1);
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static String convertToSlug(String input) {
    // Replace spaces and special characters with hyphens and lowercase the string
    return input.toLowerCase().replaceAll(RegExp(r'[^a-zA-Z\d]+'), '-');
  }

  static Future<List<String>> pickMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<String> imageList = [];
    final List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      // imageList.addAll(images);
      //  return images.map((e) => imageList.add(e!.path)).toList();
      for (var i in images) {
        imageList.add(i!.path.toString());
      }
      debugPrint('picked images: ${imageList.length}');
      return imageList;
    }
    return [];
  }
  static Future<String?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'jpg', 'jpeg', 'zip', 'pdf', 'png'],
    );
    if (result != null &&
        result.files.single.path != null &&
        result.files.single.path!.isNotEmpty) {
      File file = File(result.files.single.path!);
      debugPrint('file-path ${file.path}');
      return file.path;
    } else {
      debugPrint('file path not found');
      return '';
    }
  }

  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    // return DateFormat.MMMEd().format(_dateTime.toLocal());
    return DateFormat.yMMMMd().format(dateTime.toLocal());
  }

  static String timeAgo(String? time) {
    try {
      if (time == null) return '';
      return timeago.format(DateTime.parse(time));
    } catch (e) {
      return '';
    }
  }

  static String convertToAgo(String? time) {
    Duration diff = DateTime.now().difference(DateTime.parse(time!));

    try {
      if (diff.inDays >= 1) {
        return '${diff.inDays} days ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hours ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minutes ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} seconds ago';
      } else {
        return 'Just Now';
      }
    } catch (e) {
      return '';
    }
  }

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void appInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // insetPadding: Utils.symmetric(h: 10.0),
          // contentPadding: Utils.symmetric(h: 10.0),
          title: Text(
            KString.appTitle,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: blackColor, fontSize: 16.0),
          ),
          shape: RoundedRectangleBorder(borderRadius: Utils.borderRadius()),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoLabel(label: 'Name', text: KString.appName),
              SizedBox(height: 6),
              InfoLabel(label: 'Version', text: KString.appVersion),
              SizedBox(height: 6),
              InfoLabel(label: 'Developed by', text: KString.appDeveloper),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const CustomTextStyle(
                text: 'Dismiss',
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(width: 15),
              Text('Please wait a moment')
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
    double hp = 40.0,
    double vp = 24.0,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = whiteColor,int duration = 800]) {
    final snackBar = SnackBar(
        duration:  Duration(milliseconds: duration),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void serviceUnAvailable(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 500),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = primaryColor]) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: 'Active',
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static defaultIcon(BuildContext context) {
    final icon = context.read<AppSettingCubit>().settingModel!.setting.logo;
    return CustomImage(
      path: RemoteUrls.imageUrl(icon) ?? KImages.logo,
      height: 80.0,
      width: 80.0,
    );
  }
}

class InfoLabel extends StatelessWidget {
  const InfoLabel({
    super.key,
    this.label,
    this.text,
  });

  final String? label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "${label!} : ",
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, color: blackColor, fontSize: 14.0),
        children: [
          TextSpan(
            text: text!,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: blackColor, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
