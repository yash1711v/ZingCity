import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';
import 'package:real_estate/presentation/screens/property_create/add_screen2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../data/model/add_property_model.dart' as addProperty;
import '../../state_inject_package_names.dart';
// import '../../state_inject_package_names.dart';

class CustomBottomSheet extends StatefulWidget {
  final bool isRent;
  final String typeOfProperty;

  const CustomBottomSheet(
      {super.key, required this.isRent, required this.typeOfProperty});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int _selectedIndex = 0;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  int minValue = 0;
  int maxValue = 10000;
  int? selectedMinValue;
  int? selectedMaxValue;
  int? roomTypeId;
  int? cityID;

  String roomType = "";
  String city = "";
  String possession = "";
  int? possessionId;

  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();

  Future<void> getData() async {
    setState(() {
      isLoaded = true;
    });
    // isLoaded = true;
    await context.read<AddPropertyCubit>().getData().then((value) {
      debugPrint("Data Loaded: $value");
      // if (context.read<AddPropertyCubit>().state.staticInfo?.status == true) {
      //   setState(() {
      //     isLoaded = false;
      //   });
      // }
      isLoaded = false;
    });
  }

  List<addProperty.RoomType> possessionStatus = [
    addProperty.RoomType(
        name: "Ready to Move", id: 0, createdAt: DateTime.now(), updatedAt: DateTime.now()),
    addProperty.RoomType(
        name: "Within 3 Months", id: 1, createdAt: DateTime.now(), updatedAt: DateTime.now()),
    addProperty.RoomType(
        name: "Within 6 Months", id: 1, createdAt: DateTime.now(), updatedAt: DateTime.now()),
    addProperty.RoomType(
        name: "Within 12 Months", id: 1, createdAt: DateTime.now(), updatedAt: DateTime.now()),
    // addProperty.RoomType(),
    // {"name":"Ready to Move"},
    // {"name":"Within 3 Months"},
    // {"name":"Within 6 Months"},
    // {"name":"Within 12 Months"},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
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
          child: isLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
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
                              child: SvgPicture.asset(
                                  "assets/Yash/images/crossIcon.svg")),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // // Padding(
                      // //   padding: const EdgeInsets.only(left: 16.0),
                      // //   child: Row(
                      // //     children: [
                      // //       Text(
                      // //         'Type of Property',
                      // //         style: TextStyle(
                      // //           color: Colors.black.withOpacity(0.699999988079071),
                      // //           fontSize: 16,
                      // //           fontFamily: 'DM Sans',
                      // //           fontWeight: FontWeight.w300,
                      // //           height: 0,
                      // //         ),
                      // //       ),
                      // //     ],
                      // //   ),
                      // // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // // Padding(
                      // //   padding: EdgeInsets.only(left: 15.0),
                      // //   child: Row(
                      // //     children: [
                      // //       for (int i = 0; i < (widget.isRent ? (state.staticInfo ??
                      // //           addProperty.PropertyTypeResponse(status: false,
                      // //               message: '',
                      // //               sale: [],
                      // //               rent: [],
                      // //               state: [],
                      // //               city: [],
                      // //               roomType: [],
                      // //               nearestLocation: [],
                      // //               amenities: [])).rent.length:(state.staticInfo ??
                      // //           addProperty.PropertyTypeResponse(status: false,
                      // //               message: '',
                      // //               sale: [],
                      // //               rent: [],
                      // //               state: [],
                      // //               city: [],
                      // //               roomType: [],
                      // //               nearestLocation: [],
                      // //               amenities: [])).sale.length); i++)
                      // //         Padding(
                      // //           padding: const EdgeInsets.only(right: 10),
                      // //           child: Expanded(
                      // //             child: Container(
                      // //               // width: 74.73,
                      // //               height: 32,
                      // //               decoration: ShapeDecoration(
                      // //                 color: const Color(0x19398BCB),
                      // //                 shape: RoundedRectangleBorder(
                      // //                     borderRadius: BorderRadius.circular(3)),
                      // //               ),
                      // //               child: Padding(
                      // //                 padding: const EdgeInsets.all(8.0),
                      // //                 child: Row(
                      // //                   children: [
                      // //                     Text(
                      // //                       (state.staticInfo ??
                      // //                           addProperty.PropertyTypeResponse(
                      // //                               status: false,
                      // //                               message: '',
                      // //                               sale: [],
                      // //                               rent: [],
                      // //                               state: [],
                      // //                               city: [],
                      // //                               roomType: [],
                      // //                               nearestLocation: [],
                      // //                               amenities: [])).rent[i].name,
                      // //                       style: TextStyle(
                      // //                         color: Color(0xFF398BCB),
                      // //                         fontSize: 14,
                      // //                         fontFamily: 'DM Sans',
                      // //                         fontWeight: FontWeight.w400,
                      // //                         height: 0,
                      // //                       ),
                      // //                     ),
                      // //                   ],
                      // //                 ),
                      // //               ),
                      // //             ),
                      // //           ),
                      // //         ),
                      // //     ],
                      // //   ),
                      // // ),
                      // // const SizedBox(
                      // //   height: 10,
                      // // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Text(
                              'Area',
                              style: TextStyle(
                                color:
                                    Colors.black.withOpacity(0.699999988079071),
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${selectedMinValue ?? minValue} - ${selectedMaxValue ?? maxValue} sq.ft',
                              style: const TextStyle(
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
                      // // const SizedBox(
                      // //   height: 10,
                      // // ),
                      // // Slider(
                      // //   value: _selectedIndex.toDouble(),
                      // //   min: 0.0,
                      // //   max: 100.0,
                      // //   divisions: 100, // Divisions for discrete steps, optional
                      // //   label: _selectedIndex.toString(),
                      // //   onChanged: (double value) {
                      // //    setState(() {
                      // //      _selectedIndex = value.toInt();
                      // //    });
                      // //   },
                      // //   activeColor: Color(0xFF398BCB),
                      // //   inactiveColor: Color(0xFF398BCB).withOpacity(0.5),
                      // // ),
                      // // Padding(
                      // //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      // //   child: Row(
                      // //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // //     children: [
                      // //       Text('0', style: TextStyle(fontSize: 16)),
                      // //       Text('100', style: TextStyle(fontSize: 16)),
                      // //     ],
                      // //   ),
                      // // ),
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      SfRangeSelector(
                        initialValues:
                            SfRangeValues(selectedMinValue ?? minValue, selectedMaxValue ?? maxValue),
                        min: minValue,
                        max: maxValue,
                        interval: 10.0,
                        activeColor: const Color(0xFF398BCB),
                        inactiveColor: const Color(0xFF398BCB).withOpacity(0.5),
                        tooltipShape: const SfRectangularTooltipShape(),
                        tooltipTextFormatterCallback:
                            (actualValue, formattedText) {
                          return actualValue.toStringAsFixed(0);
                        },
                        labelFormatterCallback: (actualValue, formattedText) {
                          // Show label only for the first (min) and last (max) values
                          if (actualValue == minValue) {
                            return '0';
                          } else if (actualValue == maxValue) {
                            return '$maxValue';
                          } else {
                            return ''; // Hide labels for other values
                          }
                        },
                        showTicks: false,
                        showLabels: true,
                        enableTooltip: true,
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            selectedMinValue = values.start.toInt();
                            selectedMaxValue = values.end.toInt();
                          });
                          // selectedMinValue = values.start.toInt();
                          // selectedMaxValue = values.end.toInt();
                          print(values);
                        },
                        child: Container(),
                      ),
                      const SizedBox(
                        height: 45,
                      ),

                      //
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Location',
                      //         style: TextStyle(
                      //           color: Colors.black.withOpacity(0.699999988079071),
                      //           fontSize: 16,
                      //           fontFamily: 'DM Sans',
                      //           fontWeight: FontWeight.w300,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                color:
                                    Colors.black.withOpacity(0.699999988079071),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Min Price',
                                ),
                                controller: minPriceController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Max Price',
                                ),
                                controller: maxPriceController,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Room Type',
                              style: TextStyle(
                                color:
                                    Colors.black.withOpacity(0.699999988079071),
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
                        child: CustomDropdown(
                          title: 'Select Room Type',
                          states: state.staticInfo?.roomType ?? [],
                          selectedState: roomType.isEmpty ? null : roomType,
                          onChanged: (value) {
                            setState(() {
                              roomType = value ?? "";
                              state.staticInfo?.roomType?.forEach((element) {
                                if (element.name == roomType) {
                                  roomTypeId = element.id;
                                }
                              });
                            });
                          },
                          isRoomType: true,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'City',
                              style: TextStyle(
                                color:
                                    Colors.black.withOpacity(0.699999988079071),
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
                        child: CustomDropdown(
                          title: 'Select City',
                          states: state.staticInfo?.city ?? [],
                          selectedState: city.isEmpty ? null : city,
                          onChanged: (value) {
                            setState(() {
                              city = value ?? "";
                              state.staticInfo?.city?.forEach((element) {
                                if (element.name == city) {
                                  cityID = element.id;
                                }
                              });
                              // cityID = state.staticInfo?.city.indexWhere((element) => element.name == city) ?? 0;
                            });
                          },
                          isRoomType: false,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Possession',
                              style: TextStyle(
                                color:
                                    Colors.black.withOpacity(0.699999988079071),
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomDropdown(
                          title: 'Select Possession',
                          states: possessionStatus,
                          selectedState: possession.isEmpty ? null : possession,
                          onChanged: (value) {
                            setState(() {
                              possession = value ?? "";
                              if (value == "Ready to Move") {
                                possessionId = 1;
                              }
                              ;
                              if (value == "Within 3 Months") {
                                possessionId = 2;
                              }
                              if (value == "Within 6 Months") {
                                possessionId = 3;
                              }
                              if (value == "Within 12 Months") {
                                possessionId = 4;
                              }
                              // cityID = state.staticInfo?.city.indexWhere((element) => element.name == city) ?? 0;
                            });
                          },
                          isRoomType: false,
                        ),
                      ),

                      //
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Location',
                      //         style: TextStyle(
                      //           color: Colors.black.withOpacity(0.699999988079071),
                      //           fontSize: 16,
                      //           fontFamily: 'DM Sans',
                      //           fontWeight: FontWeight.w300,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: 324,
                      //         height: 45,
                      //         decoration: ShapeDecoration(
                      //           color: Colors.white,
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(5)),
                      //           shadows: [
                      //             const BoxShadow(
                      //               color: Color(0x19000000),
                      //               blurRadius: 8,
                      //               offset: Offset(0, 0),
                      //               spreadRadius: 0,
                      //             )
                      //           ],
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'Select',
                      //                 style: TextStyle(
                      //                   color: Colors.black.withOpacity(0.5),
                      //                   fontSize: 13,
                      //                   fontFamily: 'DM Sans',
                      //                   fontWeight: FontWeight.w300,
                      //                   height: 0,
                      //                 ),
                      //               ),
                      //
                      //               SvgPicture.asset(
                      //                   "assets/Yash/images/mage_location-fill.svg"),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 26,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Posted on',
                      //         style: TextStyle(
                      //           color: Colors.black.withOpacity(0.699999988079071),
                      //           fontSize: 16,
                      //           fontFamily: 'DM Sans',
                      //           fontWeight: FontWeight.w300,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15.0),
                      //   child: Row(
                      //     children: [
                      //       for (int i = 0; i < 4; i++)
                      //         Padding(
                      //           padding: const EdgeInsets.only(right: 10),
                      //           child: Container(
                      //             width: 74.73,
                      //             height: 32,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0x19398BCB),
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(3)),
                      //             ),
                      //             child: const Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   'Anytime',
                      //                   style: TextStyle(
                      //                     color: Color(0xFF398BCB),
                      //                     fontSize: 14,
                      //                     fontFamily: 'DM Sans',
                      //                     fontWeight: FontWeight.w300,
                      //                     height: 0,
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      // Spacer(),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF30469A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<HomeCubit>().getFilterList(
                                      categoryId: "",
                                        maxPrice: maxPriceController.text,
                                        minPrice: minPriceController.text,
                                        roomType: roomTypeId.toString(),
                                        city: cityID.toString(),
                                        possession: possession,
                                        maxArea: selectedMaxValue.toString(),
                                        purpose: widget.isRent ? "2" : "1",
                                        type: typeId(widget.typeOfProperty),
                                        minArea: selectedMinValue.toString(),
                                        possessionStatus:
                                            possessionId.toString()).then((value){
                                              Navigator.of(context).pop();
                                    });
                                  },
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
                ),
        );
      },
    );
  }

  String typeId(String typeOfProperty) {
    if (typeOfProperty == "Residential") {
      return "1";
    } else if (typeOfProperty == "Commercial") {
      return "2";
    } else if (typeOfProperty == "Agricultural") {
      return "3";
    } else {
      return "4";
    }
  }
}
