import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/imgs.dart';

class PhotoProvider with ChangeNotifier {

  bool _showButtons = true;
  bool _showHints = false;
  bool _isTalking = false;

  int _index = 0;
  String _imgUrl;

  List<String> _imgs = [];

  List<String> _imgsHint = [];

  void loadImgs(pack) {
    List imgs = ImgHint().get(pack);
    _index = 0;
    _imgs = imgs[0];
    _imgsHint = imgs[1];
  }

  void setFistImg() {
    _imgUrl = _imgs[_index];
  }

  get isTalking => _isTalking;

  get imgUrl => _imgUrl;

  get index => _index;

  get showHints => _showHints;
  
  get showButtons => _showButtons;

  void toggleShowButtons() {
    _showButtons = !_showButtons;
    notifyListeners();
  }

  void toggleHints() {
    _showHints = !_showHints;
    _imgUrl = _showHints ? _imgsHint[index] : _imgs[index];
    notifyListeners();
  }

  void toggleIsTalking() {
    _isTalking = !_isTalking;
    notifyListeners();
  }

  void increaseIndex() {
    if (index == 7) return;
    _index++;
    _imgUrl = _imgs[_index];
    notifyListeners();
  }

  void decreaseIndex() {
    if (index == 0) return;
    _index--;
    _imgUrl = _imgs[_index];
    notifyListeners();
  }
}
