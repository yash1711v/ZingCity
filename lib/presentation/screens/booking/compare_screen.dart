import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/booking/booking_model.dart';
import '../../../data/model/product/details_property_item.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/booking/booking_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import '../property_details/property_details_screen.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late BookingCubit bookingCubit;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    bookingCubit = context.read<BookingCubit>();
    Future.microtask(() => bookingCubit.getCompareList());
    // bookingCubit.loading(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(title: 'Compare Property'),
      body: PageRefresh(
        onRefresh: () async {
          bookingCubit.getCompareList();
        },
        child: BlocListener<LoginBloc, LoginModelState>(
          listener: (context, state) {
            final logout = state.state;
            if (logout is LoginStateLogOutLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (logout is LoginStateSignOutError) {
                Utils.errorSnackBar(context, logout.errorMsg);
              } else if (logout is LoginStateLogOut) {
                Utils.showSnackBar(context, logout.msg);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.loginScreen, (route) => false);
              }
            }
          },
          child: BlocConsumer<BookingCubit, BookingModel>(
            listener: (context, service) {
              final state = service.bookState;
              if (state is MyBookError) {
                if (state.statusCode == 503) {
                  bookingCubit.getCompareList();
                }
                if (state.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, service) {
              final state = service.bookState;
              if (state is CompareLoading) {
                return const LoadingWidget();
              } else if (state is CompareError) {
                if (state.statusCode == 503) {
                  return LoadedCompareWidget(
                      compareList: bookingCubit.compareList);
                } else {
                  // return FetchErrorText(text: state.message);
                }
              } else if (state is CompareLoaded) {
                return LoadedCompareWidget(compareList: state.compareList);
              }
              if (bookingCubit.compareList.isNotEmpty) {
                return LoadedCompareWidget(
                    compareList: bookingCubit.compareList);
              } else {
                return FetchErrorText(
                    text:
                        Utils.translatedText(context, 'Something went wrong!'));
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoadedCompareWidget extends StatelessWidget {
  const LoadedCompareWidget({super.key, required this.compareList});

  final List<DetailsPropertyItem> compareList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: compareList.isEmpty
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        if (compareList.isEmpty) ...[
          const Center(
            child: EmptyWidget(
              icon: KImages.emptyBookingImage,
              title: 'No item found!',
            ),
          ),
        ] else ...[
          Container(
            width: double.infinity,
            margin: Utils.symmetric(h: 10.0, v: 20.0),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: borderRadius,
            ),
            child: Column(
              children: [
                tableContent(
                  context,
                  'Title',
                  (index) => compareList[index].title.toString(),
                  isTitleClickable: true,
                ),
                tableContent(
                    context,
                    'Price',
                    (index) =>
                        Utils.formatPrice(context, compareList[index].price)),
                tableContent(context, 'Total Unit',
                    (index) => compareList[index].totalUnit.toString()),
                tableContent(context, 'Bedroom',
                    (index) => compareList[index].totalBedroom.toString()),
                tableContent(context, 'Bathroom',
                    (index) => compareList[index].totalBathroom.toString()),
                tableContent(context, 'Garage',
                    (index) => compareList[index].totalGarage.toString()),
                tableContent(context, 'Area(m2)',
                    (index) => compareList[index].totalArea),
                tableContent(context, 'Kitchen',
                    (index) => compareList[index].totalKitchen.toString()),
                tableContent(context, 'Action',
                    (index) => compareList[index].totalKitchen.toString(),
                    isAction: true),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget tableContent(
      BuildContext context, String label, String Function(int) valueGetter,
      {bool isAction = false, bool isTitleClickable = false}) {
    return Column(
      children: [
        Padding(
          padding: Utils.symmetric(h: 10.0, v: 12.0),
          child: Row(
            children: [
              SizedBox(
                width: Utils.mediaQuery(context).width * 0.25,
                child: CustomTextStyle(
                  text: label,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0,
                ),
              ),
              for (int i = 0; i < compareList.length; i++)
                Expanded(
                  child: isAction
                      ? BlocListener<BookingCubit, BookingModel>(
                          listener: (context, book) {
                            final state = book.bookState;
                            if (state is CompareRemoving) {
                              Utils.loadingDialog(context);
                            } else {
                              Utils.closeDialog(context);
                              if (state is CompareError) {
                                if (state.statusCode == 403) {
                                  Navigator.of(context).pop();
                                }
                                Utils.errorSnackBar(context, state.message);
                              } else if (state is CompareAddRemoved) {
                                context
                                    .read<BookingCubit>()
                                    .addSingComId(compareList[i].id);
                                context.read<BookingCubit>().getCompareList();
                                Utils.showSnackBar(context, state.message);
                              }
                            }
                          },
                          child: GestureDetector(
                            onTap: () async {
                              String id = compareList[i].id.toString();
                              debugPrint('remove-id $id');
                              context
                                  .read<BookingCubit>()
                                  .compareAddOrRemove(id, false);
                            },
                            child: const Icon(
                              Icons.clear,
                              color: redColor,
                              size: 26.0,
                            ),
                          ),
                        )
                      : Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: Utils.only(right: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => PropertyDetailScreen(
                              //         slug: compareList[i].slug)));
                               Navigator.pushNamed(context, RouteNames.propertyDetailsScreen,arguments: compareList[i].slug);
                            },
                            child: CustomTextStyle(
                              text: valueGetter(i),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              maxLine: 2,
                            ),
                          ),
                        ),
                      ),
                ),

            ],
          ),
        ),
        Container(
          height: 1.0,
          width: double.infinity,
          color: borderColor,
        ),
      ],
    );
  }
}
