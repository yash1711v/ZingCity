import 'dart:io';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../data/model/agency/agency_details_model.dart';
import '../../../../data/model/home/home_data_model.dart';
import '../../../../logic/cubit/home/cubit/home_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_theme.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
        width: 324,
        height: 60,
        decoration: ShapeDecoration(
          color:  Color(0xFFE7EBF4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          shadows: [BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 8,
            offset: Offset(0, 1),
            spreadRadius: 5,
          )]
        ),
        child: StreamBuilder(
            stream: controller.naveListener.stream,
            builder: (_, AsyncSnapshot<int> index) {
              int selectedIndex = index.data ?? 0;
              return BottomBar(
                showActiveBackgroundColor: false,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                selectedIndex: selectedIndex,
                onTap: (int index) {
                  controller.naveListener.sink.add(index);
                  if(index == 1){
                    List<Properties>? properties = context.read<HomeCubit>().state.rentProperties ;

                      List<Properties>? ResidentialProperties = [];

                      ( properties ?? []).forEach((element){
                        // element.
                        if(element.propertyTypeId == 1){
                          ResidentialProperties.add(element);
                        }
                        debugPrint(ResidentialProperties.length.toString());
                        context.read<HomeCubit>().setListOfData(ResidentialProperties);
                      });

                  }

                  if(index == 2){
                    List<Properties>? properties = context.read<HomeCubit>().state.buyProperties ;
                    // List<Properties>? buyProperties = context.read<HomeCubit>().state.buyProperties ;
                      List<Properties>? ResidentialProperties = [];

                      ( properties ?? []).forEach((element){
                        // element.
                        if(element.propertyTypeId == 1){
                          ResidentialProperties.add(element);
                        }
                        debugPrint(ResidentialProperties.length.toString());
                        context.read<HomeCubit>().setListOfData(ResidentialProperties);
                      });

                  }
                },
                items: const <BottomBarItem>[
                  BottomBarItem(
                    icon: ImageIcon(AssetImage("assets/images/solar_home-2-outline.png")),
                    title: Text('Home'),
                    activeColor: Color(0xfff30469A),
                  ),
                  BottomBarItem(
                    icon: ImageIcon(AssetImage("assets/images/eventIcon.png")),
                    title: Text('RENT'),
                    activeColor: Color(0xfff30469A),
                  ),
                  BottomBarItem(
                    icon: ImageIcon(AssetImage("assets/images/iconamoon_profile-light.png")),
                    title: Text('BUY'),
                    activeColor: Color(0xfff30469A),
                  ),
                  BottomBarItem(
                    icon: ImageIcon(AssetImage("assets/images/ph_heart.png")),
                    title: Text('Saved'),
                    activeColor: Color(0xfff30469A),
                  ),
                ],
              );
            })
    );
  }

  Widget _navIcon(String path) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SvgPicture.asset(path));
}
