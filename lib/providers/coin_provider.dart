import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/price.dart';
import 'package:oken/providers/dummy/free_tire.dart';
import 'package:oken/providers/dummy/user.dart';

class CoinProvider with ChangeNotifier {
  Map _freeTireModel = FreeTire().data;
  Map _priceModel = Price().data;
  Map _userModel = User().data;

  get totalCoins => _userModel['coins'].toStringAsFixed(2);

  bool charge(type) {
    bool flag = true;
    if (!_freeTire(type)) {
      flag = _use(_priceModel[type]);
    }
    notifyListeners();
    return flag;
  }

  int hola = 0;

  _freeTire(type) {
    hola++;
    if (_freeTireModel[type] == 0) return false;
    _freeTireModel[type]--;
    return true;
  }

  _use(val) {
    if (_userModel['coins'] > val) {
      _userModel['coins'] -= val;
      return true;
    }

    _userModel['coins'] = 0;
    return false;
  }

  add(val) {
    _userModel['coins'] += val;
    notifyListeners();
  }
}
