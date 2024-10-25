import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/cubit/booking/booking_cubit.dart';
import 'package:real_estate/presentation/widget/fetch_text_error.dart';

import '/presentation/utils/utils.dart';
import '/presentation/widget/loading_widget.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/utils/k_images.dart';
import '../../../../presentation/widget/custom_images.dart';
import '../../../../presentation/widget/custom_test_style.dart';
import '../../../data/model/product/single_property_model.dart';
import '../../../logic/cubit/home/cubit/property_details_cubit.dart';
import '../../widget/page_refresh.dart';
import 'component/property_details_nav_bar.dart';
import 'component/property_details_view.dart';
import 'component/property_horizontal_view.dart';
import 'component/property_images_slider.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  @override
  void initState() {
    print('init');
    context.read<PropertyDetailsCubit>().fetchPropertyDetails(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<PropertyDetailsCubit>();
    //detailsCubit.fetchPropertyDetails(widget.slug);
    //final size = MediaQuery.of(context).size;
    if (detailsCubit.singleProperty == null) {
      // print('NULLLLLLLLLL');
      detailsCubit.fetchPropertyDetails(widget.slug);
    } else {
      // print('NOT NULLLLL');
    }
    return Scaffold(
      backgroundColor: scaffoldBackground,
      body: PageRefresh(
        onRefresh: () async => detailsCubit.fetchPropertyDetails(widget.slug),
        child: BlocBuilder<PropertyDetailsCubit, PropertyDetailsState>(
          builder: (context, state) {
            if (state is PropertyDetailsLoading) {
              return const LoadingWidget();
            }
            if (state is PropertyDetailsError) {
              if (state.code == 503 || detailsCubit.singleProperty != null) {
                return LoadedProperDetails(
                    property: detailsCubit.singleProperty!);
              } else {
                return FetchErrorText(text: state.error);
              }
            }
            if (state is PropertyDetailsLoaded) {
              context.read<BookingCubit>().changePropertyId(
                  state.singlePropertyModel.propertyItemModel!.id.toString());
              return LoadedProperDetails(property: state.singlePropertyModel);
            }
            return const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: const PropertyDetailNavBar(),
    );
  }
}

class LoadedProperDetails extends StatelessWidget {
  const LoadedProperDetails({super.key, required this.property});

  final SinglePropertyModel property;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      children: [
        PropertyImagesSlider(property: property),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: size.height * 0.06)
              .copyWith(bottom: size.height * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextStyle(
                text: property.propertyItemModel!.title,
                color: blackColor,
                fontWeight: FontWeight.w700,
                height: 1.2,
                maxLine: 2,
                overflow: TextOverflow.ellipsis,
                fontSize: 20.0,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const CustomImage(path: KImages.locationIcon),
                  Utils.horizontalSpace(8.0),
                  Flexible(
                    child: CustomTextStyle(
                      text: property.propertyItemModel!.address,
                      color: grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PropertyHorizontalView(property: property),
        const PropertyTextTabView(),
        const SizedBox(height: 0),
      ],
    );
  }
}
