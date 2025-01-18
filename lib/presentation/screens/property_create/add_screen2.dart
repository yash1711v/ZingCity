import 'dart:developer';

import 'package:real_estate/logic/cubit/add_property/add_property_cubit.dart';

import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_packages_name.dart';

class AddScreen2 extends StatefulWidget {
  const AddScreen2({super.key});

  @override
  State<AddScreen2> createState() => _AddScreen2State();
}

class _AddScreen2State extends State<AddScreen2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        log("AddScreen2: ${state.state}", name: "States");
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 31,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 198,
                        child: Text(
                          'Address',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 15,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                          ),
                        ),
                      ),
                      // Spacer(),
                      // Text(
                      //   'Choose Location',
                      //   textAlign: TextAlign.right,
                      //   style: TextStyle(
                      //     color: Color(0xFF30469A),
                      //     fontSize: 14,
                      //     fontFamily: 'Manrope',
                      //     fontWeight: FontWeight.w400,
                      //     height: 0.10,
                      //   ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomDropdown(
                    title: 'Select City',
                    states: state.staticInfo?.city ?? [],
                    selectedState:
                        //"Punjab",
                        state.city.isNotEmpty ? state.city : null,
                    onChanged: (value) {
                      // debugPrint("value==> $value");
                      (state.staticInfo?.city ?? []).forEach((element) {
                        if (element.name == value) {
                          context
                              .read<AddPropertyCubit>()
                              .changeCity(element.name ?? "", element.id.toString());
                        }
                      });
                      // context.read<AddPropertyCubit>().changeCity(value ?? "");
                      // if(value != "Punjab"){
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //     content: Text("Currently we are only available for Punjab state"),));
                      // } else {
                      //   context.read<AddPropertyCubit>().changeState(value ?? "");
                      // }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomDropdown(
                    title: 'Select State',
                    states: state.staticInfo?.state ?? [],
                    selectedState: "Punjab",
                    //state.state.isNotEmpty?state.state:null,
                    onChanged: (value) {
                      // debugPrint("value==> $value");
                      if (value != "Punjab") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Currently we are only available for Punjab state"),
                        ));
                      } else {
                        (state.staticInfo?.state ?? []).forEach((element) {
                          if (element.name == value) {
                            context
                                .read<AddPropertyCubit>()
                                .changeState(element.name ?? "", element.id.toString());
                          }
                        });
                        // context
                        //     .read<AddPropertyCubit>()
                        //     .changeState(value ?? "");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    readOnly: true,
                    onChanged: (value) {
                      context
                          .read<AddPropertyCubit>()
                          .changeCountry(value ?? "");
                    },
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'India',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: TextEditingController(text: state.address),
                    onChanged: (value) {
                      context
                          .read<AddPropertyCubit>()
                          .changeAddress(value ?? "");
                    },
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      hintText: 'Address ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// (value) {
// context.read<AddPropertyCubit>().changeState(value ?? "");
// },

class CustomDropdown extends StatelessWidget {
  final String? title;
  final List<dynamic> states;
  final String? selectedState;
  final bool? isRoomType;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    Key? key,
    required this.states,
    this.selectedState,
    this.onChanged,
    this.title,
    this.isRoomType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedState,
        hint: Text(title ?? ""),
        items: states.map((state) {
          return DropdownMenuItem<String>(
            value: state.name,
            child: Text(
              state.name,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,

        underline: const SizedBox(),
        // Removes the default underline
        isExpanded: true,
      ),
    );
  }
}
