import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/question_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/word_provider.dart';
import 'package:oken/widgets/audiobar.dart';
import 'package:oken/widgets/header.dart';
import 'package:oken/widgets/memory.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    questions = Provider.of<QuestionProvider>(context, listen: false);
    questions.shuffle();
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
  }

  @override
  void dispose() {
    timer.stop();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  QuestionProvider questions;
  TimerProvider timer;
  WordProvider words;
  bool auto = true;
  int duration = 300;
  SwiperController cont;
  bool isPristine = true;
  Map args;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    questions = Provider.of<QuestionProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    questions.setQuestions(args['question_type']);
    timer = Provider.of<TimerProvider>(context, listen: false);
    words = Provider.of<WordProvider>(context);
    cont = SwiperController();

    if (isPristine) {
      cont.startAutoplay();
    }

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        _background(),
        Column(
          children: [
            SizedBox(height: 80),
            Container(height: 600, child: _swiper(context)),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Header(back: true),
        ),
        Positioned(top: 50, left: 130, child: _bullets()),
        Positioned(
          top: 55,
          left: 0,
          child: Clock(),
        ),
        Positioned(bottom: height * 0.02, left: 0, child: _switchers(context)),
        Positioned(
            bottom: height * 0.16,
            left: 50,
            child: questions.isTalking ? Audiobar() : Container())
      ],
    )));
  }

  Widget _background() {
    return Container(color: Color(0xff92D050));
  }

  Widget _bullets() {
    return Row(
      children: [
        Container(
          height: isPristine ? 20 : 15,
          width: isPristine ? 20 : 15,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isPristine ? 1 : 0.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: isPristine ? 15 : 20,
          width: isPristine ? 15 : 20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isPristine ? 0.5 : 1),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }

  Widget _swiper(context) {
    return Swiper(
        duration: 800,
        onIndexChanged: (i) {
          cont.stopAutoplay();
          isPristine = false;
          words.shuffle();
        },
        itemCount: questions.allQuestions.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardbody(index);
        },
        viewportFraction: 0.9,
        scale: 0.6,
        controller: cont);
  }

  Widget _cardbody(index) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 0,
      child: Stack(children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: _cardContent(index)),
      ]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }

  Widget _cardContent(index) {
    return Column(children: [
      SizedBox(height: questions.showChallengingWords ? 0 : 60),
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            args['cover'],
            width: 300,
            height: 150,
            fit: BoxFit.cover,
          )),
      SizedBox(height: 15),
      Text(questions.oneQuestion(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          )),
      SizedBox(height: 15),
      if (questions.showChallengingWords)
        Text('Answer combining these words:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Indi Flower')),
      SizedBox(height: 15),
      Memory(questions.showChallengingWords)
    ]);
  }

  Widget _switchers(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: MediaQuery.of(context).size.width,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(),
          _toggleWords(width, context),
          _mic(width),
          _refreshWords(width),
          SizedBox()
        ]));
  }

  Widget _refreshWords(width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: InkWell(
            customBorder: CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.autorenew,
                  size: width * 0.1, color: Colors.white.withOpacity(0.8)),
            ),
            onTap: () => words.shuffle(),
            splashColor: Colors.white.withOpacity(0.2)),
      ),
    );
  }

  Widget _toggleWords(width, context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300),
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: InkWell(
            customBorder: CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.font_download_off_outlined,
                  size: width * 0.09, color: Colors.white.withOpacity(0.8)),
            ),
            onTap: () => questions.toggleWords(),
            splashColor: Colors.white.withOpacity(0.2)),
      ),
    );
  }

  Widget _mic(width) {
    return Container(
      padding: EdgeInsets.only(bottom: 35),
      child: InkWell(
          customBorder: CircleBorder(),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: Color(0xff92D050),
                border: Border.all(color: Colors.white.withOpacity(0.15))),
            padding: EdgeInsets.all(5),
            child: Listener(
              onPointerUp: (e) {
                questions.disableTalking();
                timer.stop();
              },
              child: Icon(Icons.mic_none,
                  size: width * 0.135, color: Colors.white.withOpacity(0.8)),
            ),
          ),
          onLongPress: () {
            questions.enableTalking();
            timer.start();
          },
          onTap: () => _toast('Keep pressing'),
          splashColor: Colors.white.withOpacity(0.2)),
    );
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionProvider question = Provider.of<QuestionProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;

    if (!question.isTalking) return Container();

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
