import 'package:carousel_slider/carousel_slider.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/model/product/single_property_model.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../state_inject_package_names.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_images.dart';
import '../../../widget/custom_test_style.dart';
import '../../../widget/primary_button.dart';

class PropertyImagesSlider extends StatefulWidget {
  final SinglePropertyModel property;

  const PropertyImagesSlider({super.key, required this.property});

  @override
  State<PropertyImagesSlider> createState() => _PropertyImagesSliderState();
}

class _PropertyImagesSliderState extends State<PropertyImagesSlider> {
  final int initialPage = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final images = widget.property.sliders;
    final item = widget.property.propertyItemModel;
    return SizedBox(
      height: size.height * 0.38,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
              // bottomLeft: Radius.circular(30.0),
              // bottomRight: Radius.circular(30.0),
            ),
            child: CustomImage(
              path: KImages.profileBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.04,
            child: Row(
              children: [
                //const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    backgroundColor: whiteColor,
                    minRadius: 16.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: grayColor,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                const CustomTextStyle(
                  text: 'Property Details',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: whiteColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.03,
            right: size.width * 0.04,
            child: GestureDetector(
                onTap: () => _loanCalculator(context),
                // onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context)=>MortgageCalculatorApp())),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: whiteColor
                  ),
                  child: Padding(
                    padding:Utils.all(value: 6.0),
                    child: const CustomImage(path: KImages.cal)
                  ),
                )),
          ),
          Positioned(
            top: size.height * 0.1,
            left: 0.0,
            right: 0.0,
            child: CarouselSlider(
              items: images!
                  .map((e) => CustomImage(
                      path: RemoteUrls.imageUrl(e.image), fit: BoxFit.cover))
                  .toList(),
              options: CarouselOptions(
                height: 240.0,
                viewportFraction: 1,
                initialPage: initialPage,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.1,
            top: size.height * 0.12,
            child: Row(
              children: List.generate(
                images.length,
                (index) {
                  final isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: isActive ? 13.0 : 12.0,
                    width: isActive ? 13.0 : 12.0,
                    margin: const EdgeInsets.only(right: 5.5),
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? transparent : blackColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom:item!.rentPeriod.isNotEmpty ? -(size.height * 0.05) : -(size.height * 0.03),
            right: size.width * 0.1,
            child: Container(
              //height: item!.rentPeriod.isNotEmpty ? 70.0 : 50.0,
              //width: 85.0,
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: yellowColor,
                borderRadius: borderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text: Utils.formatPrice(context, item!.price),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: blackColor,
                  ),
                  item.rentPeriod.isNotEmpty
                      ? CustomTextStyle(
                          text: '/${item.rentPeriod}',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }

  _loanCalculator(BuildContext context) {
    final pCubit = context.read<ProfileCubit>();
    final icon =
        context.read<AppSettingCubit>().settingModel?.setting.currencyIcon;
    const spacer = SizedBox(height: 10.0);
    Utils.showCustomDialog(
      context,
      hp: 16.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const CustomTextStyle(
                    text: 'Loan Calculator',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: blackColor,
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        pCubit.resetValue();
                      },
                      child: const CustomImage(path: KImages.cancelIcon))
                ],
              ),
              const SizedBox(height: 14.0),
              BlocBuilder<ProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return TextFormField(
                    controller: pCubit.amountCon,
                    // initialValue: state.amount,
                    onChanged: (String text) {
                      pCubit.amountChange(text);
                      pCubit.resultChange();
                    },
                    decoration: const InputDecoration(hintText: 'Loan amount'),
                    keyboardType: TextInputType.number,
                    inputFormatters: Utils.allowDecimal,
                  );
                },
              ),
              spacer,
              BlocBuilder<ProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: Utils.symmetric(h: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextStyle(
                                text: '${state.rate.toStringAsFixed(0)}%'),
                            const CustomTextStyle(text: '100%'),
                          ],
                        ),
                      ),
                      Slider(
                        value: state.rate,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: state.rate.toStringAsFixed(0),
                        onChanged: (value) {
                          pCubit.rateChange(value);
                          pCubit.resultChange();
                        },
                      ),
                    ],
                  );
                },
              ),
              spacer,
              BlocBuilder<ProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: Utils.symmetric(h: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextStyle(
                                text: 'Y${state.year.toStringAsFixed(0)}'),
                            const CustomTextStyle(text: 'Y5'),
                          ],
                        ),
                      ),
                      Slider(
                        value: state.year.toDouble(),
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: state.year.toStringAsFixed(0),
                        onChanged: (value) {
                          pCubit.yearChange(value.toInt());
                          pCubit.resultChange();
                        },
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<ProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextStyle(
                        text: 'Monthly Payment',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                      ),
                      Flexible(
                        child: CustomTextStyle(
                          text: '$icon${state.result.toStringAsFixed(2)}',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: yellowColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
              spacer,
              BlocBuilder<ProfileCubit, ProfileStateModel>(
                builder: (context, state) {
                  return PrimaryButton(
                      text: 'Reset',
                      onPressed: () => pCubit.resetValue(),
                      textColor: blackColor,
                      fontSize: 20.0,
                      borderRadiusSize: radius,
                      bgColor: yellowColor);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> images = [
  KImages.detailsImage,
  KImages.detailsImage,
  KImages.detailsImage,
  KImages.detailsImage,
];
