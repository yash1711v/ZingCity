import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/data/model/add_property_model.dart' as addProperty;
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';
import 'package:real_estate/presentation/screens/property_create/add_screen2.dart';

import '../../../state_inject_package_names.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> titles = [

  ];
  List<String> images = [

  ];

  TextEditingController _bedrooms = TextEditingController();
  TextEditingController _bathrooms = TextEditingController();
  TextEditingController _balconies = TextEditingController();
  TextEditingController _kitchens = TextEditingController();
  TextEditingController _carParking = TextEditingController();
  TextEditingController _Floors = TextEditingController();
  TextEditingController _FrontRoad = TextEditingController();

  List<TextEditingController> controllers = [];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bedrooms.text = context.read<AddPropertyCubit>().state.totalBedroom;
    _bathrooms.text = context.read<AddPropertyCubit>().state.totalBathroom;
    _balconies.text = context.read<AddPropertyCubit>().state.totalBalcony;
    _kitchens.text = context.read<AddPropertyCubit>().state.totalKitchen;
    _carParking.text = context.read<AddPropertyCubit>().state.totalGarage;


    if( context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Residential"){
      titles = [
        'No. of Bedrooms',
        'No. of Bathrooms',
        'No. of Balconies',
        'No. of Kitchens',
        'No. of Car Parking',
      ];

      images = [
        'assets/Yash/images/BedRoom.svg',
        'assets/Yash/images/Bathroom.svg',
        'assets/Yash/images/banglowIcon.svg',
        // 'No. of Balconies',
        'assets/Yash/images/kitchen.svg',
        'assets/Yash/images/Garage.svg',
      ];
      controllers = [
        _bedrooms,
        _bathrooms,
        _balconies,
        _kitchens,
        _carParking,
      ];
    }
    if( context.read<AddPropertyCubit>().state.purpose == "rent" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space"){
      titles = [
        'No. of WashRooms',
        'No. of Pantry',
        // 'No. of Kitchens',
        'No. of Car Parking',
      ];

      images = [
        'assets/Yash/images/BedRoom.svg',
        'assets/Yash/images/Bathroom.svg',
        // 'assets/Yash/images/kitchen.svg',
        'assets/Yash/images/Garage.svg',
      ];

      controllers = [
        _bedrooms,
        _bathrooms,
        _balconies,
        _kitchens,
        _carParking,
      ];
    }

    if( context.read<AddPropertyCubit>().state.purpose == "buy" && context.read<AddPropertyCubit>().state.typeId == "Residential"){
      titles = [
        'No. of Bedrooms',
        'No. of Bathrooms',
        'No. of Balconies',
        'No. of Kitchens',
        'No. of Garage/Parking',
        'No. of FLOOR/STORIES',
      ];

      images = [
        'assets/Yash/images/BedRoom.svg',
        'assets/Yash/images/Bathroom.svg',
        'assets/Yash/images/banglowIcon.svg',
        // 'No. of Balconies',
        'assets/Yash/images/kitchen.svg',
        'assets/Yash/images/Garage.svg',
        'assets/Yash/images/Garage.svg',
      ];

      controllers = [
        _bedrooms,
        _bathrooms,
        _balconies,
        _kitchens,
        _carParking,
        _Floors,
      ];

    }

    if( context.read<AddPropertyCubit>().state.purpose == "buy" && context.read<AddPropertyCubit>().state.typeId == "Commercial Space"){

      titles = [
        'No. of Floor',
        'No. of WashRooms',
        'No. of Pantry',
        'No. of FLOOR/STORIES',
        'No. of FRONT ROAD( FEET)',
      ];

      images = [
        'assets/Yash/images/BedRoom.svg',
        'assets/Yash/images/Bathroom.svg',
        // 'assets/Yash/images/kitchen.svg',
        'assets/Yash/images/Garage.svg',
        'assets/Yash/images/Garage.svg',
        'assets/Yash/images/Garage.svg',
      ];


      controllers = [
        _bedrooms,
        _bathrooms,
        _balconies,
        _kitchens,
        _carParking,
        _Floors,
        _FrontRoad,
      ];

    }


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
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 297,
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
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: index == 0
                                  ? controllers[0]
                                  : index == 1
                                      ? controllers[1]
                                      : index == 2
                                          ? controllers[2]
                                          : index == 3
                                              ? controllers[3]
                                              : index == 4? controllers[4] : controllers[5],
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

                                if (index == 3) {
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
              ],
            ),
          ),
        );
      },
    );
  }
}
