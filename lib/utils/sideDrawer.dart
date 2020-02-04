import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/styles/theme.dart';

import '../login.dart';
import '../main.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new SizedBox(
      width: MediaQuery.of(context).size.width * 0.6, //20.0,
      child: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('نام کاربری'),
              accountEmail: new Text('ایمیل'),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: new Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            new InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new MyApp()));
              },
              child: new ListTile(
                title: new Text(
                  'صفحه اصلی',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.home,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                onTap: () => {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage()))
                },
                title: new Text(
                  'ورود/ثبت نام',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.account_circle,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text(
                  'سفارشات من',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.shopping_basket,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Cart(),
                      ));
                },
                title: new Text(
                  'سبد خرید',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.shopping_cart,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text(
                  'مورد علاقه ها',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.favorite,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            new Divider(
              color: Colors.red,
              height: 4.0,
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text(
                  'قوانین و مقررات',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.help,
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
