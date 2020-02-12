import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:load/load.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/cart/my_cart.dart';
import 'package:manshourclub/models/usershopcart.dart';
import 'package:manshourclub/styles/theme.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ProductDetails extends StatelessWidget {

  final productDetailsName;
  final productDetailsImage;
  final productDetailsNewPrice;
  final productDetailsdetails;
  final productId;

  ProductDetails({
    Key key,
    this.productDetailsName,
    this.productDetailsImage,
    this.productDetailsNewPrice,
    this.productId,
    this.productDetailsdetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<MyCart>(
      create: (context) => MyCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "kl",
        home: _ProductDetail(
            productDetailsName: productDetailsName,
            productDetailsImage:productDetailsImage,
            productDetailsNewPrice:productDetailsNewPrice,
            productDetailsdetails:productDetailsdetails,
            productId:productId,
        ),
      ),
    );
  }

}

class _ProductDetail extends StatefulWidget{
  final productDetailsName;
  final productDetailsImage;
  final productDetailsNewPrice;
  final productDetailsdetails;
  final productId;

  _ProductDetail({
    Key key,
    this.productDetailsName,
    this.productDetailsImage,
    this.productDetailsNewPrice,
    this.productId,
    this.productDetailsdetails}) : super(key: key);

  @override
  _ProductDetailsState createState() => new  _ProductDetailsState();
}

class _ProductDetailsState extends State<_ProductDetail> {

  int totalProduct = 0 ;
  var shopcartlist = {};
  int shopingamount;

  String _parseHtmlString(String htmlString) {

    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

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

  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<MyCart>(context);

    gevaluet();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property

        child:new Scaffold(
          appBar:  new AppBar(
            backgroundColor: Colors.deepPurple,
            title: new Text(""),
            actions: <Widget>[
              new Padding(
                  padding: const EdgeInsets.all(8.0) ,
                  child: new GestureDetector(
                    onTap: (){
                      var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new Cart(

                            usershopcart: shopcartlist,
                            shopingamount: shopingamount,
                          ));
                      Navigator.of(context).push(route);
                    },
                    child: new Stack(
                      children: <Widget>[
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
                                  ));
                              Navigator.of(context).push(route);
                            }
                                    ),
                        new Positioned(
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                size: 25 ,
                                    color: theme.MYColors.priceColor,),
                                new Positioned(
                                    top:3 ,
                                    right:5 ,
                                    child: new Center(
                                        child: new Text(
                                          '$totalProduct',
                                          style: CustomTextStyle.whitettxt(context),
                                        ),
                                    )
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),

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
          ),
          body: new ListView(
            children: <Widget>[

              // Setting the image and details of the product
              new Container(
                height:300.0,
                child: new GridTile(
                  child:new Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: new Container(
                        height:25.0,
                        color:Colors.white70,
                        margin: EdgeInsets.only(top: 5 ,left: 10 , right: 10),
                        child:new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Image.network( Constants.productimages + widget.productDetailsImage),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                      widget.productDetailsName,
                                      style: CustomTextStyle.drawertext(context),
                                ),

                               new Text(
                                    widget.productDetailsNewPrice,
                                    style: CustomTextStyle.drawertext(context),

                                  ),

                              ],
                            ),
                          ],
                        )
                    ),
                  ),

                ),
              ),


              //
              new Row(
                children: <Widget>[
                  new Expanded(
                    child:new MaterialButton(
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child:new Text('Size')
                          ),
                          new Expanded(
                            child:new Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                      color:Colors.white,
                      textColor: Colors.grey,
                      onPressed:(){},
                    ),
                  ),

                  //for color button
                  new Expanded(
                    child:new MaterialButton(
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child:new Text('Color')
                          ),
                          new Expanded(
                            child:new Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                      color:Colors.white,
                      textColor: Colors.grey,
                      onPressed:(){},
                    ),
                  ),

                  new Expanded(
                    child:new MaterialButton(
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                              child:new Text('Qty')
                          ),
                          new Expanded(
                            child:new Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                      color:Colors.white,
                      textColor: Colors.grey,
                      onPressed:(){},
                    ),
                  ),
                ],
              ),

              new Padding(
                padding: const EdgeInsets.only(left:64.0,right: 64.0,top: 16.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new MaterialButton(
                          child: new Text("خرید", style: CustomTextStyle.whitettxt(context),),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () async {
                            provider.addToCart(int.parse(widget.productId));
                            totalProduct += 1;
                            showLoadingDialog();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            final cid = prefs.getString('cid') ?? "1";
                            final param = {
                              "product_id":widget.productId,
                              "cid":cid,
                              "type":"add",
                            };
                            final cartData = await http.post(
                                "${Constants.APILINK}ShopCart.php",
                                body: param);

                            final response = jsonDecode(cartData.body);

                            if (response['status'] == 'success') {
                              print('yes added!');
                            } else {
                              print('محصول اضافه نشد');
                            }
                            hideLoadingDialog();
                          },
                      ),
                    ),
                    new IconButton(
                        color: Colors.deepPurple,
                        icon:new Icon(Icons.add_shopping_cart),
                        onPressed: (){

                        }
                    ),
                    new IconButton(
                        color: Colors.deepPurple,
                        icon:new Icon(Icons.favorite_border),
                        onPressed: (){}
                    ),
                  ],
                ),
              ),

              //""""""""""""""""""""""""""
              //
              // """"""""""""""""""""""""""""
              new Padding(
                padding: const EdgeInsets.only(left:16.0,top: 8.0),
                child: new Text(
                  'توضیحات:',
                  style: CustomTextStyle.drawertext(context),
                ),
              ),

              new Padding(
                padding: const EdgeInsets.only(left:16.0,top: 8.0),

                child: Html(
//                    widget.productDetailsdetails
                  data:
                  _parseHtmlString(widget.productDetailsdetails),
                  padding: EdgeInsets.all(8.0),

                ),
              ),

            ],
          ),
        ),
      )

    );
  }

}
