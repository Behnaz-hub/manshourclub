import 'package:flutter/material.dart';
import 'package:manshourclub/cart/cart.dart';
import 'package:manshourclub/pages/ProfilePage.dart';
import 'package:manshourclub/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manshourclub/styles/theme.dart' as theme;
import 'package:manshourclub/styles/constants.dart' as Constants;

import '../login.dart';
import '../main.dart';

class SideDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SideDrawer();
  }
}
class _SideDrawer extends State<SideDrawer> {

  SharedPreferences prefs;

  TextEditingController name = TextEditingController();

  String name_str,mobile_str,image_str,imagename;

  @override
  void initState() {
    super.initState();
    getName();
    getMobile();
    getImage();
  }
  Future<String> getName() async {
    final SharedPreferences prefers = await SharedPreferences.getInstance();

    name_str = prefers.getString("name") + " " +prefers.getString("lname");
    print(name_str);
    setState(() {
      name_str;
    });
    return name_str;
  }

  Future<String> getMobile() async {
    final SharedPreferences prefers = await SharedPreferences.getInstance();

    mobile_str = prefers.getString("mobile");
    print(mobile_str);
    setState(() {
      mobile_str;
    });
    return mobile_str;
  }

  Future<String> getImage() async {
    final SharedPreferences prefers = await SharedPreferences.getInstance();

    image_str = prefers.getString("image");
    if(image_str == null) {
      imagename = 'images/icons/unknown.png';
    }
    else imagename = Constants.productimages + image_str ;
    setState(() {
      imagename;
    });
    return imagename;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new SizedBox(
      width: MediaQuery.of(context).size.width * 0.6, //20.0,
      child: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                  name_str.toString()
              ),
              accountEmail: new Text(
                  mobile_str.toString()
              ),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: theme.MYColors.green,
                  child: new FadeInImage.assetNetwork(
                    placeholder: 'images/icons/unknown.png',
                    image: imagename.toString(),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                color: theme.MYColors.darkblue,
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
                  color: theme.MYColors.green,
                ),
              ),
            ),
            new InkWell(
              onTap: () async {
                prefs = await SharedPreferences.getInstance();
                prefs.setString('cid',null);
                prefs.setString('name',null);
                prefs.setString('email',null);
                prefs.setString('mobile',null);
                prefs.setBool('islogin', false);

                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage()));
              },
              child: new ListTile(

                title: new Text(
                  'خروج از حساب کاربری',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.account_circle,
                  color: theme.MYColors.green,
                ),
              ),
            ),
            new InkWell(
              onTap: () async {

               Navigator.push(context,
               new MaterialPageRoute(
                   builder: (BuildContext context)=>new ProfilePage(),
               ));
                },
              child: new ListTile(

                title: new Text(
                  'پروفایل من',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.account_circle,
                  color: theme.MYColors.green,
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
                  color: theme.MYColors.green,
                ),
              ),
            ),
            new InkWell(
              onTap: () {},
              child: new ListTile(
                title: new Text(
                  'وام ها',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.favorite,
                  color: theme.MYColors.green,
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
                  color: theme.MYColors.green,
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
                  'محصولات قابل خرید',
                  style: CustomTextStyle.drawertext(context),
                ),
                leading: new Icon(
                  Icons.shopping_cart,
                  color: theme.MYColors.green,
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
                  color: theme.MYColors.green,
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
                  color: theme.MYColors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
