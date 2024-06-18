// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:loveria/screens/users_list.dart';
import '../../support/app_theme.dart' as app_theme;
import '../../screens/encounter.dart';
import '../../screens/home.dart';
import '../../screens/messenger/messenger.dart';
import '../../screens/my_photos.dart';
import '../../screens/profile_details.dart';

class BottomBar extends StatefulWidget {
  static const String bottomBarRoute = "/bottomBar";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 2; // Local state to manage selected index

  final List<Widget> _pages = [
    const UsersListPage(),
    const EncounterPage(),
    const MyPhotosPage(),
    const MessengerPage(),
    const ProfileDetailsPage(),
  ];

  final List<String> _bottomItems = [
    "Home",
    "Maps",
    "Match",
    "Chats",
    "Profile",
  ];

  final List<String> _bottomItemsIcons = [
    "assets/images/Home.svg",
    "assets/images/Heart.svg",
    "assets/images/Discovery.svg",
    "assets/images/Chat.svg",
    "assets/images/Profile.svg",
  ];

  final List<String> _bottomItemsIconsFill = [
    "assets/Home-fill.svg",
    "assets/Profile-fill.svg",
    "assets/Discovery-fill.svg",
    "assets/Heart-fill.svg",
    "assets/Chat-fill.svg",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xff27262B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                          clipBehavior: Clip.none,
                          itemCount: _bottomItemsIcons.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => _onItemTapped(index),
                              child: Container(
                                height: 45,
                                width: constraints.maxWidth * 0.1833,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: _selectedIndex == index
                                      ? Color.fromARGB(255, 51, 123, 109)
                                      : Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      _selectedIndex == index
                                          ? _bottomItemsIconsFill[index]
                                          : _bottomItemsIcons[index],
                                      width: 22,
                                      height: 22,
                                      color: _selectedIndex == index
                                          ? app_theme.primary
                                          : app_theme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: _pages[_selectedIndex],
        );
      },
    );
  }
}
