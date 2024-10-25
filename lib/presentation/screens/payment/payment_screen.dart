import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/widget/page_refresh.dart';

import '/data/data_provider/remote_url.dart';
import '/data/model/payment/payment_model.dart';
import '/logic/bloc/login/login_bloc.dart';
import '/presentation/router/route_names.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_rounded_app_bar.dart';
import '../../../logic/cubit/payment/payment/payment_cubit.dart';
import '../../utils/utils.dart';
import '../../widget/fetch_text_error.dart';
import '../../widget/loading_widget.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key, required this.planSlug});

  final String planSlug;

  @override
  Widget build(BuildContext context) {
    final paymentCubit = context.read<PaymentCubit>();
    paymentCubit.getPaymentPageInformation(planSlug);
    return Scaffold(
      appBar: const CustomRoundedAppBar(text: 'Payment Method'),
      body: PageRefresh(
        onRefresh: () async => paymentCubit.getPaymentPageInformation(planSlug),
        child: Utils.logoutListener(
          child: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentStatePageInfoError) {
                if (state.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, state) {
              if (state is PaymentStatePageInfoLoading) {
                return const LoadingWidget();
              } else if (state is PaymentStatePageInfoError) {
                if (state.statusCode == 503) {
                  return LoadedPaymentWidget(payment: paymentCubit.payment!);
                } else {
                  return FetchErrorText(text: state.message);
                }
              }
              if (paymentCubit.payment != null) {
                return LoadedPaymentWidget(payment: paymentCubit.payment!);
              } else {
                return const FetchErrorText(text: 'Something went wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoadedPaymentWidget extends StatelessWidget {
  const LoadedPaymentWidget({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    final token = context.read<LoginBloc>().userInfo!.accessToken;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithPaypal(
                    token, payment.pricePlan!.planSlug);
                print('remoteUrl $url');
                Navigator.pushNamed(context, RouteNames.paypalPaymentScreen,
                    arguments: url);
              },
              icon: payment.payPal!.image),
          SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithRazorpay(
                    token, payment.pricePlan!.planSlug);
                Navigator.pushNamed(context, RouteNames.razorpayPaymentScreen,
                    arguments: url);
              },
              icon: payment.razorPay!.image),
          SinglePaymentCard(
              onTap: () {
                String url = RemoteUrls.payWithPayStack(
                    token, payment.pricePlan!.planSlug);
                Navigator.pushNamed(context, RouteNames.payStackPaymentScreen,
                    arguments: url);
              },
              icon: payment.paystack!.paystackImage),
          SinglePaymentCard(
              onTap: () {
                final url =
                    RemoteUrls.payWithMolli(token, payment.pricePlan!.planSlug);
                print('remoteUrl $url');
                Navigator.pushNamed(context, RouteNames.molliPaymentScreen,
                    arguments: url);
              },
              icon: payment.molliPayStack!.mollieImage),
          SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithInstamojo(
                    token, payment.pricePlan!.planSlug);
                Navigator.pushNamed(context, RouteNames.instamojoPaymentScreen,
                    arguments: url);
              },
              icon: payment.instamojo!.image),
          SinglePaymentCard(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.stripePaymentScreen,
                    arguments: payment.pricePlan!.planSlug);
              },
              icon: payment.stripe!.image),
          SizedBox(
              height: 80.0,
              width: double.infinity,
              child: SinglePaymentCard(
                  onTap: () {
                    String url = RemoteUrls.payWithFlutterWave(
                        token, payment.pricePlan!.planSlug);
                    Navigator.pushNamed(
                        context, RouteNames.flutterWavePaymentScreen,
                        arguments: url);
                  },
                  icon: payment.flutterWave!.logo)),
          //SinglePaymentCard(onTap: () {}, icon: payment.flutterWave!.logo),
          SinglePaymentCard(
              onTap: () => Navigator.pushNamed(
                  context, RouteNames.bankPaymentScreen,
                  arguments: payment.pricePlan!.planSlug),
              icon: payment.bankPayment!.image),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class SinglePaymentCard extends StatelessWidget {
  const SinglePaymentCard({super.key, required this.onTap, required this.icon});

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)
            .copyWith(bottom: 0.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: borderRadius,
        ),
        child: CustomImage(
          path: RemoteUrls.imageUrl(icon),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
