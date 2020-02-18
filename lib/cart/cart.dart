import 'dart:convert';

import 'package:persian_numbers/persian_numbers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:manshourclub/cart/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'package:manshourclub/styles/theme.dart';
import 'package:manshourclub/utils/appbarfunc.dart';
import 'package:manshourclub/utils/sideDrawer.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  var usershopcart = {};
  int shopingamount;
  int fullprice;
  final prod_name;
  final prod_image;
  final prod_price;
  String prod_count;
  final prod_id;

  Cart({
    Key key,
    this.usershopcart,
    this.shopingamount,
    this.fullprice,
    this.prod_name,
    this.prod_image,
    this.prod_price,
    this.prod_count,
    this.prod_id,
  }) : super(key: key);

  @override
  _CartState createState() => new _CartState();
}

class _CartState extends State<Cart> {
  String TAG = "cart";
  int value = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("shopingamount: "+widget.shopingamount.toString());
    print("usershopcart: "+widget.usershopcart.toString());

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new appbar(
          title: '',
          totalProduct: widget.usershopcart['full_count'],
        ),
        drawer: new SideDrawer(),
        body: new Container(
          alignment: Alignment.topCenter,
          child: widget.usershopcart['full_count'] > 0 ?  new ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Theme.MYColors.productBackGround1,
              ),
              itemCount: (widget.shopingamount - 1),
              itemBuilder: (BuildContext context, int index) {
                return items(
                  widget.usershopcart[index.toString()]['product_datails']
                  ['product_name']
                      .toString(),
                  widget.usershopcart[index.toString()]['count'],
                  widget.usershopcart[index.toString()]['product_datails']
                  ['price']
                      .toString(),
                  widget.usershopcart[index.toString()]['product_datails']
                  ['pic']
                      .toString(),
                  widget.usershopcart[index.toString()]['product_id'],
                );
              }) : Center(
            child: Text('سبد خرید شما خالی است!',style: TextStyle(fontFamily: 'IRANSans'),),
          ),
        ),
        bottomNavigationBar: new Container(
          color: Colors.white,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  " " + PersianNumbers.toPersian( widget.fullprice.toString()) + " تومان",
                  style: Theme.CustomTextStyle.drawertext(context),
                ),
              ),
              new Expanded(
                child: new MaterialButton(
                    color: Theme.MYColors.green,
                    splashColor: Colors.greenAccent,
                    child: new Text(
                      'پرداخت',
                      style:Theme.CustomTextStyle.whitettxt(context),
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget items(product_name, prod_count, prod_price, prod_image, prod_id) {
    var provider = Provider.of<MyCart>(context);
    return new Card(
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
                                    PersianNumbers.toPersian(prod_price),
                                    style: Theme.CustomTextStyle.numbers(context),
                                  ),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                product_name,
                                style: CustomTextStyle.drawertext(context),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                        flex: 1,
                        child: new Container(
                          alignment: Alignment.center,
                          child: new Text(
                            PersianNumbers.toPersian((int.parse(prod_count) * int.parse(prod_price)).toString()),
                            style: CustomTextStyle.numbers(context),
                          ),
                        )),
                    new Expanded(
                        flex: 1,
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  new GestureDetector(
                                    onTap: () async {
                                      provider.addToCart(int.parse(prod_id));
                                      SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                      final cid = prefs.getString('cid') ?? "1";
                                      print(TAG + "cid:" + cid);
                                      final param = {
                                        "cid": cid,
                                      };
                                      final newcartData = await http.post(
                                          "${Constants.APILINK}ShopCart.php",
                                          body: param);

                                      widget.usershopcart = jsonDecode(newcartData.body);
                                      print(TAG + ":shopcartlist :" + widget.usershopcart.toString());
                                      setState(() {
                                        widget.fullprice += int.parse(prod_price) ;
                                        widget.usershopcart['full_count'] ;

                                        prod_count = (int.parse(prod_count)+1).toString();
                                        print(TAG + "prod_count:" + prod_count);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: new Image.asset(
                                        'images/icons/increase.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  new GestureDetector(
                                    onTap: () async {

                                          provider.removeFromCart(int.parse(prod_id));
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          final cid = prefs.getString('cid') ?? "1";
                                          final param = {
                                          "cid": cid,
                                          };
                                          final newcartData = await http.post(
                                          "${Constants.APILINK}ShopCart.php",
                                          body: param);

                                          widget.usershopcart = jsonDecode(newcartData.body);
                                          print(TAG + ":shopcartlist :" + widget.usershopcart.toString());
                                          setState(() {
                                            widget.fullprice -=
                                                int.parse(prod_price);
                                            widget.usershopcart['full_count'];

                                            prod_count =(int.parse(prod_count) - 1).toString();
                                            print(TAG + "prod_count:" + prod_count);
                                            if(int.parse(prod_count) == 0){
                                              widget.shopingamount -- ;
                                            }
                                          });
                                          },
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          'images/icons/decrease.png',
                                          width: 25,
                                          height: 25,
                                        )),
                                  ),
                                ],
                              ),
                              new Card(
                                elevation: 6.0,
                                margin: EdgeInsets.all(4),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    PersianNumbers.toPersian(prod_count.toString()),
                                    style: CustomTextStyle.numbers(context),
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
