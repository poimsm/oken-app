import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/routine_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/widgets/audio_bar.dart';
import 'package:oken/widgets/header.dart';
import 'package:oken/widgets/microphone_routine.dart';
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
    routineProvider.onDispose();
    isPristine = true;
    super.dispose();
  }

  RoutineProvider routineProvider;
  TimerProvider timer;
  bool showToast = false;
  Map args;
  bool isPristine = true;
  Size size;
  AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    routineProvider = Provider.of<RoutineProvider>(context);
    audioProvider = Provider.of<AudioProvider>(context);
    size = MediaQuery.of(context).size;

    if (isPristine) {
      args = ModalRoute.of(context).settings.arguments;
      routineProvider.setQuestions(args['question_type']);
      timer = Provider.of<TimerProvider>(context, listen: false);
      isPristine = false;
    }

    return GestureDetector(
      onTap: () => audioProvider.reset(setState: true),
      child: SafeArea(
          child: Scaffold(
              body: Stack(children: [
        _background(),
        Header(color: args['header_color'], back: true),
        if (!args['isBrown'])
          Positioned(child: _imgClock(), top: size.height * 0.13, left: 0),
        Positioned(child: _questionBox(), top: size.height * 0.4, left: 0),
        Positioned(
            child: _buttons(),
            bottom: size.height * (args['isBrown'] ? 0.16 : 0.2),
            left: 0),
        Positioned(child: _example(), bottom: size.height * 0.08, left: 0),
        if (audioProvider.isTalking)
          Positioned(child: Clock(), top: 52.5, left: 0),
        AudioBar(small: true),
        if (routineProvider.showToast)
          Positioned(
              child: _customToast(),
              bottom: size.height * 0.3,
              left: size.width * 0.15),
      ]))),
    );
  }

  Widget _customToast() {
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
      child: Center(child: routineProvider.loading ? _loader() : _question()),
    );
  }

  Widget _question() {
    return Text(
      routineProvider.question,
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
          MicrophoneRoutine(isBrown: args['isBrown']),
          SizedBox(width: size.width * (args['isBrown'] ? 0.15 : 0.2)),
          _next()
        ],
      ),
    );
  }

  Widget _next() {
    return InkWell(
      onTap: () {
        routineProvider.increaseIndex();
        audioProvider.reset(setState: true);
      },
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
                fontWeight:
                    args['isBrown'] ? FontWeight.bold : FontWeight.normal,
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
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;
    Size size = MediaQuery.of(context).size;

    if (!audioProvider.isTalking) return Container();

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
