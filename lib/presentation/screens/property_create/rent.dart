import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../state_inject_package_names.dart';
import '../home/home_screen.dart';
import 'add_screen2.dart';
import 'package:real_estate/data/model/add_property_model.dart' as room;
class RentScreenOne extends StatefulWidget {
  const RentScreenOne({super.key});

  @override
  State<RentScreenOne> createState() => _RentScreenOneState();
}

class _RentScreenOneState extends State<RentScreenOne> {
  int tag = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
  builder: (context, state) {
    return Column(
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
            states: state.staticInfo?.rent ?? [],
            selectedState:
            //"Punjab",
            state.typeId.isNotEmpty?state.typeId:null,
            onChanged: (value) {
              // debugPrint("value==> $value");

              // if(tag == 0){
              //   (state.staticInfo?.sale ?? []).forEach((element) {
              //     if(element.name == value){
              //       context.read<AddPropertyCubit>().changeTypeId(element.name,(element.id ?? "").toString());
              //     }
              //   });
              // } else {

                (state.staticInfo?.rent ?? []).forEach((element) {
                  if(element.name == value){
                    context.read<AddPropertyCubit>().changeTypeId(element.name,(element.id ?? "").toString());
                  }
                });

              // }

              // if(value != "Punjab"){
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text("Currently we are only available for Punjab state"),));
              // } else {
              //   context.read<AddPropertyCubit>().changeState(value ?? "");}
            },
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: TextEditingController(text: state.title),
            onChanged: (value){
              context.read<AddPropertyCubit>().changeTitle(value ?? "");
            },
            decoration: const InputDecoration(
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

        const SizedBox(
          height: 20,
        ),
        Padding(
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: TextEditingController(text: removeHtmlTags(state.description)),
            onChanged: (value){
              context.read<AddPropertyCubit>().changeDescription(value ?? "");
            },
            maxLines: 6,
            decoration: const InputDecoration(
              fillColor: Color(0xFFF5F5F5),
              hintText: 'Describe your property',
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
                  'Rent',
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: TextEditingController(text: state.price),
            keyboardType: TextInputType.number,
            onChanged: (value){
              context.read<AddPropertyCubit>().changeTotalPrice(value ?? "");
            },
            maxLines: 1,
            decoration: const InputDecoration(
              fillColor: Color(0xFFF5F5F5),
              hintText: 'Enter Rent',
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: TextEditingController(text: state.totalArea),
            keyboardType: TextInputType.number,
            onChanged: (value){
              context.read<AddPropertyCubit>().changeTotalArea(value ?? "");
            },
            maxLines: 1,
            decoration: const InputDecoration(
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
                'Security/Advance Amount',
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: TextEditingController(text: state.totalUnit),
            keyboardType: TextInputType.number,
            onChanged: (value){
              context.read<AddPropertyCubit>().changeTotalUnit(value ?? "");
            },
            maxLines: 1,
            decoration: const InputDecoration(
              fillColor: Color(0xFFF5F5F5),
              hintText: 'Security/Advance Amount',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  },
);
  }
}
