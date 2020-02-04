import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:manshourclub/models/providers.dart';
import 'package:manshourclub/styles/loading.dart';
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:http/http.dart' as http;
import 'package:manshourclub/utils/appbarfunc.dart';
import 'package:manshourclub/utils/sideDrawer.dart';
import 'package:manshourclub/utils/toast_utils.dart';
import 'Products.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;

class Providers extends StatefulWidget {
  final aid;

  Providers({this.aid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("id is;" + aid);

    return prov();
  }
}

class prov extends State<Providers> {
  List<providers> asnaf;
  var product_list = [];
  @override
  ListView providerlistview(data) {
    return ListView.builder(
        itemCount: asnaf.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(color: theme.MYColors.productBackGround),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () async {
                  print(data[index].pid);

                  final prodResponse = await http
                      .post('${Constants.APILINK}GetPoductByProvider.php', body: {'pid': data[index].pid});
                  setState(() {
                    product_list = jsonDecode(prodResponse.body);
                  }
                  );
                  print(product_list.length);
                  if(product_list.length >0 )
                    new GridView.builder(
                        itemCount: product_list.length,
                        gridDelegate:
                        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                        itemBuilder: (BuildContext context, int index) {

                          return new SingleProduct(
                            prod_name: product_list[index]['product_name'],
                            prod_image: product_list[index]['pic'],
                            prod_price: product_list[index]['price'],
                            prod_details: product_list[index]['details'],
                          );
                        }
                        );
                  else
                    ToastUtils.showCustomToast(context, "برای این فروشگاه محصولی ثبت نشده است");

                },
                child: Column(children: [
                  Image.network(
                   Constants.providersimage+data[index].pic,
                    width: 60,
                    height: 60,
                  ),
                  AutoSizeText(
                    data[index].name,
                    style: TextStyle(fontSize: 16, fontFamily: 'IRASans'),
                    maxLines: 1,
                    maxFontSize: 16,
                    minFontSize: 10,
                  )
                ]),
              )
          );
        });
  }


  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new appbar(title: "",),
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
                style: TextStyle(fontFamily: 'IRANSans', fontSize: 18 , color: theme.MYColors.priceColor),
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
            new Container(height: 2, width: 1, color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),),
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
              height:400.0,
              child: new GridView.builder(
                  itemCount: product_list.length,
                  gridDelegate:
                  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new SingleProduct(
                      prod_name: product_list[index]['product_name'],
                      prod_image: product_list[index]['pic'],
                      prod_price: product_list[index]['price'],
                      prod_details: product_list[index]['details'],
                    );
                  }
                  ),
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
