import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MYColors {

  const MYColors();

  static const Color loginGradientStart = Color.fromRGBO(134, 188, 66, 1);
  static const Color loginGradientEnd = Color.fromRGBO(45, 62, 80, 1);
  static const Color priceColor = Color.fromRGBO(187, 39, 32, 0.91);
  static const Color productNameColor = Color.fromRGBO(0, 72, 63, 1);
  static const Color productBackGround = Color.fromRGBO(45, 62, 80, 0.5);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}