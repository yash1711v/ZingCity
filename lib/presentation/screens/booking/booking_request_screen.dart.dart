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
import 'component/booking_component.dart';



class BookingReqScreen extends StatefulWidget {
  const BookingReqScreen({super.key});

  @override
  State<BookingReqScreen> createState() => _BookingReqScreenState();
}

class _BookingReqScreenState extends State<BookingReqScreen> {
  late BookingCubit bookingCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    bookingCubit = context.read<BookingCubit>();
    Future.microtask(() => bookingCubit.bookingReq());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (bookingCubit.state.initialPage2 > 1) {
      bookingCubit.initPage(false);
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (bookingCubit.state.isListEmpty2 == false) {
          bookingCubit.bookingReq();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking List',
      ),
      body: PageRefresh(
        onRefresh: () async {
          if (bookingCubit.state.initialPage2 > 1) {
            bookingCubit.initPage(false);
          }
          bookingCubit.bookingReq();
        },
        child: BlocListener<LoginBloc, LoginModelState>(
          listener: (context, state){},
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
              if (state is BookingReqError) {
                if (state.statusCode == 503) {
                  bookingCubit.bookingReq();
                }
                if (state.statusCode == 401) {
                  Utils.logout(context);
                }
              }

              if (state is BookingReqLoading &&
                  bookingCubit.state.initialPage2 != 1) {
                Utils.loadingDialog(context);
              } else if (state is BookingReqMoreLoaded) {
                Utils.closeDialog(context);
              }
            },
            builder: (context, service) {
              final state = service.bookState;
              if (state is BookingReqLoading &&
                  bookingCubit.state.initialPage2 == 1) {
                return const LoadingWidget();
              } else if (state is BookingReqError) {
                if (state.statusCode == 503) {
                  return LoadedBookingReqWidget(
                      bookingList: bookingCubit.bookingList,
                      controller: _scrollController);
                } else {
                  return FetchErrorText(text: state.message);
                }
              } else if (state is BookingReqLoaded) {
                return LoadedBookingReqWidget(
                    bookingList: state.bookingList, controller: _scrollController);
              } else if (state is BookingReqMoreLoaded) {
                return LoadedBookingReqWidget(
                    bookingList: state.bookingList, controller: _scrollController);
              }

              if (bookingCubit.bookingList.isNotEmpty) {
                return LoadedBookingReqWidget(
                    bookingList: bookingCubit.bookingList,
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

class LoadedBookingReqWidget extends StatelessWidget {
  const LoadedBookingReqWidget(
      {super.key, required this.bookingList, required this.controller});

  final List<BookingModel> bookingList;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        // CustomSliverAppBar(
        //     title: Utils.translatedText(context, 'Purchase History')),
        if (bookingList.isNotEmpty) ...[
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = bookingList[index];
                return BookingComponent(property: item);
              }, childCount: bookingList.length),
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
