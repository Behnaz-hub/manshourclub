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
import 'package:persian_numbers/persian_numbers.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


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
  int fullprice = 0;
  String TAG="ProductDetails";
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
    print(TAG + ":response: " + response.toString());
    totalProduct = response['full_count'];
    print(TAG + ":totalProduct: " + totalProduct.toString());
    shopcartlist = jsonDecode(cartData.body);
    shopingamount = shopcartlist.length;
    for(int i = 0; i<(shopingamount -1 ) ; i++){
    fullprice += int.parse(response[i.toString()]['product_datails']['price'])*
                  int.parse(response[i.toString()]['count']);

    }

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    gevaluet();
  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<MyCart>(context);


    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property

        child:new Scaffold(
          appBar:  new AppBar(
            backgroundColor: theme.MYColors.darkblue,
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
                            fullprice: fullprice,
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
                                    fullprice: fullprice,
                                  ));
                              Navigator.of(context).push(route);
                            }
                                    ),
                        new Positioned(
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                size: 25 ,
                                    color: theme.MYColors.red,),
                                new Positioned(
                                    top:0 ,
                                    right:7 ,
                                    child: new Center(
                                        child: new Text(
                                          PersianNumbers.toPersian(totalProduct.toString()),
                                          style: CustomTextStyle.whitenumbers(context),
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
                child: BackButton(
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                    ),
              )

              //
              // for Cart Icon

            ],
          ),
          body: new Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.grey[300] , border: Border.all(color: Colors.grey,width: 2)),
            child: new ListView(
              children: <Widget>[

                // Setting the image and details of the product
                new Container(
                  height:300.0,
                  child: new GridTile(
                    child:new Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: new Container(
                          height:25.0,
                          color:Colors.transparent,
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
                                    PersianNumbers.toPersian(widget.productDetailsNewPrice),
                                    style: CustomTextStyle.numbers(context),

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
//              new Row(
//                children: <Widget>[
//                  new Expanded(
//                    child:new MaterialButton(
//                      child: new Row(
//                        children: <Widget>[
//                          new Expanded(
//                              child:new Text('Size')
//                          ),
//                          new Expanded(
//                            child:new Icon(Icons.keyboard_arrow_down),
//                          ),
//                        ],
//                      ),
//                      color:Colors.white,
//                      textColor: Colors.grey,
//                      onPressed:(){},
//                    ),
//                  ),
//
//                  //for color button
//                  new Expanded(
//                    child:new MaterialButton(
//                      child: new Row(
//                        children: <Widget>[
//                          new Expanded(
//                              child:new Text('Color')
//                          ),
//                          new Expanded(
//                            child:new Icon(Icons.keyboard_arrow_down),
//                          ),
//                        ],
//                      ),
//                      color:Colors.white,
//                      textColor: Colors.grey,
//                      onPressed:(){},
//                    ),
//                  ),
//
//                  new Expanded(
//                    child:new MaterialButton(
//                      child: new Row(
//                        children: <Widget>[
//                          new Expanded(
//                              child:new Text('Qty')
//                          ),
//                          new Expanded(
//                            child:new Icon(Icons.keyboard_arrow_down),
//                          ),
//                        ],
//                      ),
//                      color:Colors.white,
//                      textColor: Colors.grey,
//                      onPressed:(){},
//                    ),
//                  ),
//                ],
//              ),

                new Padding(
                  padding: const EdgeInsets.only(left:64.0,right: 64.0,top: 16.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new MaterialButton(
                          child: new Text("خرید", style: CustomTextStyle.whitettxt(context),),
                          color:theme.MYColors.green,
                          textColor: Colors.white,
                          onPressed: (){
                            provider.addToCart(int.parse(widget.productId));
                            setState(() {
                              totalProduct ;
                            });
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
        ),
      )

    );
  }

}
