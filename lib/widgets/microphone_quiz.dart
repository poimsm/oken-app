import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'keyboard_visibility_builder.dart';

class MicrophoneQuiz extends StatefulWidget {
  @override
  _MicrophoneQuizState createState() => _MicrophoneQuizState();
}

class _MicrophoneQuizState extends State<MicrophoneQuiz> {
  @override
  void dispose() {
    audioProvider.onDispose();
    super.dispose();
  }

  AudioProvider audioProvider;
  QuizProvider quizProvider;
  TimerProvider timerProvider;
  Size size;
  Timer timer;
  int _time = 0;
  bool isRecording = false;
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    audioProvider = Provider.of<AudioProvider>(context);
    quizProvider = Provider.of<QuizProvider>(context);
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
    size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            width: size.width,
            alignment: Alignment.center,
            child:
                audioProvider.hasNewAudioToBeSaved ? _newAudio() : _micBtn()),
        KeyboardVisibilityBuilder(
          builder: (context, child, isKeyboardVisible) {
            return SizedBox(height: isKeyboardVisible ? 0 : 50);
          },
        ),
      ],
    );
  }

  Widget _newAudio() {
    return Container(
        width: audioProvider.isSaving ? 300 : 190,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(audioProvider.isSaving ? 16 : 6),
          color: Color(COLOR.PURPLE),
        ),
        child: audioProvider.isSaving ? _saveAudioUI() : _normalUI());
  }

  Widget _saveAudioUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          alignment: Alignment.centerRight,
          child: InkWell(
              onTap: () {
                audioProvider.saveAudio(_titleController.text, 'quiz');
                _titleController.clear();
              },
              child: Icon(Icons.save_alt, color: Colors.white, size: 32)),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _titleController,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(color: Colors.white, fontSize: 17),
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white, fontSize: 17),
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: 'Title'),
        ),
        SizedBox(height: 5),
        Container(height: 1, width: 180, color: Colors.white),
        SizedBox(height: 20)
      ]),
    );
  }

  Widget _normalUI() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      InkWell(
          onTap: () => audioProvider.play(),
          child: Icon(audioProvider.isPlaying ? Icons.pause : Icons.refresh,
              color: Colors.white, size: 32)),
      Container(width: 2, height: 25, color: Color(0xff7030A0)),
      InkWell(
          onTap: () => audioProvider.isSaving = true,
          child: Icon(Icons.save_alt, color: Colors.white, size: 32)),
    ]);
  }

  Widget _micBtn() {
    void onStop() {
      timer.cancel();
      _time = 0;
      if (!isRecording) return;
      quizProvider.disableTalking();
      timerProvider.stop();
      audioProvider.stopRecording();
    }

    Future<void> onStart() async {
      isRecording = await audioProvider.startRecording();
      if (!isRecording) return;
      quizProvider.enableTalking();
      timerProvider.start();
    }

    return InkWell(
      onTap: () {
        if (!quizProvider.isTalking) return _toast('Keep pressing');
        onStop();
      },
      onLongPress: () {
        timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
          _time += 1;
          if (_time >= 120) onStop();
        });
        onStart();
      },
      child: Listener(
        onPointerUp: (e) {
          if (_time < 3) {
            Timer(Duration(milliseconds: 500), () => onStop());
          } else {
            onStop();
          }
        },
        child: Container(
            width: 190,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(COLOR.PURPLE),
            ),
            child: quizProvider.isTalking
                ? Row(
                    children: [
                      Icon(Icons.pause, color: Colors.white, size: 32),
                      SizedBox(width: 5),
                      Text(
                        'Recording...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.045,
                        ),
                      )
                    ],
                  )
                : Icon(Icons.mic,
                    color: Colors.white, size: size.width * 0.09)),
      ),
    );
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
