import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../state_inject_package_names.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Filters',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/Yash/images/crossIcon.svg")),
              const SizedBox(
                width: 25,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  'Type of Property',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.699999988079071),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 74.73,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0x19398BCB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          ImageIcon(
                            AssetImage(
                              "assets/images/iconamoon_profile-light.png",
                            ),
                            color: Color(0xFF398BCB),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Flat',
                            style: TextStyle(
                              color: Color(0xFF398BCB),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Budget',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.699999988079071),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
                const Spacer(),
                const Text(
                  '50 Lac-1 Cr',
                  style: TextStyle(
                    color: Color(0xFF30469A),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Slider(
          //   value: _selectedIndex.toDouble(),
          //   min: 0.0,
          //   max: 100.0,
          //   divisions: 100, // Divisions for discrete steps, optional
          //   label: _selectedIndex.toString(),
          //   onChanged: (double value) {
          //    setState(() {
          //      _selectedIndex = value.toInt();
          //    });
          //   },
          //   activeColor: Color(0xFF398BCB),
          //   inactiveColor: Color(0xFF398BCB).withOpacity(0.5),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('0', style: TextStyle(fontSize: 16)),
          //       Text('100', style: TextStyle(fontSize: 16)),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),

          SfRangeSelector(
            initialValues: const SfRangeValues(0.0, 100.0),
            min: 0.0,
            max: 100.0,
            interval: 10.0,
            activeColor: const Color(0xFF398BCB),
            inactiveColor: const Color(0xFF398BCB).withOpacity(0.5),
            tooltipShape: const SfRectangularTooltipShape(),
            tooltipTextFormatterCallback: (actualValue, formattedText) {
              return actualValue.toStringAsFixed(0);
            },
            labelFormatterCallback: (actualValue, formattedText) {
              // Show label only for the first (min) and last (max) values
              if (actualValue == 0.0) {
                return '0';
              } else if (actualValue == 100.0) {
                return '100';
              } else {
                return ''; // Hide labels for other values
              }
            },
            showTicks: false,
            showLabels: true,
            enableTooltip: true,
            onChanged: (SfRangeValues values) {
              print(values);
            },
            child: Container(),
          ),
          const SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.699999988079071),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 324,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadows: [
                        const BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'Select',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                              "assets/Yash/images/mage_location-fill.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Posted on',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.699999988079071),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 74.73,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: const Color(0x19398BCB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anytime',
                            style: TextStyle(
                              color: Color(0xFF398BCB),
                              fontSize: 14,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF30469A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                      onPressed: () {},
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
        ],
      ),
    );
  }
}
