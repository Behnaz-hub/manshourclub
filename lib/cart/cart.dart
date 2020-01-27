import 'package:flutter/material.dart';
import 'package:manshourclub/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => new _CartState();
}

class _CartState extends State<Cart>{
  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          leading: new IconButton(
              icon:new Icon(Icons.search),
              onPressed: (){

              }
          ),
          backgroundColor: Colors.deepPurple,
          title: new InkWell(
              onTap: (){
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder:(BuildContext context)=>new MyApp(),
                  ),
                );
              },
              child: new Text('Octivia',)
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.arrow_back,textDirection:TextDirection.ltr , color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pop();
                }
            ),
          ],
        ),
        bottomNavigationBar: new Container(
          color: Colors.white,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child:new Text(
                  'Total:\$230',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              new Expanded(
                child:new MaterialButton(
                    color: Colors.deepPurple,
                    splashColor: Colors.greenAccent,
                    child: new Text(
                      'Check Out',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize:16.0
                      ),
                    ),
                    onPressed:(){}
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}