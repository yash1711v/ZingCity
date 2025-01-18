import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:real_estate/presentation/screens/property_create/ScreenFour.dart';

import '../../../logic/cubit/add_property/add_property_state_model.dart';
import '../../../state_inject_package_names.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_theme.dart';
import 'add_screen2.dart';
import 'add_screen3.dart';
import 'add_scren1.dart';
import 'image_adding_screen.dart';

class AddPropertyScreen extends StatefulWidget {
  final Properties? property;

  const AddPropertyScreen({
    super.key,
    this.property,
  });

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AddPropertyCubit>().getData();

    if ((widget.property ??
            Properties(
                id: 0,
                agentId: 0,
                propertyTypeId: 0,
                title: "",
                slug: "",
                purpose: "",
                rentPeriod: "",
                price: "",
                thumbnailImage: "",
                address: "",
                totalBedroom: "",
                totalBathroom: "",
                totalArea: "",
                status: "",
                isFeatured: "",
                totalRating: 5,
                ratingAvarage: "",
                agent: Agent(
                    id: 0,
                    name: "",
                    phone: "",
                    email: "",
                    designation: "",
                    image: "",
                    userName: "")))
        .title
        .isNotEmpty) {
      context.read<AddPropertyCubit>().editProperty(widget.property);
    }
  }

  int pageIndex = 0;
  List<Widget> dataScreens1 = const [
    ScreenOne(),
    AddScreen2(),
    Screen3(),
    ImageAddingScreen(),
    Screenfour(),
  ];
  List<Widget> dataScreens2 = const [
    ScreenOne(),
    AddScreen2(),
    // Screen3(),
    ImageAddingScreen(),
    Screenfour(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyModel>(
      builder: (context, state) {
        // debugPrint("category Type${state.type}");

        final update = state.addState;
        // if (update is ProfileUpdateLoading) {
        //   log(_className, name: update.toString());
        // } else if (update is ProfileUpdateError) {
        //   Utils.errorSnackBar(context, update.message);
        // } else if (update is ProfileUpdateLoaded) {
        //   Navigator.of(context).pop();
        //   //Utils.showSnackBar(context, update.message);
        // }

        if (update is AddPropertyLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.of(context).pop();
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(update.message)));
          });

          // return CircularProgressIndicator();
        }

        if (update is AddPropertyLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).clearSnackBars();
            Utils.loadingDialog(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(update.message)));
          });

          // return CircularProgressIndicator();
        } else {
          Utils.closeDialog(context);
          if (update is AddPropertyError) {
            if (update.statusCode == 401) {
              Utils.logout(context);
            } else {
              debugPrint("This is the Error ${update.message}");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(update.message)));
              });

              // Utils.errorSnackBar(context, update.message);
            }
          } else if (update is AddPropertyLoaded) {
            // Navigator.of(context).pop();
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(update.message)));
            });
          }
        }

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
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          if (pageController.page == 0) {
                            Navigator.pop(context);
                            // context.read<AddPropertyCubit>().resetData();
                          } else {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                            ),
                            Text(
                              'Add Property',
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
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: state.typeId == "Residential" ||
                    state.typeId == "Commercial Space"
                ? dataScreens1
                : dataScreens2,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {
                        if (state.typeId == "Residential" ||
                            state.typeId == "Commercial Space" ||
                            state.typeId.isEmpty) {
                          // debugPrint("pageIndex ${pageIndex}");
                          if (pageIndex == 0) {
                            if (state.purpose == "rent") {
                              if (state.typeId == "Residential") {
                                if (state.typeId.isEmpty ||
                                    state.title.isEmpty ||
                                    state.description.isEmpty ||
                                    state.price.isEmpty ||
                                    state.totalArea.isEmpty ||
                                    state.totalUnit.isEmpty ||
                                    state.rentPeriod.isEmpty ||
                                    state.roomType.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please fill all the fields")));
                                  return;
                                } else {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                  setState(() {
                                    pageIndex = pageController.page!.toInt();
                                  });
                                }
                              } else {
                                if (state.typeId.isEmpty ||
                                    state.title.isEmpty ||
                                    state.description.isEmpty ||
                                    state.price.isEmpty ||
                                    state.totalArea.isEmpty ||
                                    state.totalUnit.isEmpty ||
                                    state.rentPeriod.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please fill all the fields")));
                                  return;
                                } else {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                  setState(() {
                                    pageIndex = pageController.page!.toInt();
                                  });
                                }
                              }
                            } else {
                              if (state.typeId.isEmpty ||
                                  state.title.isEmpty ||
                                  state.description.isEmpty ||
                                  state.price.isEmpty ||
                                  state.totalArea.isEmpty ||
                                  state.totalUnit.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please fill all the fields")));
                                return;
                              } else {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                                setState(() {
                                  pageIndex = pageController.page!.toInt();
                                });
                              }
                            }
                          }

                          if (pageIndex == 1) {
                            if (state.city.isEmpty ||
                                state.state.isEmpty ||
                                state.country.isEmpty ||
                                state.address.isEmpty) {
                              debugPrint("This is Empty Field ${state.city}");
                              debugPrint("This is Empty Field ${state.state}");
                              debugPrint(
                                  "This is Empty Field ${state.country}");
                              debugPrint(
                                  "This is Empty Field ${state.address}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
// debugPrint("This is Empty Field ${state.city}");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }
                          if (pageIndex == 2) {
                            if (state.totalBedroom.isEmpty ||
                                state.totalBathroom.isEmpty ||
                                state.totalGarage.isEmpty ||
                                state.totalGarage.isEmpty) {
                              // debugPrint("This is Empty Field ${state.city}");
                              // debugPrint("This is Empty Field ${state.state}");
                              // debugPrint(
                              //     "This is Empty Field ${state.country}");
                              // debugPrint(
                              //     "This is Empty Field ${state.address}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
// debugPrint("This is Empty Field ${state.city}");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }

                          if (pageIndex == 3) {
                            if (state.thumbNailImage.isEmpty) {
                              // debugPrint("This is Empty Field ${state.city}");
                              // debugPrint("This is Empty Field ${state.state}");
                              // debugPrint(
                              //     "This is Empty Field ${state.country}");
                              // debugPrint(
                              //     "This is Empty Field ${state.address}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
// debugPrint("This is Empty Field ${state.city}");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }

                          if (pageIndex == 4) {
                            context.read<AddPropertyCubit>().addProperty();
//                             if (state.thumbNailImage.isEmpty ) {
//                               // debugPrint("This is Empty Field ${state.city}");
//                               // debugPrint("This is Empty Field ${state.state}");
//                               // debugPrint(
//                               //     "This is Empty Field ${state.country}");
//                               // debugPrint(
//                               //     "This is Empty Field ${state.address}");
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                       Text("Please fill all the fields")));
//                               return;
//                             } else {
// // debugPrint("This is Empty Field ${state.city}");
//                               pageController.nextPage(
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeIn);
//                               setState(() {
//                                 pageIndex = pageController.page!.toInt();
//                               });
//                             }
                          }
                        } else {
                          if (pageIndex == 0) {
                            if (state.typeId.isEmpty ||
                                state.title.isEmpty ||
                                state.description.isEmpty ||
                                state.price.isEmpty ||
                                state.totalArea.isEmpty ||
                                state.totalUnit.isEmpty) {
                              // debugPrint("This is Empty Field ${state.typeId}");
                              // debugPrint("This is Empty Field ${state.title}");
                              // debugPrint("This is Empty Field ${state.description}");
                              // debugPrint("This is Empty Field ${state.price}");
                              // debugPrint("This is Empty Field ${state.totalArea}");
                              // debugPrint("This is Empty Field ${state.totalUnit}");
                              // debugPrint("This is Empty Field ${state.roomType}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }

                          if (pageIndex == 1) {
                            if (state.city.isEmpty ||
                                state.state.isEmpty ||
                                state.country.isEmpty ||
                                state.address.isEmpty) {
                              debugPrint("This is Empty Field ${state.city}");
                              debugPrint("This is Empty Field ${state.state}");
                              debugPrint(
                                  "This is Empty Field ${state.country}");
                              debugPrint(
                                  "This is Empty Field ${state.address}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
// debugPrint("This is Empty Field ${state.city}");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }

                          if (pageIndex == 2) {
                            if (state.thumbNailImage.isEmpty) {
                              // debugPrint("This is Empty Field ${state.city}");
                              // debugPrint("This is Empty Field ${state.state}");
                              // debugPrint(
                              //     "This is Empty Field ${state.country}");
                              // debugPrint(
                              //     "This is Empty Field ${state.address}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please fill all the fields")));
                              return;
                            } else {
// debugPrint("This is Empty Field ${state.city}");
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              setState(() {
                                pageIndex = pageController.page!.toInt();
                              });
                            }
                          }

                          if (pageIndex == 3) {
                            context.read<AddPropertyCubit>().addProperty();
//                             if (state.thumbNailImage.isEmpty ) {
//                               // debugPrint("This is Empty Field ${state.city}");
//                               // debugPrint("This is Empty Field ${state.state}");
//                               // debugPrint(
//                               //     "This is Empty Field ${state.country}");
//                               // debugPrint(
//                               //     "This is Empty Field ${state.address}");
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content:
//                                       Text("Please fill all the fields")));
//                               return;
//                             } else {
// // debugPrint("This is Empty Field ${state.city}");
//                               pageController.nextPage(
//                                   duration: const Duration(milliseconds: 300),
//                                   curve: Curves.easeIn);
//                               setState(() {
//                                 pageIndex = pageController.page!.toInt();
//                               });
//                             }
                          }
                          // pageController.nextPage(
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeIn);
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      )),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
