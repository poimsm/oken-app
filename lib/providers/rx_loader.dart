import 'package:rxdart/rxdart.dart';

class RxLoader {
  static final RxLoader _singleton = RxLoader._internal();

  factory RxLoader() {
    return _singleton;
  }

  RxLoader._internal();

  final BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>.seeded(false);

  get isLoading => _isLoading.stream;

  start() {
    _isLoading.add(true);
  }

  stop() {
    _isLoading.add(false);
  }

  void onDispose() {
    _isLoading.add(false);
  }
}
