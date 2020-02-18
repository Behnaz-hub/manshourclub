import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:load/load.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manshourclub/styles/theme.dart' as Theme;
import 'package:manshourclub/pages/indication_painter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginMobileController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupMobileController = new TextEditingController();
  TextEditingController signupFNameController = new TextEditingController();
  TextEditingController signupLNameController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  RegExp mobileRegex =
      new RegExp(r'^[0][9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$');
  RegExp passwordRegex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');

  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  String code;
  String cid;
  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffoldKey,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.MYColors.loginGradientStart,
                        Theme.MYColors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 120.0),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value, Color color, int secs) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: "IRANSans"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: secs),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => toggleSignUp(1),
                child: Text(
                  "ثبت نام",
                  style: TextStyle(
                      color: right, fontSize: 16.0, fontFamily: "IRANSans"),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => toggleSignUp(2),
                child: Text(
                  "ورود",
                  style: TextStyle(
                      color: left, fontSize: 16.0, fontFamily: "IRANSans"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 550.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupFNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "نام",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
//                          focusNode: myFocusNodeName,
                          controller: signupLNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "نام خانوادگی",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          focusNode: myFocusNodeEmail,
                          controller: signupMobileController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.mobile_screen_share,
                              color: Colors.black,
                            ),
                            hintText: "شماره موبایل",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextSignup
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: "تکرار رمز عبور",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                _obscureTextSignupConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 520.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.MYColors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.MYColors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.MYColors.loginGradientEnd,
                        Theme.MYColors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.MYColors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "ثبت نام",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'IRANSans',
                        ),
                      ),
                    ),
                    onPressed: _onSignUpButtonPress),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 240.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginMobileController,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.mobile_screen_share,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "شماره موبایل",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "IRANSans",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "رمز عبور",
                            hintStyle: TextStyle(
                                fontFamily: "IRANSans", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.MYColors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.MYColors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.MYColors.loginGradientEnd,
                        Theme.MYColors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.MYColors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "ورود",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: "IRANSans"),
                      ),
                    ),
                    onPressed: _onSignInButtonPress),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "رمز عبور خود را فراموش کرده اید؟",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: 16.0,
                      fontFamily: "IRANSans"),
                )),
          )
        ],
      ),
    );
  }

  void _onSignInButtonPress() async {
    if (!mobileRegex.hasMatch(loginMobileController.text)) {
      showInSnackBar(
          'لطفا شماره موبایل خود را به حالت صحیح (با نوشتن صفر وارد نمایید',
          Colors.lightGreen,
          3);
    } else if (loginPasswordController.text == '') {
      showInSnackBar('لطفا رمز عبور خود را وارد نمایید', Colors.redAccent, 3);
    } else {
      showLoadingDialog();
      final paramDic = {
        "mobile": loginMobileController.text,
        "password": loginPasswordController.text,
      };
      final loginData = await http.post(
          "https://manshourclub.com/API/Customers/Login.php",
          body: paramDic);
      final response = jsonDecode(loginData.body);
      print("LOGIN RESPONSE: " +response.toString());
      if (response['status'] == 'login') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cid', response['customer']['cid']);
        prefs.setString('name',
            response['customer']['fname']);
        prefs.setString('lname',
           response['customer']['lname']);
        prefs.setString('email', response['customer']['email']);
        prefs.setString('mobile', response['customer']['mobile']);
        prefs.setString('image', response['customer']['avatar']);
        print("LOGIN image: " + response['customer']['avatar'].toString());
        prefs.setBool('islogin', true);
        var route = new MaterialPageRoute(
            builder: (BuildContext context) => new MyApp()
        );
        Navigator.of(context).push(route);
      } else {
        showInSnackBar('شماره موبایل یا رمز عبور وارد شده اشتباه است!',
            Colors.deepOrange, 4);
      }
      hideLoadingDialog();
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    }
  }

  void _onSignUpButtonPress() async {
    if (signupPasswordController.text != signupConfirmPasswordController.text) {
      showInSnackBar(
          'رمز عبور وارد شده با تکرار آن مطابقت ندارد', Colors.red, 3);
      return;
    }
    if (!passwordRegex.hasMatch(signupPasswordController.text)) {
      showInSnackBar(
          'رمز عبور وارد شده از امنیت کافی برخوردار نیست، رمز عبور شما باید حداقل شامل یک حرف انگلیسی بزرگ، یک حرف انگلیسی کوچک، یک نماد و حداقل 8 رقم باشد.',
          Colors.amber,
          7);
      return;
    }
    if (!mobileRegex.hasMatch(signupMobileController.text)) {
      showInSnackBar(
          'لطفا شماره موبایل خود را به حالت صحیح (با نوشتن صفر وارد نماایید',
          Colors.lightGreen,
          3);
      return;
    }
    final paramDic = {
      "mobile": signupMobileController.text,
      "fname": signupFNameController.text,
      "lname": signupLNameController.text,
      "password": signupPasswordController.text,
      "type": '1',
    };
    final signupData = await http.post(
        "https://manshourclub.com/API/Customers/Register.php",
        body: paramDic);
    final response = jsonDecode(signupData.body);
    if (response['status'] == 'login') {
      code = response['code'];
      _displayDialog(context);
    } else if (response['status'] == 'login') {
      showInSnackBar('شماره موبایل وارد شده قبلا در سیستم ثبت شده است!',
          Colors.deepOrangeAccent, 3);
    } else {
      showInSnackBar('خطایی بوجود آمد، دوباره تلاش کنید', Colors.red, 3);
    }
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void toggleSignUp(type) {
    if (type == 1) {
      _pageController?.animateToPage(1,
          duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    } else {
      _pageController?.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    }
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.tealAccent,
            content: new Directionality(
              textDirection: TextDirection.rtl,
              child: new TextFormField(
                controller: _codeController,
                decoration: new InputDecoration(
                  focusColor: Colors.redAccent,
                  labelText: "کد تایید",
                  labelStyle: TextStyle(fontFamily: 'IRANSans', fontSize: 12.0),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    if (code == _codeController.text) {
                      final checkCode = await http.post(
                          "https://manshourclub.com/API/Customers/Register.php",
                          body: {'cid': cid, 'type': 2});
                      if (checkCode.body == '1') {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('cid', cid);
                        prefs.setString(
                            'name', signupFNameController.text );
                        prefs.setString(
                            'lname', signupLNameController.text);
                        prefs.setString('mobile', signupMobileController.text);
                        Navigator.of(context).pop();
                      } else {
                        showInSnackBar('فعالسازی با خطا مواجه شد!',
                            Colors.deepOrangeAccent, 5);
                      }
                    } else {
                      showInSnackBar('کد تایید وارد شده درست نمیباشد!',
                          Colors.deepOrangeAccent, 5);
                    }
                  },
                  child: Text(
                    "تایید",
                    style: TextStyle(fontFamily: 'IRANSans'),
                  ))
            ],
          );
        });
  }
}
