

import 'package:chips_choice/chips_choice.dart';
import 'package:real_estate/presentation/screens/property_create/rent.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_packages_name.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {


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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        // setState(() => tag = state.purpose == "Sell"?0:1);
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
                        value: state.purpose == "buy"?0:1,
                        onChanged: (val) {
                          debugPrint('val: $val');
                          // setState(() => tag = val);
                          context.read<AddPropertyCubit>().changeType(val == 0?"buy":"rent");
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

                state.purpose == "buy"?const SellScreenOne(): const RentScreenOne(),

              ],
            ),
          ),
        );
      },
    );
  }
}



