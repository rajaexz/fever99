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
  int? _selectedIndex; // Local state to manage selected index, initialized to null

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
  
    "assets/images/Heart.svg",
    "assets/images/Discovery.svg",
      "assets/images/Home.svg",
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
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: app_theme.primary3,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_bottomItemsIcons.length, (index) {
                bool isSelected = _selectedIndex == index;
                return InkWell(
                  onTap: () => _onItemTapped(index),
                  child: Container(
                    height: 45,
                    width: constraints.maxWidth * 0.1833,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? app_theme.primary
                          : app_theme.primary3,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        isSelected
                            ? _bottomItemsIconsFill[index]
                            : _bottomItemsIcons[index],
                        width: 22,
                        height: 22,
                        color: isSelected ? Colors.white : app_theme.primary,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : app_theme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          body: _selectedIndex != null ? _pages[_selectedIndex!] : UsersListPage(),
        );
      },
    );
  }
}
