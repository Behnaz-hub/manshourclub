import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: SizedBox(
          width: 500,
          height: 10,
          child: Column(
            children: <Widget>[
              Container(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
                color: Colors.transparent,
              ),
            ],
          )),
    );
  }
}
