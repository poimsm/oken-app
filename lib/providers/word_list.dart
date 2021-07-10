import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oken/providers/dummy/chat.dart';

class WordList with ChangeNotifier {
  
  List<String> _wordList = Chat().words();

  bool _loading = false;
  bool _isStarted = true;
  bool _showActionSheet = false;
  Timer timeController;
  int _time = 0;

  get time {
    return _time;
  }

  void startTimer() {
    if (this.timeController != null) return;
    timeController = Timer.periodic(Duration(seconds: 1), (timer) {
      _time += 1;
      notifyListeners();
      print('TIMER');
    });
  }

  void stopTimer() {
    if (timeController == null) return;
    timeController.cancel();
    timeController = null;
  }

  get wordlist {
    return _wordList.take(3).toList();
  }
  get isStarted {
    return _isStarted;
  }
  get wordlistAll {
    return _wordList.take(8).toList();
  }
  get showActionSheet {
    return _showActionSheet;
  }
 
  get loading {
    return _loading;
  }

  void togleActionSheet() {
    Timer(Duration(milliseconds: 50), () {
      _showActionSheet = !_showActionSheet;
      notifyListeners();      
    });
    
  }

  void startLoading() {
    _loading = true;
    Timer(Duration(milliseconds: 500), () {
      _loading = false;
      notifyListeners();
    });
  }

  void shuffle() {
    this._wordList.shuffle();
    startLoading();
    notifyListeners();
  }

  void addWord( String word ) {
    this._wordList.add('word');
    notifyListeners();
  }

  void start() {
    this._isStarted =  true;
    notifyListeners();
  }
}