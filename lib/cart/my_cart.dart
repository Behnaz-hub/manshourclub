import 'package:flutter/cupertino.dart';

class MyCart with ChangeNotifier {

  Map<int , int> _cart = {};

  Map<int , int> get cart => _cart;

  void addToCart(index) {

    if (_cart.containsKey(index)){
      _cart[index] +=1;
    }else{
      _cart[index] =1;
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