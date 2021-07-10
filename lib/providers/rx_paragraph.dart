import 'package:rxdart/rxdart.dart';

class RxParagraph {
  int index = 0;

  List<BehaviorSubject> _obsList = [];

  RxParagraph({this.index});

  generateObsList(length) {
    for (var i = 0; i < length; i++) {
      // _obsList.add(BehaviorSubject<bool>.seeded(i <= index));
      _obsList.add(BehaviorSubject<bool>.seeded(true));
    }
  }

  scrollHandler(currentPosition, maxExtent) {
    // if (currentPosition == maxExtent && index < _obsList.length - 1) {
    //   index++;
    //   _obsList[index].sink.add(true);
    // }
  }

  getObs(i) => _obsList[i];

  toggleObs(i) {
    return _obsList[i].sink.add(true);
  }

  void dispose() {
    for (var i = 0; i < _obsList.length; i++) {
      _obsList[i].close();
    }
    _obsList = [];
    index = 0;
  }
}
