import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/categories/HorizontalList.dart';
import 'package:manshourclub/categories/Products.dart';
import 'package:manshourclub/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality( // add this
        textDirection: TextDirection.rtl, // set this property

        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<MyApp>{

  Widget image_carousel=new Container(
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

    return new Directionality(
      textDirection: TextDirection.rtl,
      child:
       new Scaffold(
      appBar: new AppBar(
      backgroundColor: Colors.deepPurple,
      title: new Text('منشور'),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.search,color: Colors.white,),
            onPressed: null
        ),

        //
        // for Cart Icon
        new IconButton(
            icon: new Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context)=>new Cart(),
                ),
              );
            }
        ),
      ],
    ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('Harsh Chaurasiya'),
                accountEmail: new Text('harshchaurasiya6768@gmail.com'),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child: new Icon(Icons.person,color: Colors.white,),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  title: new Text('Home',style: new TextStyle(color:Colors.deepPurple)),
                  leading: new Icon(Icons.home,color: Colors.lightBlue,),
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  onTap: () => {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new LoginPage()
                      )
                    )
                  },
                  title: new Text('Account',style: new TextStyle(color:Colors.deepPurple)),
                  leading: new Icon(Icons.account_circle,color:Colors.lightBlue ,),
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  title: new Text('My Orders',style: new TextStyle(color: Colors.deepPurple)),
                  leading: new Icon(Icons.shopping_basket,color: Colors.lightBlue,),
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  onTap:(){
                    Navigator.push(context, new MaterialPageRoute(
                      builder:(BuildContext context)=>new Cart(),
                    )
                    );
                  } ,
                  title: new Text('Cart',style: new TextStyle(color:Colors.deepPurple)),
                  leading: new Icon(Icons.shopping_cart,color: Colors.lightBlue,),
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  title: new Text('Favourites',style: new TextStyle(color:Colors.deepPurple)),
                  leading: new Icon(Icons.favorite,color: Colors.lightBlue,),
                ),
              ),
              new Divider(
                color: Colors.red,
                height: 4.0,
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  title: new Text('Settings',style: new TextStyle(color: Colors.deepPurple)),
                  leading: new Icon(Icons.settings,color: Colors.lightBlue,),
                ),
              ),
              new InkWell(
                onTap: (){},
                child: new ListTile(
                  title: new Text('Help',style: new TextStyle(color:Colors.deepPurple),),
                  leading: new Icon(Icons.help,color: Colors.lightBlue,),
                ),
              ),
            ],
          ),
        ),
        body: new ListView(
          children: <Widget>[
            new SizedBox(height: 5.0,),

            //Image Carousel
            image_carousel,

            //padding
            new Padding(
              padding:const EdgeInsets.all(8.0),
              child: new Text('Categories',),
            ),

            //Horizontal ListView
            new HorizontalList(),

            //padding
            new Padding(
              padding:const EdgeInsets.only(top:18.0,left:8.0),
              child: new Text('Recent Products',),
            ),

            //making shopping products
            new Container(
              height: 400.0,
              child: new Products(),
            )

          ],
        ),
      ),
    );
  }
}


