import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MYColors {

  const MYColors();

  static const Color loginGradientStart = Color.fromRGBO(134, 188, 66, 1);
  static const Color loginGradientEnd = Color.fromRGBO(45, 62, 80, 1);
  static const Color priceColor = Color(0xff1f5f56);
  static const Color productNameColor = Color.fromRGBO(0, 72, 63, 1);
  static const Color productBackGround = Color(0xcce3e3e3);
  static const Color productBackGround1 = Color(0xFF1fa451);
  static const Color darkblue = Color(0xFF02162B);
  static const Color green = Color(0xFF5FA246);
  static const Color red = Color(0xFFD8160E);

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
        fontSize: 16 ,
        fontWeight: FontWeight.w500);
  }

  static TextStyle whitettxt(BuildContext context) {
    return Theme.of(context).textTheme.display4.copyWith(color: Colors.white,
        fontFamily: "IRANSans",
        fontSize: 16 ,
        fontWeight: FontWeight.w500);
  }

  static TextStyle numbers(BuildContext context) {
    return Theme.of(context).textTheme.display4.copyWith(color: Colors.black,
        fontFamily: "IRANSansL",
        fontSize: 18 ,
        fontWeight: FontWeight.w500);
  }
  static TextStyle whitenumbers(BuildContext context) {
    return Theme.of(context).textTheme.display4.copyWith(color: Colors.white,
        fontFamily: "IRANSansL",
        fontSize: 18 ,
        fontWeight: FontWeight.w500);
  }
}
