import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/utils/constraints.dart';
import '../../../../presentation/widget/custom_app_bar.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/model/product/property_choose_model.dart';
import '../../../logic/cubit/add_property/add_property_cubit.dart';
import '../../../logic/cubit/create_property/create_info_cubit.dart';
import '../../router/route_names.dart';
import '../../utils/utils.dart';
import '../../widget/custom_test_style.dart';
import '../../widget/loading_widget.dart';
import '../../widget/page_refresh.dart';
import 'component/single_choose_option.dart';

class ChoosePropertyOptionScreen extends StatefulWidget {
  const ChoosePropertyOptionScreen({super.key});

  @override
  State<ChoosePropertyOptionScreen> createState() =>
      _ChoosePropertyOptionScreenState();
}

class _ChoosePropertyOptionScreenState
    extends State<ChoosePropertyOptionScreen> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<CreateInfoCubit>().getPropertyChooseInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final propertyCubit = context.read<CreateInfoCubit>();
    //propertyCubit.getPropertyChooseInfo();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Choose Property Option',
      ),
      body: PageRefresh(
        onRefresh: () async => propertyCubit.getPropertyChooseInfo(),
        child: Utils.logoutListener(
          child: BlocConsumer<CreateInfoCubit, CreateInfoState>(
            listener: (context, state) {
              if (state is CreateInfoError) {
                if (state.statusCode == 401) {
                  Utils.logout(context);
                }
              }
            },
            builder: (context, state) {
              if (state is CreateInfoLoading) {
                return const LoadingWidget();
              } else if (state is CreateInfoError) {
                if (state.statusCode == 503) {
                  return LoadedPropertyChooseInfo(
                      chooseProperty: propertyCubit.chooseProperty!);
                } else {
                  return Center(
                    child: CustomTextStyle(
                      text: state.error,
                      color: redColor,
                      fontSize: 20.0,
                    ),
                  );
                }
              } else if (state is PropertyChooseInfoLoaded) {
                return LoadedPropertyChooseInfo(
                    chooseProperty: state.chooseProperty);
              }
              return const Center(
                  child: CustomTextStyle(text: 'Something went wrong'));
            },
          ),
        ),
      ),
    );
  }
}

class LoadedPropertyChooseInfo extends StatelessWidget {
  const LoadedPropertyChooseInfo({super.key, required this.chooseProperty});

  final PropertyChooseModel chooseProperty;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: [
        SingleChooseOption(
          onTap: () {
            // context.read<PropertyCreateBloc>().add(PropertyStateReset());
            // Navigator.pushNamed(context, RouteNames.addNewPropertyScreen,
            //     arguments: 'rent');
            context.read<AddPropertyCubit>().changeType('rent');
            context.read<AddPropertyCubit>().resetData();
            Navigator.pushNamed(context, RouteNames.newPropertyCreateScreen,
                arguments: '');
          },
          //icon: KImages.rentIcon,
          icon: RemoteUrls.imageUrl(chooseProperty.rentLogo),
          text: chooseProperty.rentTitle,
          subText: chooseProperty.rentDescription,
          iconBgColor: borderColor,
        ),
        const SizedBox(height: 10.0),
        SingleChooseOption(
          onTap: () {
            context.read<AddPropertyCubit>().changeType('sale');
            context.read<AddPropertyCubit>().resetData();
            Navigator.pushNamed(context, RouteNames.newPropertyCreateScreen,
                arguments: '');
          },
          //icon: KImages.saleIcon,
          icon: RemoteUrls.imageUrl(chooseProperty.saleLogo),
          text: chooseProperty.saleTitle,
          subText: chooseProperty.saleDescription,
          iconBgColor: yellowColor.withOpacity(0.15),
        ),
      ],
    );
  }
}
