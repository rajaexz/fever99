import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Logo image
final logoImage = SvgPicture.asset(
  "assets/images/logo.svg",
);
final premiumBadge = SvgPicture.asset(
  "assets/images/premium-badge.svg",
);
const backgroundImage = AssetImage(
  "assets/images/bgs/bg2.jpg",
);

// colors
const Color black = Color.fromARGB(255, 5, 5, 5);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color primary = Color(0xFF7FE09F);
const Color sidebarBgColor = Color.fromARGB(255, 253, 253, 253);
const LinearGradient primaryGradient = LinearGradient(
  colors: [
    white,
    primary,
    primary,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const Color secondary = Color.fromARGB(255, 127, 224, 159);
const Color error = Color.fromRGBO(165, 17, 179, 1);
const Color success = Color.fromRGBO(35, 202, 29, 1);
const Color warning = Color.fromRGBO(215, 168, 27, 1);
