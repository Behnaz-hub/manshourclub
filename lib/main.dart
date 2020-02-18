import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:manshourclub/cart/my_cart.dart';
import 'package:manshourclub/categories/HorizontalList.dart';
import 'package:manshourclub/categories/Products.dart';
import 'package:load/load.dart';
import 'package:manshourclub/styles/loading.dart';
import 'package:manshourclub/utils/mainappbar.dart';
import 'package:manshourclub/utils/sideDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {

    runApp(
    LoadingProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          // add this
          textDirection: TextDirection.rtl, // set this property

          child: SplashScreen(),
        ),
        routes: <String, WidgetBuilder> {
          '/app': (BuildContext context) => new MyApp(),
          '/login': (BuildContext context) => new LoginPage(),
        },
      ),

      loadingWidgetBuilder: (ctx, data) {
        return new Loading();
      },
    ),
  );
}
Future<bool> checkUserAndNavigate(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final islogin = prefs.getBool('islogin') ?? false;
  return islogin;
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkUserAndNavigate(context).then((res) {
      if (res == true) {
        Navigator.pushReplacementNamed(context, '/app');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return new Scaffold(
      body: new Card(
          child: new Center(
            child:
            new Text('Loading.....',
                style: new TextStyle(fontSize: 24.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo)
            ),
          )
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  final aid;


  MyApp({
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
        home: _MyApp(

        ),
      ),
    );
  }

}


class _MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<_MyApp> {

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
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('آیا مطمئن هستید؟'),
        content: new Text('آیا میخواهید از برنامه خارج شوید؟'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('نه'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('بله'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new WillPopScope(
        onWillPop: _onWillPop,
        child:new Directionality(
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
              padding: const EdgeInsets.only(top: 18.0, right: 8.0),
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
        ));
  }
}
