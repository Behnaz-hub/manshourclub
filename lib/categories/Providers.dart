import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/cart/my_cart.dart';
import 'package:manshourclub/models/providers.dart';
import 'package:manshourclub/styles/loading.dart';
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:http/http.dart' as http;
import 'package:manshourclub/styles/theme.dart';
import 'package:manshourclub/utils/appbarfunc.dart';
import 'package:manshourclub/utils/sideDrawer.dart';
import 'package:manshourclub/utils/toast_utils.dart';
import 'package:persian_numbers/persian_numbers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'Products.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;


class Providers extends StatelessWidget {

  final aid;


  Providers({
    Key key,
    this.aid,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<MyCart>(
      create: (context) => MyCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "kl",
        home: _Providers(
          aid: aid,

        ),
      ),
    );
  }

}


class _Providers extends StatefulWidget {
  final aid;

  _Providers({this.aid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("id is;" + aid);

    return prov();
  }
}

class prov extends State<_Providers> {
  List<providers> asnaf;
  var product_list = [];
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
    setState(() {
      gevaluet();
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
  ListView providerlistview(data) {
    return ListView.builder(
        itemCount: asnaf.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Hero(
            tag: asnaf[index],
            child: Container(
                width: MediaQuery.of(context).size.width * .25,
                decoration: BoxDecoration(
                    border: Border.all(color: theme.MYColors.productBackGround),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () async {
                    print(data[index].pid);

                    final prodResponse = await http.post(
                        '${Constants.APILINK}GetPoductByProvider.php',
                        body: {'pid': data[index].pid});
                    setState(() {
                      product_list = jsonDecode(prodResponse.body);
                    });
                    print(product_list.length);
                    if (product_list.length > 0)
                      new GridView.builder(
                          itemCount: product_list.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return new SingleProduct(
                              prod_name: product_list[index]['product_name'],
                              prod_image: product_list[index]['pic'],
                              prod_price: product_list[index]['price'],
                              prod_details: product_list[index]['details'],
                              prod_id: product_list[index]['product_id'],
                            );
                          });
                    else
                      ToastUtils.showCustomToast(
                          context, "برای این فروشگاه محصولی ثبت نشده است");
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          Constants.providersimage + data[index].pic,
                        ),
                        AutoSizeText(
                          data[index].name,
                          style: TextStyle(fontSize: 16, fontFamily: 'IRASans'),
                          maxLines: 1,
                          maxFontSize: 16,
                          minFontSize: 10,
                        )
                      ]),
                )),
          );
        });
  }

  Widget build(BuildContext context) {

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: theme.MYColors.darkblue,
          title: null,
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    var route = new MaterialPageRoute(
                        builder: (BuildContext context) => new Cart(
                          usershopcart: shopcartlist,
                          shopingamount: shopingamount,
                          fullprice:fullprice,
                        )
                    );
                    Navigator.of(context).push(route);
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
                            right:5 ,
                            child: new Center(
                              child: new Text(
                                PersianNumbers.toPersian(amont.toString()),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  }),
            )

            //
            // for Cart Icon

          ],
        ),
        drawer: new SideDrawer(),
        body: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 5.0,
            ),
            //padding
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'فروشگاه ها ',
                style: TextStyle(
                    fontFamily: 'IRANSans',
                    fontSize: 18,
                    color: theme.MYColors.priceColor),
              ),
            ),

            //Horizontal ListView
            new Container(
              height: 120.0,
              child: FutureBuilder<List<providers>>(
                future: fetchasnaf(widget.aid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    asnaf = snapshot.data;
                    return providerlistview(asnaf);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return new Loading();
                },
              ),
            ),
            new Container(
              height: 2,
              width: 1,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            ),
            //padding
            new Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8.0),
              child: new Text(
                'محصولات',
                style: TextStyle(fontFamily: 'IRASans', fontSize: 18),
              ),
            ),
//
//            //making shopping products
            new Container(
              height: 400.0,
              child: new GridView.builder(
                  itemCount: product_list.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new SingleProduct(
                      prod_name: product_list[index]['product_name'],
                      prod_image: product_list[index]['pic'],
                      prod_price: product_list[index]['price'],
                      prod_details: product_list[index]['details'],
                      prod_id: product_list[index]['product_id'],
                    );
                  }),
            )
//
          ],
        ),
      ),
    );
  }
}

Future<List<providers>> fetchasnaf(id) async {
  final ListAPIUrl = '${Constants.providersapi}AllProviders.php';
  final response = await http.post(ListAPIUrl, body: {'senf_id': id});

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((senf) => new providers.fromJson(senf)).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}
