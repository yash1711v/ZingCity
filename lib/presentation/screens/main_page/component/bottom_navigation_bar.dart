import 'dart:io';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
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
          color: const Color(0x3330469A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
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
                    title: Text('Settings'),
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
