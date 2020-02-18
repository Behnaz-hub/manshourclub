import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manshourclub/styles/constants.dart' as Constants;
import 'package:http/http.dart' as http;


class MyCart with ChangeNotifier {

  Map<int , int> _cart = {};
  String TAG = "MyCart";

  Map<int , int> get cart => _cart;
  var shopcartlist = {};
  Future<void> addToCart(index) async {

    if (_cart.containsKey(index)){
//      _cart[index] +=1;
      print(TAG + " :index: " +index.toString());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final cid = prefs.getString('cid') ?? "1";
      final param = {
        "product_id": index.toString(),
        "cid": cid,
        "type": "add",
      };
      final cartData = await http.post(
          "${Constants.APILINK}ShopCart.php",
          body: param);

      final response =
      jsonDecode(cartData.body);
      print(' response::' + response.toString());
      if (response['status'] == 'success') {
        print('yes added!');

      } else {
        print('محصول اضافه نشد');
      }

    }else{
      _cart[index] =1;
    }
    notifyListeners();
  }

  Future<void> removeFromCart(index) async {

    print(TAG + " :index: " +index.toString());

    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    final cid = prefs.getString('cid') ?? "1";
    final param = {
      "product_id": index.toString(),
      "cid": cid,
      "type": "remove",
    };
    final cartData = await http.post(
        "${Constants.APILINK}ShopCart.php",
        body: param);

    final response =
    jsonDecode(cartData.body);
    print(' response::' + response.toString());
    if (response['status'] == 'success') {
      if(int.parse(response['count'])>1)
      print('yes removed!');
      else {
        print('last item!');
        _cart.remove(index);
        notifyListeners();
      }
    } else if(response['status'] == 'no cart'){
      print('item removed!');
      _cart.remove(index);
      notifyListeners();
    }

     notifyListeners();
  }

  void clear(index){
    if(_cart.containsKey(index)){
      _cart.remove(index);
      notifyListeners();
    }
  }
}