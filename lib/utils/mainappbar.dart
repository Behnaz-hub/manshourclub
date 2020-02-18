import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:http/http.dart' as http;


class mainappbar extends StatefulWidget implements PreferredSizeWidget{

  final title;

  const mainappbar({Key key, this.title}) : super(key: key);

  @override
  _mainappbarState createState() => _mainappbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>Size.fromHeight(50);
}

class _mainappbarState extends State<mainappbar> {

  int totalProduct = 0 ;
  var shopcartlist = {};
  String TAG ="_mainappbarState";

  int shopingamount;
  int fullprice = 0;


  gevaluet() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cid = prefs.getString('cid') ?? "1";
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    gevaluet();
    return   AppBar(
      backgroundColor: theme.MYColors.darkblue,
      title: new Text(widget.title),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null),

        //
        // for Cart Icon
        new IconButton(
            icon: new Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new Cart(
                    usershopcart: shopcartlist,
                    shopingamount: shopingamount,
                    fullprice:fullprice,
                  ));
              Navigator.of(context).push(route);
            }),
      ],
    );
  }


}