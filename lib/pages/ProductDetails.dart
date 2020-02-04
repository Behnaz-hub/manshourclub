import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/styles/theme.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:html/parser.dart';


class ProductDetails extends StatefulWidget {

  final productDetailsName;
  final productDetailsImage;
  final productDetailsNewPrice;
  final productDetailsdetails;

  ProductDetails({
    this.productDetailsName,
    this.productDetailsImage,
    this.productDetailsdetails,
    this.productDetailsNewPrice,
  });

  @override
  _ProductDetailsState createState() => new  _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  String _parseHtmlString(String htmlString) {

    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
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
              new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Cart(),
                      ),
                    );
                  }),
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
                        child:new Image.network( Constants.productimages+widget.productDetailsImage)
                    ),
                  ),
                  footer: new Container(
                    color: Colors.white70,
                    child: new ListTile(
                      leading: new Text("${widget.productDetailsName}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.cyan
                        ),
                      ),
                      title: new Padding(
                        padding: const EdgeInsets.only(left:16.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                                child:new Text(
                                  "\$${widget.productDetailsName}",
                                  style: CustomTextStyle.drawertext(context),)
                            ),
                            new Expanded(
                              child:new Text(
                                "\$${widget.productDetailsNewPrice}",
                                style: new TextStyle(
                                    color: Colors.deepOrange
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

                  /////////////
                  //////////////
                  //////////
                  //for quantity

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

              //   """"""""""""""""""""""""           """"""""""""""""""""""""""""
              //   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
              new Padding(
                padding: const EdgeInsets.only(left:64.0,right: 64.0,top: 16.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new MaterialButton(
                          child: new Text("Buy Now"),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: (){}
                      ),
                    ),
                    new IconButton(
                        color: Colors.deepPurple,
                        icon:new Icon(Icons.add_shopping_cart),
                        onPressed: (){}
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

                  data:
                  _parseHtmlString(widget.productDetailsdetails),
                  padding: EdgeInsets.all(8.0),

                ),
              ),
//            new Padding(
//              padding: const EdgeInsets.only(left:16.0,top: 8.0),
//              child: new Text(
//                'Similar Products',
//                style: new TextStyle(
//                  color: Colors.black54,
//                  fontSize: 16.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//            ),
//            new Container(
//              height: 400.0,
//              child:new Products() ,
//            ),
            ],
          ),
        ),
      )

    );
  }

}
