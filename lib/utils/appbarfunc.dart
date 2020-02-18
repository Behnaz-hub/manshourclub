import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/styles/theme.dart';
import 'package:persian_numbers/persian_numbers.dart';
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
  int totalProduct = 0 ;
  var shopcartlist = {};
  String TAG ="appbar";

  int shopingamount;
  int fullprice = 0;
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
    totalProduct = response['full_count'];
    shopcartlist = jsonDecode(cartData.body);
    shopingamount = shopcartlist.length;

    for(int i = 0; i<(shopingamount -1 ) ; i++){
      fullprice = fullprice + int.parse(response[i.toString()]['product_datails']['price'])*
          int.parse(response[i.toString()]['count']);
    }

      totalProduct = response['full_count'];
      amont =totalProduct ;


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
      backgroundColor:  theme.MYColors.darkblue,
      title: new Text(widget.title),
      actions: <Widget>[
        new Stack(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: (){

              },
            ),
            new Positioned(
                child: new Stack(
                  children: <Widget>[
                    new Icon(Icons.brightness_1,
                      size: 25 ,
                      color: theme.MYColors.red,
                    ),
                    new Positioned(
                        top:0 ,
                        right:7 ,
                        child: new Center(
                          child: new Text(
                            PersianNumbers.toPersian(widget.totalProduct.toString()),
                            style: CustomTextStyle.whitenumbers(context),
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
