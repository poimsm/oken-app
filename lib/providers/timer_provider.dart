import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer timeController;
  int _time = 0;

  get time => _time;

  void start() {
    if (this.timeController != null) return;
    timeController = Timer.periodic(Duration(seconds: 1), (timer) {
      _time += 1;
      notifyListeners();
    });
  }

  void stop() {
    if (timeController == null) return;
    _time = 0;
    timeController.cancel();
    timeController = null;
  }
}
