import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';

class AudioProvider with ChangeNotifier {
  Record _record = Record();
  AudioPlayer _player;
  bool _hasNewAudioToBeSaved = false;
  bool _isSaving = false;
  bool _isKeyboardVisible = false;
  bool _isPlaying = false;
  List _temAudioPaths = [];
  List _userAudios = [];
  Timer _timeController;
  int _time;

  get userAudios => _userAudios;
  get isSaving => _isSaving;
  get hasNewAudioToBeSaved => _hasNewAudioToBeSaved;
  get isKeyboardVisible => _isKeyboardVisible;
  get isPlaying => _isPlaying;

  set isKeyboardVisible(bool val) {
    _isKeyboardVisible = val;
    notifyListeners();
  }

  set isSaving(bool val) {
    _isSaving = val;
    notifyListeners();
  }

  set hasNewAudioToBeSaved(bool val) {
    _hasNewAudioToBeSaved = val;
    notifyListeners();
  }

  void reset() {
    _hasNewAudioToBeSaved = false;
    _isSaving = false;
    _time = 0;
    if (_timeController != null) _timeController.cancel();
  }

  Future<bool> startRecording() async {
    bool hasPermission = await _requestPermission(Permission.microphone);
    if (!hasPermission) return false;

    Directory directory = await getTemporaryDirectory();
    String name = Random().nextInt(100000).toString();
    _timeController = Timer.periodic(Duration(seconds: 1), (timer) {
      _time += 1;
    });
    _temAudioPaths.add('${directory.path}/$name');
    _record.start(path: '${directory.path}/$name', encoder: AudioEncoder.AAC);
    return true;
  }

  bool saveAudio(title, module) {
    if (_userAudios.length >= 5) {
      reset();
      return false;
    }

    var dt = DateTime.now();
    var newFormat = DateFormat('yy-MM-dd Hm');
    String updatedDt = newFormat.format(dt);

    _userAudios.add({
      'path': _temAudioPaths[_temAudioPaths.length - 1],
      'date': updatedDt,
      'title': title,
      'type': module,
      'length': _time > 59 ? '01:00' : '00:0$_time',
      'isPlaying': false,
    });

    reset();
    notifyListeners();
    return true;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<void> stopRecording() async {
    if (_record == null) return;

    _hasNewAudioToBeSaved = true;
    _timeController.cancel();
    _record.stop();

    notifyListeners();
  }

  Future<void> play({isAudioList: false, index}) async {
    String path = isAudioList
        ? _userAudios[index]['path']
        : _temAudioPaths[_temAudioPaths.length - 1];

    if (!(await File(path).exists())) return;

    isAudioList ? _userAudios[index]['isPlaying'] = true : _isPlaying = true;
    notifyListeners();

    _player = AudioPlayer();
    await _player.setFilePath(path);
    await _player.play();

    isAudioList ? _userAudios[index]['isPlaying'] = false : _isPlaying = false;
    notifyListeners();
  }

  void onDispose() {
    if (_player != null) {
      _player.dispose();
    }
    if (_record != null) {
      _record.stop();
    }
  }
}
