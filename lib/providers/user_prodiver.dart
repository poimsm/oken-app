import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/user.dart';

class CoinProvider with ChangeNotifier {
  Map _user = User().data;

  get user => _user;
}
