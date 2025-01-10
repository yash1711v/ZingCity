import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/booking/booking_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/booking/booking_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import '../home/component/single_property_card_view.dart';
import 'component/booking_component.dart';



class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  late BookingCubit bookingCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    bookingCubit = context.read<BookingCubit>();
    Future.microtask(() => bookingCubit.getBookings());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (bookingCubit.state.initialPage > 1) {
      bookingCubit.initPage();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (bookingCubit.state.isListEmpty == false) {
          bookingCubit.getBookings();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Booking',
      ),
      body: PageRefresh(
        onRefresh: () async {
          if (bookingCubit.state.initialPage > 1) {
            bookingCubit.initPage();
          }
          bookingCubit.getBookings();
        },
        child: BlocListener<LoginBloc, LoginModelState>(
          listener: (context, state)  {

          },
          // {
          //   final logout = state.state;
          //   if (logout is LoginStateLogOutLoading) {
          //     Utils.loadingDialog(context);
          //   } else {
          //     Utils.closeDialog(context);
          //     if (logout is LoginStateSignOutError) {
          //       Utils.errorSnackBar(context, logout.errorMsg);
          //     } else if (logout is LoginStateLogOut) {
          //       Utils.showSnackBar(context, logout.msg);
          //       Navigator.pushNamedAndRemoveUntil(
          //         context,
          //         RouteNames.loginScreen,
          //             (route) => false,
          //       );
          //     }
          //   }
          // },
          child: BlocConsumer<BookingCubit, BookingModel>(
            listener: (context, service) {
              final state = service.bookState;
              if (state is MyBookError) {
                if (state.statusCode == 503) {
                  bookingCubit.getBookings();
                }
                if (state.statusCode == 401) {
                  Utils.logout(context);
                }
              }

              if (state is MyBookLoading &&
                  bookingCubit.state.initialPage != 1) {
                Utils.loadingDialog(context);
              } else if (state is MyBookMoreLoaded) {
                Utils.closeDialog(context);
              }
            },
            builder: (context, service) {
              final state = service.bookState;
              if (state is MyBookLoading &&
                  bookingCubit.state.initialPage == 1) {
                return const LoadingWidget();
              } else if (state is MyBookError) {
                if (state.statusCode == 503) {
                  return LoadedMyBookingWidget(
                      myBookings: bookingCubit.myBookings,
                      controller: _scrollController);
                } else {
                  return FetchErrorText(text: state.message);
                }
              } else if (state is MyBookLoaded) {
                return LoadedMyBookingWidget(
                    myBookings: state.myBookings, controller: _scrollController);
              } else if (state is MyBookMoreLoaded) {
                return LoadedMyBookingWidget(
                    myBookings: state.myBookings, controller: _scrollController);
              }

              if (bookingCubit.myBookings.isNotEmpty) {
                return LoadedMyBookingWidget(
                    myBookings: bookingCubit.myBookings,
                    controller: _scrollController);
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

class LoadedMyBookingWidget extends StatelessWidget {
  const LoadedMyBookingWidget(
      {super.key, required this.myBookings, required this.controller});

  final List<BookingModel> myBookings;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        // CustomSliverAppBar(
        //     title: Utils.translatedText(context, 'Purchase History')),
        if (myBookings.isNotEmpty) ...[
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = myBookings[index];
                return BookingComponent(property: item);
              }, childCount: myBookings.length),
            ),
          )
        ] else ...[
          EmptyWidget(
              isSliver: true,
              icon: KImages.emptyBookingImage,
              title: Utils.translatedText(context, 'No Booking found!'))
        ]
      ],
    );
  }
}
