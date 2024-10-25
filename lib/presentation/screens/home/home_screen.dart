import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import 'package:real_estate/presentation/widget/fetch_text_error.dart';

import '/logic/cubit/home/cubit/home_cubit.dart';
import '/logic/cubit/profile/profile_cubit.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/loading_widget.dart';
import '/presentation/widget/page_refresh.dart';
import '../../../../presentation/utils/constraints.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../../logic/cubit/setting/app_setting_cubit.dart';
import '../../router/route_names.dart';
import 'component/fun_fact_section.dart';
import 'component/home_app_bar.dart';
import 'component/horizontal_category_view.dart';
import 'component/horizontal_property_view.dart';
import 'component/property_agents_view.dart';
import 'component/search_field.dart';
import 'component/single_property_card_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      //appBar: const HomeAppBar(),
      body: PageRefresh(
        onRefresh: () async => homeCubit.getHomeData(),
        child: Utils.logoutListener(
          child: BlocListener<ProfileCubit, ProfileStateModel>(
            listener: (context, state) {
              final profile = state.profileState;
              if (profile is ProfileUpdateLoaded) {
                Utils.showSnackBar(context, profile.message);
                context.read<ProfileCubit>().getAgentProfile();
              }
              if (profile is ProfileError) {
                if (profile.statusCode == 401) {
                  // debugPrint('profile-error ${profile.message}');
                  Utils.logout(context);
                }
              }
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const LoadingWidget();
                }
                if (state is HomeErrorState) {
                  return FetchErrorText(text: state.error);
                }
                if (state is HomeDataLoaded) {
                  return LoadedWidget(homeDataModel: state.homeDataLoaded);
                }
                if (homeCubit.homeModel != null) {
                  return LoadedWidget(homeDataModel: homeCubit.homeModel!);
                } else {
                  return const FetchErrorText(text: 'Something went wrong!');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadedWidget extends StatefulWidget {
  const LoadedWidget({super.key, required this.homeDataModel});

  final HomeDataModel homeDataModel;

  @override
  State<LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<LoadedWidget> {
  late String image;
  late AppSettingCubit appSetting;

  _initState() {
    appSetting = context.read<AppSettingCubit>();
    final profileImage = context.read<ProfileCubit>();
    if (profileImage.users != null) {
      image = profileImage.users!.image;
    } else {
      image = appSetting.settingModel!.setting.defaultAvatar;
    }
  }

  @override
  void initState() {
    _initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("imageeee: $image");
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        HomeAppBar(image: image, logo: appSetting.settingModel!.setting.logo),
        Utils.verticalSpace(0.0),
        // const HomeAppBar(),
        const SearchField(),
        HorizontalCategoryView(category: widget.homeDataModel.category),
        Utils.verticalSpace(20),
        if (widget.homeDataModel.urgentProperty != null) ...[
          HorizontalPropertyView(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.urgentPropertyScreen),
              headingText: widget.homeDataModel.urgentProperty!.title,
              featuredProperty: widget.homeDataModel.urgentProperty!),
        ],
        Utils.verticalSpace(20),
        PropertyAgentView(agentsModel: widget.homeDataModel.agent),
        Utils.verticalSpace(20),
        HorizontalPropertyView(
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.allPropertyScreen),
            headingText: widget.homeDataModel.featuredProperty!.description,
            featuredProperty: widget.homeDataModel.featuredProperty!),
        Utils.verticalSpace(20),
        FunFactSection(counter: widget.homeDataModel.counter),
        Utils.verticalSpace(20),

         Padding(
           padding:  Utils.symmetric(h: 16.0),
           child: const CustomTextStyle(text: "Recommend for you",fontSize: 18.0,fontWeight: FontWeight.w600,),
         ),
        Utils.verticalSpace(6.0),
        ...List.generate(widget.homeDataModel.latestProperty!.length, (index){
          final item =  widget.homeDataModel.latestProperty![index];
          return Padding(
            padding: Utils.symmetric(h: 16.0),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.propertyDetailsScreen,
                      arguments: item.slug,
                    ),
                    child: SinglePropertyCardView(property: item))
            ],),
          );
        })

        // const RecommendedProperties(),
        // const SizedBox(height: 20.0),
      ],
    );
  }
}
