import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manshourclub/cart/my_cart.dart';
import 'package:manshourclub/utils/appbarfunc.dart';
import 'package:manshourclub/utils/sideDrawer.dart';
import 'package:provider/provider.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<MyCart>(
      create: (context) => MyCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "kl",
        home: _ProfilePage(),
      ),
    );
  }
}

class _ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return MyProfile();
  }
}

class MyProfile extends State<_ProfilePage> {
  String cid, name, lname, mobile;

  TextEditingController NameController = new TextEditingController();

  final FocusNode NameNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofileinfo();
  }

  getprofileinfo() async {
    SharedPreferences sharepre = await SharedPreferences.getInstance();
    cid = sharepre.getString("cid");
    name = sharepre.getString("name");
    lname = sharepre.getString("lname");
    mobile = sharepre.getString("mobile");
    setState(() {
      cid;
      name;
      lname;
      mobile;
    });
  }

  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        appBar: new appbar(
          title: '',
          totalProduct: '',
        ),
        drawer: new SideDrawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(8),
          child: Container(
            child: new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        focusNode: NameNode,
                        controller: NameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.CustomTextStyle.drawertext(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(gapPadding: 2.0),
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: name,
                          hintStyle:
                          TextStyle(fontFamily: "IRANSans", fontSize: 16.0),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        focusNode: NameNode,
                        controller: NameController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.CustomTextStyle.drawertext(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(gapPadding: 2.0),
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: lname,
                          hintStyle:
                          TextStyle(fontFamily: "IRANSans", fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),),
                new Padding(padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          focusNode: NameNode,
                          controller: NameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: Theme.CustomTextStyle.drawertext(context),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 2.0),
                            icon: Icon(
                              Icons.mobile_screen_share,
                              color: Colors.black,
                            ),
                            hintText: mobile,
                            hintStyle:
                            TextStyle(fontFamily: "IRANSans", fontSize: 16.0),
                          ),
                        ),
                      ),

                    ],
                  ),),
                new Padding(padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          focusNode: NameNode,
                          controller: NameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: Theme.CustomTextStyle.drawertext(context),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 2.0),
                            icon: Icon(
                              Icons.mood,
                              color: Colors.black,
                            ),
                            hintText: 'کد ملی',
                            hintStyle:
                            TextStyle(fontFamily: "IRANSans", fontSize: 16.0),
                          ),
                        ),
                      ),

                    ],
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
