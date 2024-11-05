import 'package:real_estate/presentation/screens/property_create/ScreenFour.dart';

import '../../../state_inject_package_names.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_theme.dart';
import 'add_screen2.dart';
import 'add_screen3.dart';
import 'add_scren1.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor:  Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(
          360,
          200,
        ),
        child: Container(
            width: 360,
            height: 200,
            decoration:  BoxDecoration(
              color:  Color(0xFFE7EBF4),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 16, right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/Yash/images/ZingCityLogo.png",
                        width: 50.03,
                        height: 35.01,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if(pageController.page == 0){
                        Navigator.pop(context); } else {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                        ),
                        Text(
                          'Add Property',
                          style: TextStyle(
                            color: Color(0xFF30469A),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
        ScreenOne(),
        AddScreen2(),
        Screen3(),
       Screenfour(),
      ]),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
