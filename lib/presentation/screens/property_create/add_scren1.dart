

import 'package:chips_choice/chips_choice.dart';
import 'package:real_estate/data/model/add_property_model.dart' as room;

import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_packages_name.dart';
import 'add_screen2.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int tag = 0;
  List<DropdownMenuItem<String>>? items1 = const [
    DropdownMenuItem(
      value: "Residential",
      child: Text("Residential"),
    ),
    DropdownMenuItem(
      value: "Commercial",
      child: Text("Commercial"),
    ),
    DropdownMenuItem(
      value: "Agricultural",
      child: Text("Agricultural"),
    ),
  ];
  List<DropdownMenuItem<String>>? items2 = const [
    DropdownMenuItem(
      value: "Residential",
      child: Text("Residential"),
    ),
    DropdownMenuItem(
      value: "Commercial",
      child: Text("Commercial"),
    ),
    DropdownMenuItem(
      value: "Agricultural",
      child: Text("Agricultural"),
    ),
    DropdownMenuItem(
      value: "Plot/Land",
      child: Text("Plot/Land"),
    ),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Type of Property',
                        style: TextStyle(
                          color: Color(0xFF4D5454),
                          fontSize: 16,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 0.09,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ChipsChoice<int>.single(
                        value: tag,
                        onChanged: (val) {
                          debugPrint('val: $val');
                          setState(() => tag = val);
                          context.read<AddPropertyCubit>().changeType(val == 0?"Sell":"Rent");
                          context.read<AddPropertyCubit>().changeTypeId("Residential","0");
                        },
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: ["Sell", "Rent"],
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        choiceStyle: C2ChipStyle.filled(
                          color: Colors.grey[300],
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          selectedStyle: const C2ChipStyle(
                            backgroundColor: Color(0xFF30469A),
                            borderWidth: 10,
                            backgroundOpacity: 1,
                          ),
                          height: 40,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select Category',
                        style: TextStyle(
                          color: Color(0xFF4D5454),
                          fontSize: 16,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 0.09,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomDropdown(
                    title: 'Select Category',
                    states: tag == 0?state.staticInfo?.sale ?? []:state.staticInfo?.rent ?? [],
                    selectedState:
                    //"Punjab",
                    state.typeId.isNotEmpty?state.typeId:null,
                    onChanged: (value) {
                      // debugPrint("value==> $value");

                      if(tag == 0){
                        (state.staticInfo?.sale ?? []).forEach((element) {
                          if(element.name == value){
                            context.read<AddPropertyCubit>().changeTypeId(element.name,(element.id ?? "").toString());
                          }
                        });
                      } else {
                        (state.staticInfo?.rent ?? []).forEach((element) {
                          if(element.name == value){
                            context.read<AddPropertyCubit>().changeTypeId(element.name,(element.id ?? "").toString());
                          }
                        });
                      }

                      // if(value != "Punjab"){
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text("Currently we are only available for Punjab state"),));
                      // } else {
                      //   context.read<AddPropertyCubit>().changeState(value ?? "");}
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Container(
                //     color: const Color(0xFFF5F5F5),
                //     child: DropdownButtonFormField<String>(
                //       dropdownColor: const Color(0xFFF5F5F5),
                //       decoration: const InputDecoration(
                //         fillColor: Colors.transparent,
                //         border: InputBorder.none,
                //         errorBorder: InputBorder.none,
                //         focusedBorder: InputBorder.none,
                //         enabledBorder: InputBorder.none,
                //       ),
                //       style: const TextStyle(
                //         color: Color(0xFF4D5454),
                //         fontSize: 16,
                //         fontFamily: 'Manrope',
                //         fontWeight: FontWeight.w600,
                //       ),
                //       value: "Residential",
                //       hint: const Text("Select Category"),
                //       items: tag == 0?items2:items1,
                //       onChanged: (value) {
                //         // Handle value change here, for example:
                //         // setState(() => selectedCategory = value as String);
                //         context.read<AddPropertyCubit>().changeTypeId(value ?? "");
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Property Details',
                        style: TextStyle(
                          color: Color(0xFF4D5454),
                          fontSize: 16,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 0.09,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Property name',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
               Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: (value){
                      context.read<AddPropertyCubit>().changeTitle(value ?? "");
                    },
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Enter property name',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Visibility(
                  visible: state.typeId == "Residential",
                  child: const SizedBox(
                    height: 20,
                  ),
                ),

                Visibility(
                  visible: state.typeId == "Residential",
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 339,
                          child: Text(
                            'Select Room Type',
                            style: TextStyle(
                              color: Color(0xFF4D5454),
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Visibility(
                  visible: state.typeId == "Residential",
                  child: const SizedBox(
                    height: 20,
                  ),
                ),

                Visibility(
                  visible: state.typeId == "Residential",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomDropdown(
                      title: 'Select Room Type',
                      states: state.staticInfo?.roomType ?? [],
                      selectedState:
                      //"Punjab",
                      state.roomType.isNotEmpty?state.roomType:null,
                      onChanged: (value) {
                        // debugPrint("value==> $value");
                        context.read<AddPropertyCubit>().changeRoomType(value ?? "");
                        // if(value != "Punjab"){
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text("Currently we are only available for Punjab state"),));
                        // } else {
                        //   context.read<AddPropertyCubit>().changeState(value ?? "");}
                      },
                    ),
                  ),
                ),

                Visibility(
                  visible:  state.purpose == "Rent",
                  child: const SizedBox(
                    height: 20,
                  ),
                ),

                Visibility(
                  visible:state.purpose == "Rent",
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 339,
                          child: Text(
                            'Select Rent Period',
                            style: TextStyle(
                              color: Color(0xFF4D5454),
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  visible:  state.purpose == "Rent",
                  child: const SizedBox(
                    height: 20,
                  ),
                ),
                Visibility(
                  visible: state.purpose == "Rent",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomDropdown(
                      title: 'Select Rent Period',
                      states: [room.RoomType(name: "Daily",id:0, createdAt: '', updatedAt: '' ),room.RoomType(name: "Monthly",id:0, createdAt: '', updatedAt: '' ),room.RoomType(name: "Yearly",id:0, createdAt: '', updatedAt: '' )],
                      selectedState:
                      //"Punjab",
                      state.rentPeriod.isNotEmpty?state.rentPeriod:null,
                      onChanged: (value) {
                        // debugPrint("value==> $value");
                        context.read<AddPropertyCubit>().changeRentPeriod(value ?? "");
                        // if(value != "Punjab"){
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text("Currently we are only available for Punjab state"),));
                        // } else {
                        //   context.read<AddPropertyCubit>().changeState(value ?? "");}
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    onChanged: (value){
                      context.read<AddPropertyCubit>().changeDescription(value ?? "");
                    },
                    maxLines: 6,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Discribe your property',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Price',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      context.read<AddPropertyCubit>().changeTotalPrice(value ?? "");
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Enter Price',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Total Area(sq. ft.)',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      context.read<AddPropertyCubit>().changeTotalArea(value ?? "");
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Enter Total Area(sq. ft.)',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Total Unit',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      context.read<AddPropertyCubit>().changeTotalUnit(value ?? "");
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Enter Total Unit',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 80,
                ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Type of Property',
                //         style: TextStyle(
                //           color: Color(0xFF4D5454),
                //           fontSize: 16,
                //           fontFamily: 'Manrope',
                //           fontWeight: FontWeight.w600,
                //           height: 0.09,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: GridView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,       // 3 items per row
                //       crossAxisSpacing: 8.0,    // Horizontal spacing between items
                //       mainAxisSpacing: 8.0,     // Vertical spacing between items
                //       childAspectRatio: 1.0,    // Aspect ratio to keep items square
                //     ),
                //     itemCount: 9, // Number of items in the grid
                //     itemBuilder: (context, index) {
                //       return Container(
                //         decoration: ShapeDecoration(
                //           color: const Color(0x0C398BCB),
                //           shape: RoundedRectangleBorder(
                //             side: const BorderSide(width: 1.50, color: Color(0x80EEEEEE)),
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //         child: const Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Center(
                //               child: ImageIcon(
                //                 AssetImage('assets/images/iconamoon_profile-light.png'),
                //                 size: 50,
                //                 color: Color(0xFF123FED),
                //               ),
                //             ),
                //             SizedBox(height: 15,),
                //             SizedBox(
                //               width: 76,
                //               child: Text(
                //                 'Townhouse',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Color(0xFF4D5454),
                //                   fontSize: 12,
                //                   fontFamily: 'Manrope',
                //                   fontWeight: FontWeight.w400,
                //                   height: 0.12,
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //     padding: const EdgeInsets.all(8.0),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
