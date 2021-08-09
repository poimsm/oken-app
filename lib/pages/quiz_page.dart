import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/coin_provider.dart';
import 'package:oken/providers/quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/widgets/clock_quiz.dart';
import 'package:oken/widgets/header.dart';
import 'package:oken/widgets/memory.dart';
import 'package:oken/widgets/microphone_quiz.dart';
import 'package:oken/widgets/quiz_alert.dart';
import 'package:oken/widgets/quiz_drawer.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'package:oken/constants/paid_actions.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.shuffle();
    vocaProvider = Provider.of<VocabProvider>(context, listen: false);
    vocaProvider.load();
    vocaProvider.setQuestionWords();
    SystemChrome.setEnabledSystemUIOverlays([]);
    audioProvider = Provider.of<AudioProvider>(context, listen: false);
    audioProvider.reset();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(swiperCtrl));
  }

  @override
  void dispose() {
    timerProvider.stop();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  QuizProvider quizProvider;
  TimerProvider timerProvider;
  SwiperController swiperCtrl;
  bool isPristine = true;
  Map args;
  Size size;
  VocabProvider vocaProvider;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String drawerType;
  CoinProvider coinProvider;
  AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    quizProvider = Provider.of<QuizProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    quizProvider.setQuestions(args['question_type']);
    timerProvider = Provider.of<TimerProvider>(context, listen: false);
    swiperCtrl = SwiperController();
    size = MediaQuery.of(context).size;
    Provider.of<VocabProvider>(context);
    coinProvider = Provider.of<CoinProvider>(context);
    audioProvider = Provider.of<AudioProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawerEdgeDragWidth: 0,
            endDrawer: QuizDrawer(drawerType),
            body: Stack(
              children: [
                _background(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      Container(height: size.height * 0.8, child: _swiper()),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Header(back: true),
                ),
                Positioned(
                    top: size.height * 0.075, left: 0, child: _bullets()),
                Positioned(
                  top: 55,
                  left: 0,
                  child: ClockQuiz(),
                ),
                Positioned(
                    bottom: size.height * 0.72, right: 2, child: _vocabBtn()),
                Positioned(
                    bottom: size.height * 0.63, right: 2, child: _example()),
                if (args['power_word'])
                  Positioned(
                      bottom: size.height * 0.5,
                      right: 2,
                      child: _powerWords()),
                Positioned(bottom: 0, left: 0, child: MicrophoneQuiz()),
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
        drawerType = 'example';
        setState(() {});
        scaffoldKey.currentState.openEndDrawer();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(COLOR.YELLOW),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(Icons.lightbulb_outline,
              color: Colors.white, size: size.width * 0.07)),
    );
  }

  Widget _powerWords() {
    return InkWell(
      onTap: () {
        drawerType = 'power-word';
        coinProvider.charge(PaidActions.showPowerWord);
        scaffoldKey.currentState.openEndDrawer();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(COLOR.RED),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(Icons.local_fire_department,
              color: Colors.white, size: size.width * 0.07)),
    );
  }

  Widget _vocabBtn() {
    return InkWell(
      onTap: () {
        drawerType = 'vocaProvider';
        setState(() {});
        scaffoldKey.currentState.openEndDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(COLOR.PURPLE),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child:
            Icon(Icons.translate, color: Colors.white, size: size.width * 0.08),
      ),
    );
  }

  Widget _background() {
    return Container(color: Color(COLOR.GREEN));
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

  Widget _swiper() {
    return Swiper(
        duration: 800,
        onIndexChanged: (i) {
          swiperCtrl.stopAutoplay();
          isPristine = false;
          vocaProvider.shuffle();
          audioProvider.reset();
          // coinProvider.charge(PaidActions.swipeQuiz);
        },
        itemCount: quizProvider.allQuestions.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardbody(index);
        },
        viewportFraction: 0.9,
        scale: 0.6,
        controller: swiperCtrl);
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
      SizedBox(height: quizProvider.showChallengingWords ? 0 : 60),
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            args['cover'],
            width: size.width * 0.8,
            height: size.height * 0.21,
            fit: BoxFit.cover,
          )),
      SizedBox(height: size.height * 0.03),
      Text(quizProvider.oneQuestion(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: quizProvider.oneQuestion(index).length > 60
                ? quizProvider.oneQuestion(index).length > 100
                    ? size.width * 0.055
                    : size.width * 0.065
                : size.width * 0.07,
          )),
      SizedBox(height: size.height * 0.05),
      Memory(quizProvider.showChallengingWords)
    ]);
  }

  Future afterBuild(swiperCtrl) async {
    await showDialog(context: context, builder: (context) => QuizAlert());
    swiperCtrl.startAutoplay();
  }
}
