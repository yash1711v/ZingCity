import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

import '../../../state_inject_package_names.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> titles = [
    'No. of Bedrooms',
    'No. of Bathrooms',
    // 'No. of Balconies',
    'No. of Kitchens',
    'No. of Garage',
  ];
  List<String> images = [
    'assets/Yash/images/BedRoom.svg',
    'assets/Yash/images/Bathroom.svg',
    // 'No. of Balconies',
    'assets/Yash/images/kitchen.svg',
    'assets/Yash/images/Garage.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 339,
                //         child: Text(
                //           'Add values',
                //           style: TextStyle(
                //             color: Color(0xFF4D5454),
                //             fontSize: 14,
                //             fontFamily: 'Manrope',
                //             fontWeight: FontWeight.w400,
                //             height: 0.10,
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 25,
                // ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: const Color(0x19087C7C),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(images[index]),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 297,
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                      color: Color(0xFF4D5454),
                                      fontSize: 16,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w400,
                                      height: 0.09,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if(index == 0) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalBedroom(value);
                                }

                                if(index == 1) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalBathroom(value);
                                }

                                if(index == 2) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalKitchen(value);
                                }

                                if(index == 3) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalGarage(value);
                                }


                              },
                              decoration: InputDecoration(
                                fillColor: Color(0xFFF5F5F5),
                                hintText: 'Enter ${titles[index].replaceAll("No. of ", "")}',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
