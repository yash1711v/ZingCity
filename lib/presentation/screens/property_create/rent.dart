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



  List<room.Category> categories = [];
  Set<room.Category> subCategoriesResidential = {};
  Set<room.Category> subCategoriesCommercial = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
      debugPrint("element ==> ${element.id}");
    });
    context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
      context.read<AddPropertyCubit>().state.staticInfo?.purpose?.rent?.forEach((rent) {

        if(rent.categoryId == category.id){
          categories.add(category);
        }

        if(rent.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
          context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
        }
      });
    });


    context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
      // debugPrint("key ==> $key");

      categories.forEach((categories){
        if(element.purpose!.contains(2)){

          if(element.parentId.toString() == "1" ){

            subCategoriesResidential.add(element);

          }
          else {
            // debugPrint("Commercial ==> ${element.name}");
            subCategoriesCommercial.add(element);
            // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
          }
        }

      });



         });

    _discriptionController.text = removeHtmlTags(context.read<AddPropertyCubit>().state.description);
    _title.text = context.read<AddPropertyCubit>().state.title;
    _priceController.text = context.read<AddPropertyCubit>().state.price;
    _areaController.text = context.read<AddPropertyCubit>().state.totalArea;
    _securityAmount.text = context.read<AddPropertyCubit>().state.totalUnit;
  }

 TextEditingController _discriptionController = TextEditingController();
 TextEditingController _title = TextEditingController();
 TextEditingController _areaController = TextEditingController();
 TextEditingController _priceController = TextEditingController();
 TextEditingController _securityAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
  builder: (context, state) {
  // debugPrint("state==> ${state.typeId}");
  // debugPrint("state==> ${categories[1].name}");

  debugPrint("subCategoriesResidential==> $subCategoriesResidential");
  debugPrint("subCategoriesCommercial==> $subCategoriesCommercial");
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
            states: categories ,
            selectedState:
            //"Punjab",
            state.typeId.isNotEmpty?state.typeId:null,
            onChanged: (value) {

                for (var element in categories) {
                  if(element.name == value){
                    context.read<AddPropertyCubit>().changeTypeId(element.name ?? "",(element.id ?? "").toString());
                    context.read<AddPropertyCubit>().changePropertyTypeId("","");
                  }
                }

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
              Expanded(
                // width: 339,
                child: Text(
                  'Property Type',
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
          child: CustomDropdown(
            title: 'Select Property Type',
            states: state.typeId == "Residential"?subCategoriesResidential.toList():subCategoriesCommercial.toList(),
            selectedState:
            //"Punjab",
            (state.propertyType ?? "").isNotEmpty?state.propertyType:null,
            onChanged: (value) {

              for (var element in (state.typeId == "Residential"?subCategoriesResidential.toList():subCategoriesCommercial.toList())) {
                if(element.name == value){
                  context.read<AddPropertyCubit>().changePropertyTypeId(element.name ?? "",(element.id ?? "").toString());
                }
              }

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
              Expanded(
                // width: 339,
                child: Text(
                  'Property Name',
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
            controller: _title,
            // TextEditingController(text: state.title),
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
                Expanded(
                  // width: 339,
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
                context.read<AddPropertyCubit>().changeRoomType(value ?? "",state.staticInfo?.roomType?.firstWhere((element) => element.name == value).id.toString() ?? "");
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
              Expanded(
                // width: 339,
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
            states: [room.RoomType(name: "Daily",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() ),room.RoomType(name: "Monthly",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() ),room.RoomType(name: "Yearly",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() )],
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
              Expanded(
                // width: 339,
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
            controller: _discriptionController,


            // TextEditingController(text: ),
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
              Expanded(
                // width: 339,
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
            controller: _priceController,

            // TextEditingController(text: state.price),
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
              Expanded(
                // width: 339,
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
            controller: _areaController,
            // TextEditingController(text: state.totalArea),
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
              Expanded(
                // width: 339,
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
            controller: _securityAmount,
            // TextEditingController(text: state.totalUnit),
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




class SellScreenOne extends StatefulWidget {
  const SellScreenOne({super.key});

  @override
  State<SellScreenOne> createState() => _SellScreenOneState();
}

class _SellScreenOneState extends State<SellScreenOne> {
  int tag = 0;



  List<room.Category> categories = [];
  Set<room.Category> subCategoriesResidential = {};
  Set<room.Category> subCategoriesCommercial = {};
  Set<room.Category> subCategoriesPlotLand = {};
  Set<room.Category> subCategoriesAgricultural = {};
  Set<room.Category> agricultural = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    context.read<AddPropertyCubit>().state.staticInfo?.roomType?.forEach((element) {
      debugPrint("element ==> ${element.id}");
    });


    context.read<AddPropertyCubit>().state.staticInfo?.categories?.forEach((category) {
      context.read<AddPropertyCubit>().state.staticInfo?.purpose?.sell?.forEach((sell) {

        if(sell.categoryId == category.id){
          categories.add(category);
          debugPrint("category ==> ${category.name}");

          if(sell.categoryId.toString() == context.read<AddPropertyCubit>().state.categoryId && context.read<AddPropertyCubit>().state.categoryId.isNotEmpty){
            context.read<AddPropertyCubit>().changeTypeId(category.name ?? "",(category.id ?? "").toString());
          }
        }

      });
    });


    context.read<AddPropertyCubit>().state.staticInfo?.subcategories!.forEach((key,element) {
      // debugPrint("key ==> $key");

      categories.forEach((categories){
        if(element.purpose!.contains(1)){

          if(element.parentId.toString() == "1" ){

            subCategoriesResidential.add(element);

          }
           if(element.parentId.toString() == "2"){
            // debugPrint("Commercial ==> ${element.name}");
            subCategoriesCommercial.add(element);
            // debugPrint("Else commercial ==> ${subCategoriesCommercial}");
          }
           if (element.parentId.toString() == "3"){
            subCategoriesAgricultural.add(element);
            debugPrint("Agricultural ==> ${element.name}");
            debugPrint("Agricultural ==> ${element.name}");
          }
           if (element.parentId.toString() == "4"){
            subCategoriesPlotLand.add(element);
          }
        }

      });



    });

    _discriptionController.text = removeHtmlTags(context.read<AddPropertyCubit>().state.description);
    _title.text = context.read<AddPropertyCubit>().state.title;
    _priceController.text = context.read<AddPropertyCubit>().state.price;
    _areaController.text = context.read<AddPropertyCubit>().state.totalArea;
    _securityAmount.text = context.read<AddPropertyCubit>().state.totalUnit;
  }

  TextEditingController _discriptionController = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _securityAmount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        // debugPrint("state==> ${state.typeId}");
        // debugPrint("state==> ${categories[1].name}");

        debugPrint("subCategoriesResidential==> $subCategoriesResidential");
        debugPrint("subCategoriesCommercial==> $subCategoriesCommercial");
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
                states: categories ,
                selectedState:
                //"Punjab",
                state.typeId.isNotEmpty?state.typeId:null,
                onChanged: (value) {

                  for (var element in categories) {
                    if(element.name == value){
                      context.read<AddPropertyCubit>().changeTypeId(element.name ?? "",(element.id ?? "").toString());
                      context.read<AddPropertyCubit>().changePropertyTypeId("","");
                    }
                  }

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
          Visibility(
            visible: state.typeId != "Agriculture Land",
              child: const SizedBox(
                height: 35,
              ),
            ),
            Visibility(
            visible: state.typeId == "Agriculture Land",
              child: const SizedBox(
                height: 10,
              ),
            ),
            Visibility(
              visible: state.typeId != "Agriculture Land",
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      // width: 339,
                      child: Text(
                        'Property Type',
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
              visible: state.typeId != "Agriculture Land",
              child: const SizedBox(
                height: 15,
              ),
            ),

            Visibility(
              visible: state.typeId != "Agriculture Land",
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomDropdown(
                  title: 'Select Property Type',
                  states: state.typeId == "Residential"?subCategoriesResidential.toList():state.typeId == "Commercial Space"?subCategoriesCommercial.toList():state.typeId == "Agriculture Land"?subCategoriesAgricultural.toList():subCategoriesPlotLand.toList(),
                  selectedState:
                  //"Punjab",
                  (state.propertyType ?? "").isNotEmpty?state.propertyType:null,
                  onChanged: (value) {

                    for (var element in (state.typeId == "Residential"?subCategoriesResidential.toList():state.typeId == "Commercial Space"?subCategoriesCommercial.toList():state.typeId == "Agriculture Land"?subCategoriesAgricultural.toList():subCategoriesPlotLand.toList())) {
                      if(element.name == value){
                        context.read<AddPropertyCubit>().changePropertyTypeId(element.name ?? "",(element.id ?? "").toString());
                      }
                    }

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
                  Expanded(
                    // width: 339,
                    child: Text(
                      'Property Name',
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
                controller: _title,
                // TextEditingController(text: state.title),
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
                    Expanded(
                      // width: 339,
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
                    context.read<AddPropertyCubit>().changeRoomType(value ?? "",state.staticInfo?.roomType?.firstWhere((element) => element.name == value).id.toString() ?? "");
                    // if(value != "Punjab"){
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text("Currently we are only available for Punjab state"),));
                    // } else {
                    //   context.read<AddPropertyCubit>().changeState(value ?? "");}
                  },
                ),
              ),
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            //
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         width: 339,
            //         child: Text(
            //           'Select Rent Period',
            //           style: TextStyle(
            //             color: Color(0xFF4D5454),
            //             fontSize: 14,
            //             fontFamily: 'Manrope',
            //             fontWeight: FontWeight.w400,
            //             height: 0.10,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: CustomDropdown(
            //     title: 'Select Rent Period',
            //     states: [room.RoomType(name: "Daily",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() ),room.RoomType(name: "Monthly",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() ),room.RoomType(name: "Yearly",id:0, createdAt: DateTime.now(), updatedAt: DateTime.now() )],
            //     selectedState:
            //     //"Punjab",
            //     state.rentPeriod.isNotEmpty?state.rentPeriod:null,
            //     onChanged: (value) {
            //       // debugPrint("value==> $value");
            //       context.read<AddPropertyCubit>().changeRentPeriod(value ?? "");
            //       // if(value != "Punjab"){
            //       //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //       //     content: Text("Currently we are only available for Punjab state"),));
            //       // } else {
            //       //   context.read<AddPropertyCubit>().changeState(value ?? "");}
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    // width: 339,
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
                controller: _discriptionController,


                // TextEditingController(text: ),
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
                  Expanded(
                    // width: 339,
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _priceController,

                // TextEditingController(text: state.price),
                keyboardType: TextInputType.number,
                onChanged: (value){
                  context.read<AddPropertyCubit>().changeTotalPrice(value ?? "");
                },
                maxLines: 1,
                decoration: const InputDecoration(
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
                  Expanded(
                    // width: 339,
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
                controller: _areaController,
                // TextEditingController(text: state.totalArea),
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
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    // width: 339,
                    child: Text(
                      'Total ${state.typeId == "Agriculture Land"?"ACRE/ KANAL //MARLA":state.typeId == "Plot/Land"?"MARLA":"Unit"}',
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
                controller: _securityAmount,
                // TextEditingController(text: state.totalUnit),
                keyboardType: TextInputType.number,
                onChanged: (value){
                  context.read<AddPropertyCubit>().changeTotalUnit(value ?? "");
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  fillColor: Color(0xFFF5F5F5),
                  hintText: 'Enter Unit',
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

