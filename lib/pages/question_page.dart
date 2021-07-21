import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oken/providers/question_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/vocabulary_provider.dart';
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
    vocabulary = Provider.of<VocabularyProvider>(context, listen: false);
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

  QuestionProvider questions;
  TimerProvider timer;
  bool auto = true;
  int duration = 300;
  SwiperController cont;
  bool isPristine = true;
  Map args;
  Size size;
  bool offWords = false;
  VocabularyProvider vocabulary;
  List actives = [false, false, false];

  @override
  Widget build(BuildContext context) {
    questions = Provider.of<QuestionProvider>(context);
    args = ModalRoute.of(context).settings.arguments;
    questions.setQuestions(args['question_type']);
    timer = Provider.of<TimerProvider>(context, listen: false);
    cont = SwiperController();
    size = MediaQuery.of(context).size;
    Provider.of<VocabularyProvider>(context);

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
        Positioned(top: size.height * 0.07, left: 0, child: _bullets()),
        Positioned(
          top: 55,
          left: 0,
          child: Clock(),
        ),
        Positioned(
            bottom: size.height * 0.02, left: 0, child: _switchers(context)),
        Positioned(
            bottom: size.height * 0.16,
            left: size.height * 0.1,
            child: questions.isTalking ? Audiobar() : Container())
      ],
    )));
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
      SizedBox(height: questions.showChallengingWords ? 0 : 60),
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            args['cover'],
            width: size.width * 0.8,
            height: size.height * 0.21,
            fit: BoxFit.cover,
          )),
      SizedBox(height: size.height * 0.03),
      Text(questions.oneQuestion(index),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: questions.oneQuestion(index).length > 60
                ? size.width * 0.045
                : size.width * 0.05,
          )),
      SizedBox(height: size.height * 0.03),
      if (questions.showChallengingWords)
        Text('Answer combining these words:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
                fontFamily: 'Indi Flower')),
      SizedBox(height: 15),
      Memory(questions.showChallengingWords)
    ]);
  }

  Widget _switchers(BuildContext context) {
    return Container(
        width: size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              _toggleWords(),
              _mic(),
              _refreshWords(),
              SizedBox()
            ]));
  }

  Widget _refreshWords() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: InkWell(
            customBorder: CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.done,
                  size: size.width * 0.1, color: Colors.white.withOpacity(0.8)),
            ),
            onTap: () {
              if (offWords) return;
              _presentActionSheet();
            },
            // onTap: () => vocabulary.shuffle(),
            splashColor: Colors.white.withOpacity(0.2)),
      ),
    );
  }

  Widget _toggleWords() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300),
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: InkWell(
            customBorder: CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                  offWords
                      ? Icons.radio_button_unchecked
                      : Icons.not_interested,
                  size: size.width * 0.09,
                  color: Colors.white.withOpacity(0.8)),
            ),
            onTap: () {
              offWords = !offWords;
              questions.toggleWords();
              setState(() {});
            },
            splashColor: Colors.white.withOpacity(0.2)),
      ),
    );
  }

  Widget _mic() {
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
                  size: size.width * 0.135,
                  color: Colors.white.withOpacity(0.8)),
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

   void _presentActionSheet() {     
    Future<void> future = showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
            color: Colors.white,
            height: size.width*0.8,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(Icons.translate, color: Colors.black.withOpacity(0.7)),
                    // SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('Vocabulary', style: TextStyle(
                        fontSize: 15,
                      ),),
                    ),
                  ],
                ),
                // Icon(Icons.translate, color: Colors.black.withOpacity(0.7)),
                InkWell(
                  onTap: () {
                    if (actives[0] || actives[1] || actives[2]) {
                      vocabulary.shuffle();
                      Navigator.pop(context);
                    }                    
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text('Mastered', style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),),
                  ),
                ),
              ],
            )
          ),
      ListTile(
         leading: Icon(actives[0] ? Icons.check_box : Icons.check_box_outline_blank,
          color: actives[0]? Colors.blue : Colors.black54
        ),
          title: Text(vocabulary.firstThreeWords[0]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            actives[0] = !actives[0];
            setState(() {});
            // Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(actives[1] ? Icons.check_box : Icons.check_box_outline_blank,
          color: actives[1]? Colors.blue : Colors.black54
        ),
          title: Text(vocabulary.firstThreeWords[1]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            actives[1] = !actives[1];
            setState(() {});
            // Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(actives[2] ? Icons.check_box : Icons.check_box_outline_blank,
          color: actives[2]? Colors.blue : Colors.black54
        ),
          title: Text(vocabulary.firstThreeWords[2]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            actives[2] = !actives[2];
            setState(() {});
            // Navigator.pop(context);
          }),
          SizedBox(height: 10,),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                width: size.width*0.8,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.center,
                child: Text('Cancel', style: TextStyle(
                ),)
              ),
            ),
          ),
    ])
            ),
          );
          
        });
  });
  void _closeModal(v) {
    actives = [false, false, false];
  }

  future.then((void value) => _closeModal(0));

  

  Widget _actionSheetBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              alignment: Alignment.centerRight,
              child: Text('Known', style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),)
            ),
      ),
      ListTile(
        leading: Icon(Icons.check_box_outline_blank),
          title: Text(vocabulary.firstThreeWords[0]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            // Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(actives[1] ? Icons.check_box : Icons.check_box_outline_blank,
          color: actives[1]? Colors.blue : Colors.black54
        ),
          title: Text(vocabulary.firstThreeWords[1]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            actives[1] = !actives[1];
            setState(() {
              
            });
            // Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(Icons.check_box_outline_blank),
          title: Text(vocabulary.firstThreeWords[2]['title'], style: TextStyle(
            fontSize: size.width*0.044
          ),),
          onTap: () {
            // Navigator.pop(context);
          }),
          SizedBox(height: 10,),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Container(
                width: size.width*0.8,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.center,
                child: Text('Cancel', style: TextStyle(
                ),)
              ),
            ),
          ),
    ]);
  }

  Widget _actionSheetHeader(elem) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
          Row(
            children: [
              SizedBox(width: size.width*0.03),
              Text(elem['folder_name'],
                  style: TextStyle(fontSize: size.width*0.04, color: Colors.black54)),
            ],
          )
        ]));
  }
}}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionProvider question = Provider.of<QuestionProvider>(context);
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
