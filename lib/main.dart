import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/categories/HorizontalList.dart';
import 'package:manshourclub/categories/Products.dart';
import 'package:load/load.dart';
import 'package:manshourclub/styles/loading.dart';
import 'package:manshourclub/utils/mainappbar.dart';
import 'package:manshourclub/utils/sideDrawer.dart';

void main() {

  runApp(
    LoadingProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          // add this
          textDirection: TextDirection.rtl, // set this property

          child: MyApp(),
        ),
      ),
      loadingWidgetBuilder: (ctx, data) {
        return new Loading();
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<MyApp> {
  Widget image_carousel = new Container(
    height: 225.0,
    child: new Carousel(
      overlayShadow: false,
      borderRadius: true,
      boxFit: BoxFit.cover,
      autoplay: false,
      dotSize: 4.0,
      indicatorBgPadding: 8.0,
      images: [
        new AssetImage('images/shop1.jpg'),
        new AssetImage('images/shop2.png'),
        new AssetImage('images/shop3.png'),
        new AssetImage('images/shop4.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: new Duration(microseconds: 1000),
    ),
  );

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new mainappbar(title: "منشور",),
        drawer: new SideDrawer(),
        body: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 5.0,
            ),

            //Image Carousel
            image_carousel,

            //padding
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                'اصناف ',
                style: TextStyle(fontFamily: 'IRANSans', fontSize: 18),
              ),
            ),

            //Horizontal ListView
            new Container(
              height: 100.0,
              child: new HorizontalList(),
            ),

            //padding
            new Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8.0),
              child: new Text(
                'محصولات پرطرفدار',
                style: TextStyle(fontFamily: 'IRASans', fontSize: 18),
              ),
            ),
//
//            //making shopping products
            new Container(
              padding: const EdgeInsets.only(top: 5 ,bottom: 5, ),
              margin: const EdgeInsets.only(bottom: 5),
              height: MediaQuery.of(context).size.height*0.40,
              child: new Products(),
            )
//
          ],
        ),
      ),
    );
  }
}
