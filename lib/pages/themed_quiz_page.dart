import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/themed_quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/widgets/audiobar.dart';
import 'package:oken/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ThemedQuizPage extends StatefulWidget {
  ThemedQuizPage({Key key}) : super(key: key);

  @override
  _ThemedQuizPageState createState() => _ThemedQuizPageState();
}

  
ThemedQuizProvider themedQuiz;
TimerProvider timer;
bool showToast = false;
Map args;
bool isPristine = true;

class _ThemedQuizPageState extends State<ThemedQuizPage> {

  @override
  void dispose() {
    themedQuiz.dispose();
    isPristine = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themedQuiz = Provider.of<ThemedQuizProvider>(context);

    if (isPristine) {
      args = ModalRoute.of(context).settings.arguments;
      themedQuiz.setQuestions(args['question_type']);
      timer = Provider.of<TimerProvider>(context, listen: false);
      isPristine = false;
    }

    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      _background(),
      Header(color: args['header_color'], back: true),
      Positioned(child: _imgClock(), top: 100, left: 120),
      Positioned(child: _questionBox(), top: 300, left: 0),
      Positioned(child: _buttons(), bottom: 150, left: 100),
      Positioned(child: _example(), bottom: 50, left: 100),
      if (themedQuiz.isTalking) Positioned(child: Clock(), top: 55, left: 0),
      if (themedQuiz.isTalking)
        Positioned(child: Audiobar(small: true), bottom: 230, left: 50),
      if (showToast) Positioned(child: _mtoast(), bottom: 230, left: 50),
    ])));
  }

  Widget _mtoast() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black.withOpacity(0.8)),
        child: Text('Keep pressing',
            style: TextStyle(color: Colors.white, fontSize: 16)));
  }

  Widget _background() {
    String imgURL = args['img_background'];
    return Image.network(imgURL,
        height: double.infinity, width: double.infinity, fit: BoxFit.cover);
  }

  Widget _imgClock() {
    String imgURL = args['img_clock'];
    return Image.network(imgURL, width: 170, fit: BoxFit.cover);
  }

  Widget _questionBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.4),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Center(child: themedQuiz.loading ? _loader() : _question()),
    );
  }

  Widget _question() {
    return Text(
      themedQuiz.question,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 17.5, fontWeight: FontWeight.bold),
    );
  }

  Widget _loader() {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: 50.0,
    );
  }

  Widget _buttons() {
    return Row(
      children: [_mic(), SizedBox(width: 70), _next()],
    );
  }

  Widget _mic() {
    return InkWell(
      onTap: () {
        Timer(Duration(milliseconds: 1000), () {
          setState(() => showToast = false);
        });
        setState(() => showToast = true);
      },
      onLongPress: () {
        themedQuiz.startTalking();
        timer.start();
      },
      child: Listener(
        onPointerUp: (e) {
          themedQuiz.stopTalking();
          timer.stop();
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.5)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Icon(LineIcons.microphone, color: Colors.white, size: 45)),
      ),
    );
  }

  Widget _next() {
    return InkWell(
      onTap: () => themedQuiz.increaseIndex(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.5)),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Icon(LineIcons.angleRight, color: Colors.white, size: 43)),
    );
  }

  Widget _example() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(6),
          color: Color(0xff203864).withOpacity(0.5),
        ),
        width: 180,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'SEE EXAMPLE',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
  }

  void _toast([text = 'Comming soon']) {
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemedQuizProvider themedQuiz = Provider.of<ThemedQuizProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;

    if (!themedQuiz.isTalking) return Container();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(11),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          child: Text(
            time.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
