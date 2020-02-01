import 'package:flutter/material.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SizedBox(
          width: 500,
          height: 150,
          child: Column(
            children: <Widget>[
              Container(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.MYColors.loginGradientStart,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.MYColors.loginGradientEnd),
                ),
                color: Colors.transparent,
              ),
            ],
          )),
    );
  }
}
