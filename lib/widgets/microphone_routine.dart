import 'dart:async';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/routine_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class MicrophoneRoutine extends StatefulWidget {
  MicrophoneRoutine({this.isBrown: false});
  final bool isBrown;

  @override
  _MicrophoneRoutineState createState() => _MicrophoneRoutineState();
}

class _MicrophoneRoutineState extends State<MicrophoneRoutine> {
  @override
  void dispose() {
    audioProvider.onDispose();
    super.dispose();
  }

  AudioProvider audioProvider;
  TimerProvider timerProvider;
  RoutineProvider routineProvider;
  Size size;
  Timer timer;
  int _time = 0;
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    audioProvider = Provider.of<AudioProvider>(context);
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
    size = MediaQuery.of(context).size;
    routineProvider = Provider.of<RoutineProvider>(context);

    void onStop() {
      if (!audioProvider.isTalking) return;
      timer.cancel();
      _time = 0;
      if (!isRecording) return;
      timerProvider.stop();
      audioProvider.stopRecording();
    }

    Future<void> onStart() async {
      timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        _time += 1;
        if (_time >= 120) onStop();
      });
      audioProvider.reset(setState: true);
      isRecording = await audioProvider.startRecording();
      if (!isRecording) return;
      timerProvider.start();
    }

    return InkWell(
      onTap: () {
        Timer(Duration(milliseconds: 1000), () {
          routineProvider.showToast = false;
        });
        routineProvider.showToast = true;
      },
      onLongPress: () => onStart(),
      child: Listener(
        onPointerUp: (e) => onStop(),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.isBrown
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.5)),
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.03, horizontal: size.width * 0.015),
            child: Icon(LineIcons.microphone,
                color: widget.isBrown
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white,
                size: size.width * (widget.isBrown ? 0.13 : 0.12))),
      ),
    );
  }
}
