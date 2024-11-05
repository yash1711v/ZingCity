import 'package:chips_choice/chips_choice.dart';

import '../../../state_inject_package_names.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int tag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
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
                  },
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: ["Sell", "Rent"],
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  choiceStyle: const C2ChipStyle(
                    padding: EdgeInsets.symmetric(horizontal: 30), // Chip width
                    height: 40, // Chip height
                  ),
                ),
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
                    'Select Catogery',
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
              child: DropdownButtonFormField<String>(
                dropdownColor: Color(0xFFF5F5F5),
                decoration: const InputDecoration(
                  fillColor: Color(0xFFF5F5F5),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Color(0xFF4D5454),
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                ),
                value: "Residential",
                hint: const Text("Select Category"),
                items: const [
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
                ],
                onChanged: (value) {
                  // Handle value change here, for example:
                  // setState(() => selectedCategory = value as String);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,       // 3 items per row
                crossAxisSpacing: 8.0,    // Horizontal spacing between items
                mainAxisSpacing: 8.0,     // Vertical spacing between items
                childAspectRatio: 1.0,    // Aspect ratio to keep items square
              ),
              itemCount: 9, // Number of items in the grid
              itemBuilder: (context, index) {
                return Container(
                  decoration: ShapeDecoration(
                    color: const Color(0x0C398BCB),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1.50, color: Color(0x80EEEEEE)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ImageIcon(
                          AssetImage('assets/images/iconamoon_profile-light.png'),
                          size: 50,
                          color: Color(0xFF123FED),
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                        width: 76,
                        child: Text(
                          'Townhouse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF4D5454),
                            fontSize: 12,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              padding: const EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }
}
