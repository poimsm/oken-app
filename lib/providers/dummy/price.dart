import 'package:oken/constants/paid_actions.dart';

Map _data = {
  PaidActions.swipeQuiz: 0.25,
  PaidActions.swipePhoto: 0.3,
  PaidActions.swipeRoutine: 0.4,
  PaidActions.showLabels: 1,
  PaidActions.showPowerWord: 1,
  PaidActions.showWordMeaning: 1,
  PaidActions.unlockChapter: 5,
};

class Price {
  get data => _data;
}
