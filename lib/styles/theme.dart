import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYColors {

  const MYColors();

  static const Color loginGradientStart = Color.fromRGBO(134, 188, 66, 1);
  static const Color loginGradientEnd = Color.fromRGBO(45, 62, 80, 1);
  static const Color priceColor = Color.fromRGBO(187, 39, 32, 0.91);
  static const Color productNameColor = Color.fromRGBO(0, 72, 63, 1);
  static const Color productBackGround = Color.fromRGBO(45, 62, 80, 0.5);
  static const Color productBackGround1 = Color(0xFF1fa451);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}
class CustomTextStyle {
  static TextStyle drawertext(BuildContext context) {
    return Theme.of(context).textTheme.display4.copyWith(color: Colors.black,
        fontFamily: "IRANSans",
        fontSize: 14 ,
        fontWeight: FontWeight.w500);
  }
}