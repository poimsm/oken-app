import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/chat.dart';

class WordProvider with ChangeNotifier {
  
  List<String> _wordList = Chat().words();
  bool _loading = false;


  get firstThreeWords {
    return _wordList.take(3).toList();
  }

  get wordlistAll {
    return _wordList.take(8).toList();
  }

  get loading {
    return _loading;
  }

  void startLoading() {
    _loading = true;
    Timer(Duration(milliseconds: 500), () {
      _loading = false;
      notifyListeners();
    });
  }

  void shuffle() {
    startLoading();
    this._wordList.shuffle();
    notifyListeners();
  }

  void addWord( String word ) {
    this._wordList.add('word');
    notifyListeners();
  }
}