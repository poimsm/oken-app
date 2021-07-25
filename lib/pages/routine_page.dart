import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/routine_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/widgets/audiobar.dart';
import 'package:oken/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RoutinePage extends StatefulWidget {
  RoutinePage({Key key}) : super(key: key);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  void dispose() {
    themedQuiz.dispose();
    isPristine = true;
    super.dispose();
  }

  RoutineProvider themedQuiz;
  TimerProvider timer;
  bool showToast = false;
  Map args;
  bool isPristine = true;
  Size size;

  @override
  Widget build(BuildContext context) {
    themedQuiz = Provider.of<RoutineProvider>(context);
    size = MediaQuery.of(context).size;

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
      if(!args['isBrown']) Positioned(child: _imgClock(), top: size.height*0.13, left: 0),
      Positioned(child: _questionBox(), top: size.height * 0.4, left: 0),
      Positioned(
          child: _buttons(),
          bottom: size.height * (args['isBrown'] ? 0.16 : 0.2),
          left: 0),
      Positioned(child: _example(), bottom: size.height * 0.08, left: 0),
      if (themedQuiz.isTalking) Positioned(child: Clock(), top: 52.5, left: 0),
      if (themedQuiz.isTalking)
        Positioned(
            child: Audiobar(small: true),
            bottom: size.height * (args['isBrown'] ? 0.26 : 0.3),
            left: size.width * 0.12),
      if (showToast)
        Positioned(
            child: _mtoast(),
            bottom: size.height * 0.3,
            left: size.width * 0.15),
    ])));
  }

  Widget _mtoast() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.02, horizontal: size.width * 0.04),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black.withOpacity(0.8)),
        child: Text('Keep pressing',
            style:
                TextStyle(color: Colors.white, fontSize: size.width * 0.043)));
  }

  Widget _background() {
    String imgURL = args['img_background'];
    return Image.network(imgURL,
        height: double.infinity, width: double.infinity, fit: BoxFit.cover);
  }

  Widget _imgClock() {
    String imgURL = args['img_clock'];
    return Container(
        width: size.width,
        alignment: Alignment.center,
        child:
            Image.network(imgURL, width: size.width * 0.47, fit: BoxFit.cover));
  }

  Widget _questionBox() {
    return Container(
      width: size.width,
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
          color: Colors.white,
          fontSize: size.width * 0.05,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _loader() {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: size.width * 0.16,
    );
  }

  Widget _buttons() {
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mic(),
          SizedBox(width: size.width * (args['isBrown'] ? 0.15 : 0.2)),
          _next()
        ],
      ),
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
                color: args['isBrown']
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.5)),
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.03, horizontal: size.width * 0.015),
            child: Icon(LineIcons.microphone,
                color: args['isBrown']
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white,
                size: size.width * (args['isBrown'] ? 0.13 : 0.12))),
      ),
    );
  }

  Widget _next() {
    return InkWell(
      onTap: () => themedQuiz.increaseIndex(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: args['isBrown']
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.5)),
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.03, horizontal: size.width * 0.015),
          child: Icon(LineIcons.angleRight,
              color: args['isBrown']
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white,
              size: size.width * (args['isBrown'] ? 0.13 : 0.12))),
    );
  }

  Widget _example() {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: args['isBrown'] ? Color(0xff843C0C) : Colors.white),
            borderRadius: BorderRadius.circular(6),
            color: args['isBrown']
                ? Colors.transparent
                : Color(0xff203864).withOpacity(0.5),
          ),
          width: size.width * 0.5,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'SEE EXAMPLE',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: args['isBrown']? FontWeight.bold : FontWeight.normal,
                fontSize: size.width * 0.04,
                color: args['isBrown'] ? Color(0xff843C0C) : Colors.white),
          )),
    );
  }

  void _toast([text = 'Comming soon']) {
    Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RoutineProvider themedQuiz = Provider.of<RoutineProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;
    Size size = MediaQuery.of(context).size;

    if (!themedQuiz.isTalking) return Container();

    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(11),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          child: Text(
            time.toString(),
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.06),
          ),
        ),
      ),
    );
  }
}
