import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = Color.fromRGBO(134, 188, 66, 1);
  static const Color loginGradientEnd = Color.fromRGBO(45, 62, 80, 1);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}