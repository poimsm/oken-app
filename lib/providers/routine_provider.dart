import 'package:flutter/material.dart';
import 'dart:async';
import 'dummy/routine.dart';

class RoutineProvider with ChangeNotifier {  

  int _index = 0;
  bool _loading = false;
  bool _isTalking = false;
  bool _showToast = false;

  List _questions = [];

  void setQuestions(type) {
    _questions = ThemedQuiz().get(type);
  }

  get question => _questions[_index];

  get loading => _loading;

  get isTalking =>  _isTalking;

  get showToast => _showToast;

  set showToast(bool val) {
    _showToast = val;
    notifyListeners();
  }

  void startTalking() {
    if (_isTalking) return;  
    _isTalking = true;
    notifyListeners();
  }

  void stopTalking() {
    if (!_isTalking) return;  
    _isTalking = false;
    notifyListeners();
  }

  void increaseIndex() {
    startLoading();
    if (_index == _questions.length -1) {
      _index = 0;
      notifyListeners();
      return;
    }
    _index++;
    notifyListeners();
  }

  void startLoading() {
    _loading = true;
    Timer(Duration(milliseconds: 500), () {
      _loading = false;
      notifyListeners();
    });
  }

  void onDispose() {
    _index = 0;
  }
}