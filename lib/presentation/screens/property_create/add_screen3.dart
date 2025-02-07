import 'package:flutter/services.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

import '../../../state_inject_package_names.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> titles = [];
  List<String> images = [];

  TextEditingController _bedrooms = TextEditingController();
  TextEditingController _bathrooms = TextEditingController();
  // TextEditingController _balconies = TextEditingController();
  TextEditingController _kitchens = TextEditingController();
  TextEditingController _carParking = TextEditingController();

  // TextEditingController _Floors = TextEditingController();
  // TextEditingController _FrontRoad = TextEditingController();

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bedrooms.text = context.read<AddPropertyCubit>().state.totalBedroom;
    _bathrooms.text = context.read<AddPropertyCubit>().state.totalBathroom;
    // _balconies.text = context.read<AddPropertyCubit>().state.totalBalcony;
    _kitchens.text = context.read<AddPropertyCubit>().state.totalKitchen;
    _carParking.text = context.read<AddPropertyCubit>().state.totalGarage;

    context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
      if(context.read<AddPropertyCubit>().state.roomTypeId == element.id.toString()){
        _bedrooms.text = element.name.toString().replaceAll("BHK", "").replaceAll("& MORE", "");
        // _bedrooms.text = element.name.toString().replaceAll("& MORE", "");
        context.read<AddPropertyCubit>().changeTotalBedroom(element.name.toString());
      }
    });
    titles = [
      "No. of Bedrooms",
      "No. of Bathrooms",
      // "No. of Balconies",
      "No. of Kitchens",
      "No. of Car Parking",
      // "No. of Floors",
      // "Front Road Width"
    ];

    // images = [
    //   "assets/icons/bedroom.svg",
    //   "assets/icons/bathroom.svg",
    //   "assets/icons/balcony.svg",
    //   "assets/icons/kitchen.svg",
    //   "assets/icons/car_parking.svg",
    //   // "assets/icons/floors.svg",
    //   // "assets/icons/front_road.svg"
    // ];

    controllers = [
      _bedrooms,
      _bathrooms,
      // _balconies,
      _kitchens,
      _carParking,
      // _Floors,
      // _FrontRoad
    ];
  }

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
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                // Container(
                                //   width: 32,
                                //   height: 32,
                                //   decoration: ShapeDecoration(
                                //     color: const Color(0x19087C7C),
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(8)),
                                //   ),
                                //   child: Center(
                                //     child: SvgPicture.asset(images[index]),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                Expanded(
                                  child: Text(
                                    titles[index],
                                    style: const TextStyle(
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
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(

                              readOnly:  index == 0 && (context.read<AddPropertyCubit>().state.roomTypeId ?? "").isNotEmpty && int.parse(_bedrooms.text) != 6,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                              ],
                              keyboardType: TextInputType.number,
                              controller: index == 0
                                  ? controllers[0]
                                  : index == 1
                                      ? controllers[1]
                                      : index == 2
                                          ? controllers[2]
                                          : controllers[3],
                      // index == 3
                      //                         ? controllers[3]
                                              // : controllers[4],
                              onChanged: (value) {
                                if (index == 0) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalBedroom(value);
                                }

                                if (index == 1) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalBathroom(value);
                                }

                                if (index == 2) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalBalconies(value);
                                }

                                if (index == 3) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalKitchen(value);
                                }

                                if (index == 4) {
                                  context
                                      .read<AddPropertyCubit>()
                                      .changeTotalGarage(value);
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: const Color(0xFFF5F5F5),
                                hintText:
                                    'Enter ${titles[index].replaceAll("No. of ", "")}',
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
                //   const SizedBox(
                //     height: 10,
                //   ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           "FURNISHED/UNFURNISHED",
                //           style: TextStyle(
                //             color: Color(0xFF4D5454),
                //             fontSize: 16,
                //             fontFamily: 'Manrope',
                //             fontWeight: FontWeight.w400,
                //             height: 0.09,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //
                //   const SizedBox(
                //     height: 15,
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: CustomDropdown(
                //       isRoomType: true,
                //       title: "Select Value",
                //       states: [
                //         addProperty.RoomType(id: 0, name: "Yes"),
                //         addProperty.RoomType(id: 1, name: "NO")
                //       ],
                //       selectedState: (state.furnished ?? "").isEmpty?null:state.furnished,
                //       onChanged: (value) {
                //         context.read<AddPropertyCubit>().changeFurnished(value);
                //       },
                //     ),
                //   ),
                //   Visibility(
                //     visible: context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space",
                //     child: const SizedBox(
                //       height: 20,
                //     ),
                //   ),
                //   Visibility(
                //     visible: context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space",
                //   child: const Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Text(
                //             "Elevator",
                //             style: TextStyle(
                //               color: Color(0xFF4D5454),
                //               fontSize: 16,
                //               fontFamily: 'Manrope',
                //               fontWeight: FontWeight.w400,
                //               height: 0.09,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //   Visibility(
                //     visible: context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space",
                //     child: const SizedBox(
                //       height: 15,
                //     ),
                //   ),
                //   Visibility(
                //     visible: context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space",
                //      child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //       child: CustomDropdown(
                //         isRoomType: true,
                //         title: "Select Value",
                //         states: [
                //           addProperty.RoomType(id: 0, name: "Yes"),
                //           addProperty.RoomType(id: 1, name: "NO")
                //         ],
                //         selectedState: (state.elevator ?? "").isEmpty?null:state.elevator,
                //         onChanged: (value) {
                //           context.read<AddPropertyCubit>().changeElevator(value);
                //         },
                //       ),
                //                      ),
                //    ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AdditionalInfoWidget(),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AdditionalInfoWidget extends StatefulWidget {
  @override
  _AdditionalInfoWidgetState createState() => _AdditionalInfoWidgetState();
}

class _AdditionalInfoWidgetState extends State<AdditionalInfoWidget> {
  List<TextEditingController> keyControllers = [];
  List<TextEditingController> valueControllers = [];
  List<String> keys = [];
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    if((context.read<AddPropertyCubit>().state.additionalKeys ?? []).isNotEmpty && (context.read<AddPropertyCubit>().state.additionalValues ?? []).isNotEmpty){
      alreadyAdded();
    } else {
    _addNewField(); // Start with one field

    }

  }

  void _addNewField() {
      setState(() {
        keyControllers.add(TextEditingController());
        valueControllers.add(TextEditingController());
        keys.add("");
        values.add("");
      });
  }

  void alreadyAdded(){
    if((context.read<AddPropertyCubit>().state.additionalKeys ?? []).isNotEmpty && (context.read<AddPropertyCubit>().state.additionalValues ?? []).isNotEmpty){
      for (var i = 0; i < (context.read<AddPropertyCubit>().state.additionalKeys ?? []).length; i++) {
        keyControllers.add(TextEditingController(text: (context.read<AddPropertyCubit>().state.additionalKeys ?? [])[i]));
        valueControllers.add(TextEditingController(text: (context.read<AddPropertyCubit>().state.additionalValues ?? [])[i]));
        keys.add((context.read<AddPropertyCubit>().state.additionalKeys ?? [])[i]);
        values.add((context.read<AddPropertyCubit>().state.additionalValues ?? [])[i]);
      }
    }
  }

  void _removeField(int index) {
    setState(() {
      keyControllers[index].dispose();
      valueControllers[index].dispose();
      keyControllers.removeAt(index);
      valueControllers.removeAt(index);
    });
  }

  void _extractText() {
    keys = keyControllers.map((controller) => controller.text).toList();
    values = valueControllers.map((controller) => controller.text).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          children: List.generate(keyControllers.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                      // ],
                      onChanged: (value) {
                        setState(() {
                          keys[index] = value;
                        });

                        context.read<AddPropertyCubit>().addAdditionalKey(keys);

                      },
                      controller: keyControllers[index],
                      decoration: InputDecoration(labelText: "Key"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: (value) {
                        setState(() {
                          values[index] = value;
                        });
                        context.read<AddPropertyCubit>().addAdditionalValue(values);
                      },
                      controller: valueControllers[index],
                      decoration: InputDecoration(labelText: "Value"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => _removeField(index),
                  ),
                ],
              ),
            );
          }),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _addNewField,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Add More",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 10),
        // ElevatedButton(
        //   onPressed: () {
        //     _extractText();
        //     print("Keys: \$keys");
        //     print("Values: \$values");
        //   },
        //   child: Text("Extract Data"),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in keyControllers) {
      controller.dispose();
    }
    for (var controller in valueControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
