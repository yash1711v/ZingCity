import 'package:real_estate/presentation/widget/primary_button.dart';

import '../router/route_packages_name.dart';
import '../utils/constraints.dart';
import '../utils/utils.dart';

class CreateUpdateSubmitButton extends StatelessWidget {
  const CreateUpdateSubmitButton({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      padding: Utils.only(
        left: 20.0,
        right: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      margin: Utils.symmetric(h: 0.0, v: 20.0).copyWith(bottom: 20.0),
      // decoration: const BoxDecoration(
      //   color: primaryColor,
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      // ),
      child: PrimaryButton(
        text: title,
        onPressed: press,
        bgColor: yellowColor,
        borderRadiusSize: radius,
        textColor: blackColor,
        fontSize: 20.0,
      ),
    );
  }
}
