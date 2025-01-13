import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../router/route_packages_name.dart';

class Screenfour extends StatefulWidget {
  const Screenfour({super.key});

  @override
  State<Screenfour> createState() => _ScreenfourState();
}

class _ScreenfourState extends State<Screenfour> {
  final int totalElements = 27;
  final int elementsPerPage = 9; // 3x3 grid per page
  late final int totalPages;
  int currentPage = 0;
  PageController pageController = PageController();
  final Set<int> selectedItems = {}; // Track selected item indices

  @override
  void initState() {
    super.initState();
    totalPages = (totalElements / elementsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
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
                      'Select Places',
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
                width: double.infinity,
                height: 400,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: pageController,
                  itemCount: totalPages,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    final start = pageIndex * elementsPerPage;
                    final end = (start + elementsPerPage) > totalElements
                        ? totalElements
                        : start + elementsPerPage;
                    final pageItems =
                        List.generate(end - start, (i) => start + i);

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: pageItems.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedItems.contains(index);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedItems.remove(index);
                              } else {
                                selectedItems.add(index);
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
                                side: const BorderSide(width: 1.50, color: Color(0x80EEEEEE)),
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
                                  color: isSelected ? Colors.white : const Color(0xFF30469A),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 76,
                                  child: Text(
                                    'Gas Station',
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
                    );
                  },
                ),
              ),
            ),
            // Page indicator
            SmoothPageIndicator(
                controller: pageController,
                count: totalPages,
                effect: const ExpandingDotsEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Color(0xFF30469A),
                  spacing: 4,
                )),
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
                     'Add values',
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0,left: 16,right: 16),
                child: SizedBox(
                  width: 339,
                  height: 48,
                  child: Row(
                    children: [
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
                          child: SvgPicture.asset("assets/Yash/images/Garage.svg",
                            width: 24,
                            height: 24,
                            color: const Color(0xFF30469A),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const SizedBox(
                        width: 132,
                        child: Text(
                          'Supermarket',
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 16,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.09,
                          ),
                        ),
                      ),
                     Spacer(),
                      SizedBox(
                        width: 77,
                        height: 25,
                        child: TextField(
                         maxLength: 3,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            fillColor: Colors.transparent,
                            hintText: '0000',
                            hintStyle: TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          icon: Container(),
                          iconSize: 24,
                          itemHeight: 55,
                          dropdownColor: Color(0xFFF5F5F5),
                          decoration: const InputDecoration(
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 16,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w600,
                            height: 0.09,
                          ),
                          value: "Km",
                          items: const [
                            DropdownMenuItem(
                              value: "Km",
                              child: Text("Km"),
                            ),
                            DropdownMenuItem(
                              value: "M",
                              child: Text("M"),
                            ),

                          ],
                          onChanged: (value) {
                            // Handle value change here, for example:
                            // setState(() => selectedCategory = value as String);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

          ],
        ),
      ),
    );
  }
}
