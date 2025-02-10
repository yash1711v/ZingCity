import 'dart:developer';

import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/agency/agency_details_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_names.dart';
import '../../utils/utils.dart';
import '../../widget/customnetwork_widget.dart';
import '../home/home_screen.dart';
import '../property_create/add_property_screen.dart';

class MyProperty extends StatefulWidget {
  const MyProperty({super.key});

  @override
  State<MyProperty> createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AddPropertyCubit>().getProperties();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
  builder: (context, state) {

    final update = state.addState;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(
          360,
          100,
        ),
        child: Container(
            width: 360,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFE7EBF4),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 8,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25.0, left: 16, right: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/Yash/images/ZingCityLogo.png",
                        width: 50.03,
                        height: 35.01,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // if (pageController.page == 0) {
                      //   Navigator.pop(context);
                      // } else {
                      //   pageController.previousPage(
                      //       duration: const Duration(milliseconds: 300),
                      //       curve: Curves.easeIn);
                      // }
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                        ),
                        Text(
                          'Your Properties',
                          style: TextStyle(
                            color: Color(0xFF30469A),
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            state.properties!.length>0?ListView.builder(
                physics:
                const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14),
                shrinkWrap: true,
                itemCount: state.properties?.length,
                itemBuilder: (context, index) {
                  String PropertyType = "";

                  context
                      .read<AddPropertyCubit>()
                      .state
                      .staticInfo
                      ?.subcategories!
                      .forEach((key, element) {
                    // debugPrint("key ==> $key");

                    if (element.id.toString() ==
                        (state.properties ?? [])[index]
                            .propertyTypeId.toString()) {
                      PropertyType = element.name ?? "";
                    }
                  });


                  log("approveByAdmin: ${state.properties?[index].approveByAdmin?.toString()}");
                  return Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0,),
                    child: GestureDetector(
                      onTap: (){


                        state.properties?[index].propertyLocation?.forEach((element) {
                          print(element.location);
                        });
                        Navigator.pushNamed(context,
                            RouteNames.purchaseDetailsScreen,
                            arguments: [state.properties?[index],true]);
                        // Navigator.pushNamed(
                        //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                      },
                      child: Container(
                        // width: 324,
                        // height: 68,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            bottom: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0x0C398BCB),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                        ),
                        child:  ListTile(
                          leading: CustomNetworkImageWidget(
                            width: 78.93,
                            height: 78.93,
                            image:
                            "${RemoteUrls.rootUrl}${state.properties?[index].thumbnailImage}",
                          ),
                          title: Text(
                            state.properties?[index].title ?? "",
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color:
                              Colors.black,
                              fontSize: 14,
                              fontFamily:
                              'DM Sans',
                              fontWeight:
                              FontWeight
                                  .w700,
                              height: 0,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          const Icon(
                                            Icons
                                                .location_on_sharp,
                                            size: 12,
                                          ),
                                          Expanded(
                                            // width: 150,
                                            child: Text(
                                              removeHtmlTags( state.properties?[index].address ?? ""),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color:
                                                Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                'DM Sans',
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                height: 0,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          // const Icon(
                                          //   Icons
                                          //       .location_on_sharp,
                                          //   size: 12,
                                          // ),
                                          Expanded(
                                            // width: 150,
                                            child: Text(
                                              PropertyType,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color:
                                                Colors.black,
                                                fontSize: 14,
                                                fontFamily:
                                                'DM Sans',
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                height: 0,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                        Text("Status: "),
                                          Expanded(
                                            // width: 150,
                                            child: Text(
                                              (state.properties ??
                                              []
                                              )[index].approveByAdmin.toString()[0].toUpperCase() + (state.properties ??
                                              []
                                              )[index].approveByAdmin.toString().substring(1),
                                              maxLines: 1,
                                              style:  TextStyle(
                                                color:
                                                (state.properties ??
                                                    []
                                                )[index].approveByAdmin == "approved" ?Colors.green : Colors.orange,
                                                // fontSize: 12,
                                                fontFamily:
                                                'DM Sans',
                                                fontWeight:
                                                FontWeight
                                                    .w300,
                                                height: 0,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: state.properties?[index].approveByAdmin == "pending",
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) =>  AddPropertyScreen(property: state.properties?[index],)));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF30469A),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {


                                  Repository repo = Repository();

                                  repo.deleteMyProperty((state.properties?[index].id ?? "").toString()).then((value){
                                    if(value){
                                      context.read<AddPropertyCubit>().getProperties();
                                    }
                                  });

                                  // Navigator.pushNamed(
                                  //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Color(0xFF30469A),
                                ),
                              ),

                            ],
                        )
                      ),
                    ),
                  ));
                }):SizedBox(
              height: MediaQuery.of(context).size.height-450,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text("No Property Found",style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPropertyScreen()));
                      }, child: Text("Add Property",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),))
                    ],
                  ),
                ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
