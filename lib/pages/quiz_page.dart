import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oken/providers/quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/widgets/header.dart';
import 'package:oken/widgets/memory.dart';
import 'package:oken/widgets/quiz_drawer.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    quiz = Provider.of<QuizProvider>(context, listen: false);
    quiz.shuffle();
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    vocabulary.load();
    vocabulary.setQuestionWords();
    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
  }

  @override
  void dispose() {
    timer.stop();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  QuizProvider quiz;
  TimerProvider timer;
  bool auto = true;
  int duration = 300;
  SwiperController cont;
  bool isPristine = true;
  Map args;
  Size size;
  bool offWords = false;
  VocabProvider vocabulary;
  List actives = [false, false, false];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isExample = false;

  @override
  Widget build(BuildContext context) {
    quiz = Provider.of<QuizProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    quiz.setQuestions(args['question_type']);
    timer = Provider.of<TimerProvider>(context, listen: false);
    cont = SwiperController();
    size = MediaQuery.of(context).size;
    Provider.of<VocabProvider>(context);

    if (isPristine) {
      cont.startAutoplay();
    }

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            endDrawer: QuizDrawer(isExample),
            body: Stack(
              children: [
                _background(),
                Column(
                  children: [
                    SizedBox(height: 80),
                    Container(
                        height: size.height * 0.8, child: _swiper(context)),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Header(back: true),
                ),
                Positioned(top: size.height * 0.07, left: 0, child: _bullets()),
                Positioned(
                  top: 55,
                  left: 0,
                  child: Clock(),
                ),
                Positioned(
                    bottom: size.height * 0.73, right: 0, child: _vocabBtn()),
                Positioned(
                    bottom: size.height * 0.63, right: 0, child: _example()),
                Positioned(
                    bottom: size.height * 0.06, left: 0, child: _micBtn()),
                // Positioned(
                //     bottom: size.height * 0.13, left: 0, child: _customToast()),
              ],
            )));
  }

  Widget _customToast() {
    return Container(
        width: size.width,
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.75),
            ),
            child: Text(
              'Keep pressing',
              style: TextStyle(color: Colors.white),
            )));
  }

  Widget _example() {
    return InkWell(
      onTap: () {
        isExample = true;
        setState(() {});
        scaffoldKey.currentState.openEndDrawer();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            color: Color(0xffFFC000),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.white, size: size.width * 0.07),
              SizedBox(width: 10),
              Text('EXAMPLE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.width * 0.038))
            ],
          )),
    );
  }

  Widget _vocabBtn() {
    return InkWell(
      onTap: () {
        isExample = false;
        setState(() {});
        scaffoldKey.currentState.openEndDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
          color: Color(0xff8037B7),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child:
            Icon(Icons.translate, color: Colors.white, size: size.width * 0.08),
      ),
    );
  }

  Widget _micBtn() {
    return InkWell(
      onLongPress: () {
        quiz.enableTalking();
        timer.start();
      },
      onTap: () {
        if (!quiz.isTalking) return _toast('Keep pressing');
        quiz.disableTalking();
        timer.stop();
      },
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        child: Container(
            width: size.width * 0.52,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xff8037B7),
            ),
            child: quiz.isTalking
                ? Row(
                    children: [
                      Icon(Icons.pause,
                          color: Colors.white, size: size.width * 0.09),
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

  Widget _background() {
    return Container(color: Color(0xff92D050));
  }

  Widget _bullets() {
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  Widget _swiper(context) {
    return Swiper(
        duration: 800,
        onIndexChanged: (i) {
          cont.stopAutoplay();
          isPristine = false;
          vocabulary.shuffle();
        },
        itemCount: quiz.allQuestions.length,
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
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.03),
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
      SizedBox(height: quiz.showChallengingWords ? 0 : 60),
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            args['cover'],
            width: size.width * 0.8,
            height: size.height * 0.21,
            fit: BoxFit.cover,
          )),
      SizedBox(height: size.height * 0.03),
      Text(quiz.oneQuestion(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: quiz.oneQuestion(index).length > 60
                ? quiz.oneQuestion(index).length > 100
                    ? size.width * 0.055
                    : size.width * 0.065
                : size.width * 0.07,
          )),
      SizedBox(height: size.height * 0.05),
      Memory(quiz.showChallengingWords)
    ]);
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuizProvider question = Provider.of<QuizProvider>(context);
    int time = Provider.of<TimerProvider>(context).time;
    Size size = MediaQuery.of(context).size;

    if (!question.isTalking) return Container();

    return Container(
      width: size.width,
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
            style: TextStyle(color: Colors.white, fontSize: size.width * 0.05),
          ),
        ),
      ),
    );
  }
}