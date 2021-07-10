import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  bool _changeColor = false;
  bool _changeColorAux = false;

  bool _showSynomToast = false;
  Map _word;

  bool _showQuestionBox = false;


  get showQuestionBox => _showQuestionBox;
  
  set showQuestionBox(val) => _showQuestionBox = val;

  get changeColor => _changeColor;

  get showSynomToast => _showSynomToast;

  get word => _word;

  void setSynomToast(bool flag, Map word) {
    _showSynomToast = flag;
    _word = word;
    notifyListeners();
  }

  void changeColorHandler(currentScroll) {
    if (currentScroll > 330) {
      if (_changeColorAux) {
        _changeColor = true;
        _changeColorAux = false;
        notifyListeners();
      }
    }
    if (currentScroll < 330 && !_changeColorAux) {
      _changeColor = false;
      _changeColorAux = true;
      notifyListeners();
    }
  }

  void resetChangeColor() {
    _changeColor = false;
    _changeColorAux = false;
  }
}
