import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:manshourclub/styles/theme.dart' as theme;


class appbar extends StatefulWidget implements PreferredSizeWidget {

  final title;

  final totalProduct;

  const appbar({Key key, this.title ,this.totalProduct}) : super(key: key);

  @override
  _appbarState createState() => _appbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(50);
}

class _appbarState extends State<appbar> {
  var amont = 0;

  gevaluet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cid = prefs.getString('cid') ?? "1";
    var totalProduct;
    final param = {

      "cid":cid,

    };
    final cartData = await http.post(
        "${Constants.APILINK}ShopCart.php",
        body: param);

    final response = jsonDecode(cartData.body);

    setState(() {
      totalProduct = response['full_count'];

      amont =totalProduct ;
    });

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    gevaluet();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: new Text(widget.title),
      actions: <Widget>[
        new Stack(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null,
            ),
            new Positioned(
                child: new Stack(
                  children: <Widget>[
                    new Icon(Icons.brightness_1,
                      size: 25 ,
                      color: theme.MYColors.priceColor,
                    ),
                    new Positioned(
                        top:3 ,
                        right:5 ,
                        child: new Center(
                          child: new Text(
                            '${amont}',
                            style: CustomTextStyle.whitettxt(context),
                          ),
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
        new Directionality(textDirection: TextDirection.ltr,
            child: IconButton(

                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
        )

        //
        // for Cart Icon

      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
