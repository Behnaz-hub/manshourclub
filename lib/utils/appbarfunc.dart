import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';

class appbar extends StatelessWidget implements PreferredSizeWidget {
  final title;

  const appbar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: new Text(title),
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
