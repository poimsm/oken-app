import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dummy/questions.dart';

class QuizProvider with ChangeNotifier {
  List<String> _questions = [];

  bool _loading = false;
  bool _isStarted = true;
  bool _showActionSheet = false;
  bool _isTalking = false;
  bool _showChallengingWords = true;

  void loadQuestions(type) {
    _questions = Questions().get(type);
  }

  void toggleWords() {
    _showChallengingWords = !_showChallengingWords;
    notifyListeners();
  }

  enableTalking() {
    if (_isTalking) return;
    _isTalking = true;
    notifyListeners();
  }

  disableTalking() {
    if (!_isTalking) return;
    _isTalking = false;
    notifyListeners();
  }

  get isTalking => _isTalking;

  get showChallengingWords => _showChallengingWords;

  get isStarted => _isStarted;

  get showActionSheet => _showActionSheet;

  get allQuestions => _questions;

  get question => _questions[Random().nextInt(20)];

  get loading => _loading;

  String oneQuestion(index) {
    return _questions[index];
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
    this._questions.shuffle();
  }

  void start() {
    this._isStarted = true;
    notifyListeners();
  }
}
