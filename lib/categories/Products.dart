import 'package:flutter/material.dart';
import 'package:manshourclub/pages/ProductDetails.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => new _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [];

  void _getBestProducts() async {
    final prodResponse = await http
        .get('https://manshourclub.com/API/Providers/Products/AllProducts.php');
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
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final prod_name;
  final prod_image;
  final prod_price;

  SingleProduct({
    this.prod_name,
    this.prod_image,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 4.0),
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
                              fontSize: 10,
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
                                  fontSize: 10),
                            ),
                          ],
                        )),
                  ),
                  child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FadeInImage.assetNetwork(
                          placeholder: 'http://www.miniaccountapp.com/wp-content/uploads/2018/01/Products-And-Services.jpg',
                          image: 'https://manshourclub.com/admin/images/products/$prod_image'
                      )
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
