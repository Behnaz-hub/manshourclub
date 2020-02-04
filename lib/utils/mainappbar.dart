import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';

class mainappbar extends StatelessWidget implements PreferredSizeWidget{

  final title;

  const mainappbar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   AppBar(
      backgroundColor: Colors.green[800],
      title: new Text(title),
      actions: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null),

        //
        // for Cart Icon
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
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}