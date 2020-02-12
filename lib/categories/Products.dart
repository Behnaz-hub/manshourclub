import 'package:flutter/material.dart';
import 'package:manshourclub/pages/ProductDetails.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:manshourclub/styles/constants.dart' as Constants;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => new _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [];

  void _getBestProducts() async {
    final prodResponse = await http.get(Constants.APILINK + "AllProducts.php");
    setState(() {
      product_list = jsonDecode(prodResponse.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getBestProducts();
    return new GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new SingleProduct(
            prod_name: product_list[index]['product_name'],
            prod_image: product_list[index]['pic'],
            prod_price: product_list[index]['price'],
            prod_details: product_list[index]['details'],
            prod_id: product_list[index]['product_id'],

          );

        }
        );
  }
}

class SingleProduct extends StatelessWidget {
  final prod_name;
  final prod_image;
  final prod_price;
  final prod_details;
  final prod_id;

  SingleProduct({
    this.prod_name,
    this.prod_image,
    this.prod_price,
    this.prod_details,
    this.prod_id,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 8.0, right: 4.0),
      child: new Card(
        elevation: 6.0,
        color: Colors.cyanAccent,
        child: new Hero(
            tag: prod_name,
            child: new Material(
              child: new InkWell(
                onTap: () {
                  //We are passing the values from one activity to another activity
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new ProductDetails(
                            productDetailsName: prod_name,
                            productDetailsImage: prod_image,
                            productDetailsNewPrice: prod_price,
                            productDetailsdetails: prod_details,
                            productId: prod_id,
                          ));
                  Navigator.of(context).push(route);
                },
                child: new GridTile(
                  footer: new Container(
                    color: Theme.MYColors.productBackGround,
                    child: new ListTile(
                        leading: new Text(
                          prod_name,
                          style: new TextStyle(
                              fontFamily: 'IRANSans',
                              fontSize: 14,
                              color: Theme.MYColors.productNameColor),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Text(
                              "$prod_price تومان ",
                              style: new TextStyle(
                                  color: Theme.MYColors.priceColor,
                                  fontFamily: 'IRANSans',
                                  fontSize: 14),
                            ),
                          ],
                        )),
                  ),
                  child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FadeInImage.assetNetwork(
                          placeholder: 'images/shop1.jpg',
                          image: Constants.productimages + prod_image)),
                ),
              ),
            )
        ),
      ),
    );
  }
}
