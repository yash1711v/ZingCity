import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_cubit.dart';
import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../state_inject_package_names.dart';
import '../../router/route_packages_name.dart';

class Screenfour extends StatefulWidget {
  const Screenfour({super.key});

  @override
  State<Screenfour> createState() => _ScreenfourState();
}

class _ScreenfourState extends State<Screenfour> {
  int totalElements = 27;
  final int elementsPerPage = 9; // 3x3 grid per page
  late final int totalPages;
  int currentPage = 0;
  PageController pageController = PageController();
  final Set<int> selectedItems = {}; // Track selected item indices

  @override
  void initState() {
    super.initState();
    totalElements =
        (context.read<AddPropertyCubit>().state.staticInfo?.amenities ?? [])
            .length;
    totalPages = (totalElements / elementsPerPage).ceil();
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
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Select Amenities',
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
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                      // width: double.infinity,
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = selectedItems.contains(index);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedItems.remove(index);
                                  context.read<AddPropertyCubit>().changeAmenities(
                                      state.staticInfo?.amenities[index].id ?? 0,false);
                                } else {
                                  selectedItems.add(index);
                                  context.read<AddPropertyCubit>().changeAmenities(
                                      state.staticInfo?.amenities[index].id ?? 0,true);
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: isSelected
                                    ? const Color(0xFF30469A)
                                    : const Color(0x0C398BCB),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1.50, color: Color(0x80EEEEEE)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/Yash/images/Garage.svg",
                                    width: 50,
                                    height: 50,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF30469A),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 76,
                                    child: Text(
                                      (context
                                                  .read<AddPropertyCubit>()
                                                  .state
                                                  .staticInfo
                                                  ?.amenities ??
                                              [])[index]
                                          .name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF30469A),
                                        fontSize: 12,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w400,
                                        height: 0.12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: totalElements,
                      )

                      // PageView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   controller: pageController,
                      //   itemCount: totalPages,
                      //   onPageChanged: (index) {
                      //     setState(() {
                      //       currentPage = index;
                      //     });
                      //   },
                      //   itemBuilder: (context, pageIndex) {
                      //     final start = pageIndex * elementsPerPage;
                      //     final end = (start + elementsPerPage) > totalElements
                      //         ? totalElements
                      //         : start + elementsPerPage;
                      //     final pageItems =
                      //         List.generate(end - start, (i) => start + i);
                      //
                      //     return GridView.builder(
                      //       gridDelegate:
                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                      //         crossAxisCount: 3, // 3 columns
                      //         mainAxisSpacing: 5.0,
                      //         crossAxisSpacing: 5.0,
                      //         childAspectRatio: 1.1,
                      //       ),
                      //       itemCount: pageItems.length,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       itemBuilder: (context, index) {
                      //         bool isSelected = selectedItems.contains(index);
                      //
                      //         return GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               if (isSelected) {
                      //                 selectedItems.remove(index);
                      //               } else {
                      //                 selectedItems.add(index);
                      //               }
                      //             });
                      //           },
                      //           child: Container(
                      //             alignment: Alignment.center,
                      //             decoration: ShapeDecoration(
                      //               color: isSelected
                      //                   ? const Color(0xFF30469A)
                      //                   : const Color(0x0C398BCB),
                      //               shape: RoundedRectangleBorder(
                      //                 side: const BorderSide(width: 1.50, color: Color(0x80EEEEEE)),
                      //                 borderRadius: BorderRadius.circular(10),
                      //               ),
                      //             ),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment: CrossAxisAlignment.center,
                      //               children: [
                      //                 SvgPicture.asset(
                      //                   "assets/Yash/images/Garage.svg",
                      //                   width: 50,
                      //                   height: 50,
                      //                   color: isSelected ? Colors.white : const Color(0xFF30469A),
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 76,
                      //                   child: Text(
                      //                     (context.read<AddPropertyCubit>().state.staticInfo?.amenities ?? [])[pageItems[index]].name,
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                       color: isSelected
                      //                           ? Colors.white
                      //                           : const Color(0xFF30469A),
                      //                       fontSize: 12,
                      //                       fontFamily: 'Manrope',
                      //                       fontWeight: FontWeight.w400,
                      //                       height: 0.12,
                      //                     ),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                      ),
                ),
                // Page indicator
                // SmoothPageIndicator(
                //     controller: pageController,
                //     count: totalPages,
                //     effect: const ExpandingDotsEffect(
                //       dotWidth: 8,
                //       dotHeight: 8,
                //       activeDotColor: Color(0xFF30469A),
                //       spacing: 4,
                //     )),
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 339,
                        child: Text(
                          'Nearest Places',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ListViewWithCheckbox(nearestLocations: state.staticInfo?.nearestLocation ?? []),
                // ListView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: (state.staticInfo?.nearestLocation ?? []).length,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(
                //             bottom: 8.0, left: 16, right: 16),
                //         child: SizedBox(
                //           width: 339,
                //           height: 48,
                //           child: Row(
                //             children: [
                //               Container(
                //                 width: 48,
                //                 height: 48,
                //                 decoration: ShapeDecoration(
                //                   color: const Color(0x19087C7C),
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(10),
                //                   ),
                //                 ),
                //                 child: Center(
                //                   child: SvgPicture.asset(
                //                     "assets/Yash/images/Garage.svg",
                //                     width: 24,
                //                     height: 24,
                //                     color: const Color(0xFF30469A),
                //                   ),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 width: 16,
                //               ),
                //                SizedBox(
                //                 width: 132,
                //                 child: Text(
                //                   (state.staticInfo?.nearestLocation ?? []).elementAt(index).name,
                //                   style: const TextStyle(
                //                     color: Color(0xFF4D5454),
                //                     fontSize: 16,
                //                     fontFamily: 'Manrope',
                //                     fontWeight: FontWeight.w400,
                //                     height: 0.09,
                //                   ),
                //                 ),
                //               ),
                //               const Spacer(),
                //               const SizedBox(
                //                 width: 77,
                //                 height: 25,
                //                 child: TextField(
                //                   maxLength: 3,
                //                   decoration: InputDecoration(
                //                     counterText: "",
                //                     contentPadding: EdgeInsets.symmetric(
                //                         horizontal: 5, vertical: 10),
                //                     fillColor: Colors.transparent,
                //                     hintText: '0000',
                //                     hintStyle: TextStyle(
                //                       color: Color(0xFF595959),
                //                       fontSize: 16,
                //                       fontFamily: 'Manrope',
                //                       fontWeight: FontWeight.w400,
                //                       height: 0.09,
                //                     ),
                //                     border: InputBorder.none,
                //                     enabledBorder: InputBorder.none,
                //                     focusedBorder: InputBorder.none,
                //                     errorBorder: InputBorder.none,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 70,
                //                 height: 50,
                //                 child: DropdownButtonFormField<String>(
                //                   icon: Container(),
                //                   iconSize: 24,
                //                   itemHeight: 55,
                //                   dropdownColor: const Color(0xFFF5F5F5),
                //                   decoration: const InputDecoration(
                //                     fillColor: Colors.transparent,
                //                     border: InputBorder.none,
                //                     enabledBorder: InputBorder.none,
                //                     focusedBorder: InputBorder.none,
                //                     errorBorder: InputBorder.none,
                //                   ),
                //                   style: const TextStyle(
                //                     color: Color(0xFF4D5454),
                //                     fontSize: 16,
                //                     fontFamily: 'Manrope',
                //                     fontWeight: FontWeight.w600,
                //                     height: 0.09,
                //                   ),
                //                   value: "Km",
                //                   items: const [
                //                     DropdownMenuItem(
                //                       value: "Km",
                //                       child: Text("Km"),
                //                     ),
                //                     DropdownMenuItem(
                //                       value: "M",
                //                       child: Text("M"),
                //                     ),
                //                   ],
                //                   onChanged: (value) {
                //                     // Handle value change here, for example:
                //                     // setState(() => selectedCategory = value as String);
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     }),
              ],
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ListViewWithCheckbox extends StatefulWidget {
  final List<dynamic> nearestLocations;

  const ListViewWithCheckbox({super.key, required this.nearestLocations});

  @override
  _ListViewWithCheckboxState createState() => _ListViewWithCheckboxState();
}

class _ListViewWithCheckboxState extends State<ListViewWithCheckbox> {
  final List<bool> checkBoxStates = [];
  final List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    checkBoxStates.addAll(List.generate(widget.nearestLocations.length, (_) => false));
  }

  void toggleCheckbox(int index, bool? value) {
    setState(() {
      checkBoxStates[index] = value ?? false;

      if (checkBoxStates[index]) {
        // Add item to data if checkbox is checked and not already present
        if (!data.any((element) =>
        element["id"].toString() ==
            widget.nearestLocations[index].id.toString())) {
          data.add({
            "id": widget.nearestLocations[index].id.toString(),
            "value": "0", // Default value for the text field
          });
        }
      } else {
        // Remove item from data if checkbox is unchecked
        data.removeWhere((element) =>
        element["id"].toString() ==
            widget.nearestLocations[index].id.toString());
      }

      debugPrint("Data: $data");

      context.read<AddPropertyCubit>().changeNearestLocation(data);
    });
  }

  void updateTextFieldValue(int index, String value) {
    setState(() {
      for (var element in data) {
        if (element["id"].toString() ==
            widget.nearestLocations[index].id.toString()) {
          element["value"] = value.trim();
          break;
        }
      }

      debugPrint("Updated Data: $data");
      context.read<AddPropertyCubit>().changeNearestLocation(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.nearestLocations.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 339,
            height: 48,
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: checkBoxStates[index],
                  onChanged: (bool? value) {
                    toggleCheckbox(index, value);
                  },
                ),
                // Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0x19087C7C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/Yash/images/Garage.svg",
                      width: 24,
                      height: 24,
                      color: const Color(0xFF30469A),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Location Name
                Expanded(
                  child: Text(
                    widget.nearestLocations[index].name,
                    style: const TextStyle(
                      color: Color(0xFF4D5454),
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                    ),
                  ),
                ),
                // TextField (enabled/disabled based on checkbox state)
                AbsorbPointer(
                  absorbing: !checkBoxStates[index], // Block interaction when unchecked
                  child: SizedBox(
                    width: 77,
                    height: 25,
                    child: TextField(
                      onChanged: (value) => updateTextFieldValue(index, value),
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        filled: false,
                        hintText: '0000',
                        hintStyle: const TextStyle(
                          color: Color(0xFF595959),
                          fontSize: 16,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          height: 0.09,
                        ),
                        border: InputBorder.none, // Removes the border
                        enabledBorder: InputBorder.none, // Removes the border when enabled
                        focusedBorder: InputBorder.none, // Removes the border when focused
                      ),
                    ),
                  ),
                ),
                const Text("Km"),
                const SizedBox(width: 35),
              ],
            ),
          ),
        );
      },
    );
  }
}



