import 'package:real_estate/logic/cubit/add_property/add_property_state_model.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/agency/agency_details_model.dart';
import '../../../state_inject_package_names.dart';
import '../../router/route_names.dart';
import '../../widget/customnetwork_widget.dart';
import '../home/home_screen.dart';

class EnquiryScreen extends StatefulWidget {
 final List<dynamic> properties;
 final bool isRequest;
  const EnquiryScreen({super.key, required this.properties, required this.isRequest});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // context.read<AddPropertyCubit>().getProperties();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {

        // final update = widget.addState;
        // if (update is ProfileUpdateLoading) {
        //   log(_className, name: update.toString());
        // } else if (update is ProfileUpdateError) {
        //   Utils.errorSnackBar(context, update.message);
        // } else if (update is ProfileUpdateLoaded) {
        //   Navigator.of(context).pop();
        //   //Utils.showSnackBar(context, update.message);
        // }


        // if (update is AddPropertyLoaded) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     Navigator.of(context).pop();
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //     SnackBar(content: Text(update.message)));
        //   });
        //
        //   // return CircularProgressIndicator();
        // }
        //
        // if (update is AddPropertyLoading) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     Utils.loadingDialog(context);
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //     SnackBar(content: Text(update.message)));
        //   });
        //
        //   // return CircularProgressIndicator();
        // } else {
        //   Utils.closeDialog(context);
        //   if (update is AddPropertyError) {
        //
        //     if (update.statusCode == 401) {
        //       Utils.logout(context);
        //     } else {
        //
        //       debugPrint("This is the Error ${update.message}");
        //       WidgetsBinding.instance.addPostFrameCallback((_) {
        //         ScaffoldMessenger.of(context).clearSnackBars();
        //         ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(content: Text(update.message)));
        //       });
        //
        //       // Utils.errorSnackBar(context, update.message);
        //     }
        //
        //   } else if (update is AddPropertyLoaded) {
        //     // Navigator.of(context).pop();
        //     ScaffoldMessenger.of(context).clearSnackBars();
        //     WidgetsBinding.instance.addPostFrameCallback((_) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(content: Text(update.message)));
        //     });
        //
        //   }
        // }


        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size(
              360,
              120,
            ),
            child: Container(
                width: 360,
                height: 200,
                decoration: const BoxDecoration(
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
                      const EdgeInsets.only(top: 10.0, left: 16, right: 16),
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
                      height: 35,
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
                        child:  Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                            ),
                            Text(
                              widget.isRequest?'Enquiries Requests':'Your Enquiries',
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
          body: ListView.builder(
              // physics:
              // const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14),
              // shrinkWrap: true,
              itemCount: widget.properties.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.only(top: 10.0,),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,
                          RouteNames.purchaseDetailsScreen,
                          arguments: [widget.isRequest?widget.properties[index]:widget.properties[index].property,true]);
                      // Navigator.pushNamed(context,
                      //     RouteNames.purchaseDetailsScreen,
                      //     arguments: widget.isRequest?widget.properties[index]:widget.properties[index].property);
                      // Navigator.pushNamed(
                      //     context, RouteNames.purchaseDetailsScreen,arguments: index.toString());
                    },
                    child: Container(
                      // width: 324,
                      // height: 68,
                      decoration: ShapeDecoration(
                        color: const Color(0x0C398BCB),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 15.0,vertical: 15),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [

                            Visibility(
                              visible: widget.isRequest,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      RemoteUrls.rootUrl +
                                          (widget.isRequest?widget.properties[index].thumbnailImage:""),
                                      // width: 50,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                              visible: widget.isRequest,
                              child: const SizedBox(
                                height: 15,
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  widget.isRequest?"${ widget.properties[index].title}":"Name: ${ widget.properties[index].name}",
                                  style: const TextStyle(
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
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                              children: [
                                Visibility(
                                  visible: widget.isRequest,
                                  child: const Icon(
                                    Icons
                                        .location_on_sharp,
                                    size: 12,
                                  ),
                                ),
                                Visibility(
                                  visible: widget.isRequest,
                                  child: SizedBox(
                                    width: 5,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.isRequest?"${removeHtmlTags( widget.properties[index].address)}":"Email: ${removeHtmlTags( widget.properties[index].email)}",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color:
                                      Colors.black,
                                      fontSize: 14,
                                      fontFamily:
                                      'DM Sans',
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      height: 0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: !widget.isRequest,
                              child: const SizedBox(
                                height: 5,
                              ),
                            ),
                            Visibility(
                              visible: !widget.isRequest,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      !widget.isRequest?"Message: ${widget.properties[index].message}":"",
                                      // maxLines: 1,
                                      style: const TextStyle(
                                        color:
                                        Colors.black,
                                        fontSize: 14,
                                        fontFamily:
                                        'DM Sans',
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        height: 0,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: widget.isRequest,
                              child: const SizedBox(
                                height: 5,
                              ),
                            ),
                            Visibility(
                              visible: widget.isRequest,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.isRequest?"${widget.properties[index].description}":"",
                                      // maxLines: 1,
                                      style: const TextStyle(
                                        color:
                                        Colors.black,
                                        fontSize: 14,
                                        fontFamily:
                                        'DM Sans',
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        height: 0,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}