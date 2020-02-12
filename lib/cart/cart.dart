import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manshourclub/main.dart';
import 'package:manshourclub/pages/ProductDetails.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:manshourclub/styles/theme.dart';
import 'package:manshourclub/utils/appbarfunc.dart';
import 'package:manshourclub/utils/sideDrawer.dart';

class Cart extends StatefulWidget {
  final usershopcart;
  final shopingamount;

  Cart({
    Key key,
    this.usershopcart,
    this.shopingamount,
  }) : super(key: key);

  @override
  _CartState createState() => new _CartState();
}

class _CartState extends State<Cart> {
  String TAG = "cart";
  int value = 0;
  String stringValue = '';

  void setfullPrice(price) {
    setState(() {
      stringValue = price.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new appbar(
          title: "",
          totalProduct: widget.shopingamount,
        ),
        drawer: new SideDrawer(),
        body:new Container(
          alignment: Alignment.topCenter,
          child:  new ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.MYColors.productBackGround1,
              ),
              itemCount: (widget.shopingamount - 1),
              itemBuilder: (BuildContext context, int index) {
                int price = int.parse(widget.usershopcart[index.toString()]
                ['product_datails']['price']
                    .toString());
                int count = int.parse(
                    widget.usershopcart[index.toString()]['count'].toString());
                value = value + (price * count);

                print(TAG + "VALE:" + value.toString());
                return getCartItems(
                  widget.usershopcart[index.toString()]['product_datails']
                  ['product_name']
                      .toString(),
                  widget.usershopcart[index.toString()]['count'],
                  widget.usershopcart[index.toString()]['product_datails']
                  ['price']
                      .toString(),
                  widget.usershopcart[index.toString()]['product_datails']['pic']
                      .toString(),
                );
              }),
        ),
        bottomNavigationBar: new Container(
          color: Colors.white,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  ' جمع کل:$value',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Expanded(
                child: new MaterialButton(
                    color: Colors.deepPurple,
                    splashColor: Colors.greenAccent,
                    child: new Text(
                      'Check Out',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCartItems(product_name, prod_count, prod_price, prod_image) {
    return new CartItem(
      prod_name: product_name,
      prod_count: prod_count,
      prod_price: prod_price,
      prod_image: prod_image,
    );
  }
}

class CartItem extends StatelessWidget {
  final prod_name;
  final prod_image;
  final prod_price;
  final prod_count;

//  final prod_id;

  CartItem({
    this.prod_name,
    this.prod_image,
    this.prod_price,
    this.prod_count,
//    this.prod_id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: new Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 8.0, right: 4.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new FadeInImage.assetNetwork(
                                  placeholder: 'images/shop1.jpg',
                                  image: Constants.productimages + prod_image,
                                  width: 50,
                                  height: 50,
                                ),
                                new Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    prod_price,
                                    style: Theme.CustomTextStyle.drawertext(
                                        context),
                                  ),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                prod_name,
                                style:
                                CustomTextStyle.drawertext(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      flex: 1,
                      child:new Container(
                        alignment: Alignment.center,
                        child: new Text(
                          (int.parse(prod_count) * int.parse(prod_price)).toString(),
                          style: CustomTextStyle.drawertext(context),
                        ),
                      )
                    ),
                    new Expanded(
                        flex: 1,
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new Padding(
                                    padding: EdgeInsets.all(5),
                                    child: new Image.asset(
                                      'images/icons/increase.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Image.asset(
                                        'images/icons/decrease.png',
                                        width: 25,
                                        height: 25,
                                      )),
                                ],
                              ),
                              new Card(
                                elevation: 6.0,
                                margin: EdgeInsets.all(4),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    prod_count,
                                    style:
                                    CustomTextStyle.drawertext(context),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
