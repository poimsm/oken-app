import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/pages/action_sheet.dart';
import 'package:oken/providers/word_list.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TalkPage extends StatefulWidget {
  TalkPage({Key key}) : super(key: key);

  @override
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> with SingleTickerProviderStateMixin{

  AnimationController controller;
    Animation<double> opacidad;

    @override
    void initState() { 
      controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
      opacidad = new Tween(begin: 0.0, end: 0.9).animate(controller);
      controller.repeat(reverse: true);
      super.initState();      
    }

    @override
    void dispose() { 
      controller.dispose();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    final List<String> wordList = Provider.of<WordList>(context).wordlist;
    final bool isStarted = Provider.of<WordList>(context).isStarted;
    final bool isLoading = Provider.of<WordList>(context).loading;
    final bool showActionSheet = Provider.of<WordList>(context).showActionSheet;
    final String text = Provider.of<WordList>(context).question;
    final String text2 = 'Provider.of<WordList>(context).question';

    // final bool isLoading = true;
    double width =  MediaQuery.of(context).size.width;
    double height =  MediaQuery.of(context).size.height;

    return SafeArea(
        child: 
        Scaffold(body:
        Stack(children: [
          _background(),
          if(isStarted) _header(context),
           if (isLoading) Center(
             child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50,
              ),
           ),

          // if (!isStarted) SingleChildScrollView(
          //   child: Center(child: _startInfo()),
          // ),
          if(!isLoading && isStarted) Column(
            children: [
            SizedBox(width: MediaQuery.of(context).size.width),
            SizedBox(height: 75),
            Image.asset('assets/question_mark.png', width: 80),
            SizedBox(height: 20),
            Container(
              height: 65,
              width: 300,
              child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset('assets/down_arrow.png', width: 60),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset('assets/story_promp.png', width: 230),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Image.asset('assets/timeline.png', height: 220),
            ),
            // AnimatedOpacity(
            //   opacity: !isLoading && isStarted ? 1.0 : 0.0,
            //   duration: Duration(milliseconds: 500),
            //   child: Container(
            //     padding: EdgeInsets.only(top: 30),
            //     child: Image.asset('assets/timeline.png', height: 200),
            //   ),
            // ),
          ]),
          if(!isLoading && isStarted) Positioned(
            top: 365,
            left: 145,
            child: Text(wordList[0], 
            style: TextStyle(fontSize: 16.5, color: Color(0xffD9D9D9))
            )
          ),
          if(!isLoading && isStarted) Positioned(
            top: 487,
            left: 0,
            child: Container(
              alignment: Alignment.centerRight,
              width: 220,
              child: Text(wordList[1],
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16.5, color: Color(0xffD9D9D9))
              ),
            )
          ),
          if(!isLoading && isStarted) Positioned(
            top: 545,
            left: 0,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: (wordList[2].length > 15)? 40 : 5),
              width: 160,
              child: Text(wordList[2],
              textAlign: (wordList[2].length > 15)? TextAlign.start : TextAlign.end,
              style: TextStyle(fontSize: 16.5, color: Color(0xffD9D9D9))
              ),
            ),
          ),
          if(isStarted) Positioned(
              bottom: height*0.03,
              left: 0,
              child: _switchers(context)
            ),
          // _actionSheet(),
          if (showActionSheet) ActionSheet(),
          ])
          )
      );
  }

  Widget _background() {
    return Image.asset('assets/bg02.png', height:double.infinity, fit:BoxFit.cover);
  }

  Widget _startInfo() {
    final String txt1 = '    Add strange words and practice through looping on.';
    // final String txt2 = '    So you add words to a bucket and it pulls from that bucket to challenge you to make a sentence from it!';
    final String txt2 = '    Add words to a bucket and it pulls from that bucket to challenge you to make a sentence from it';
    double width =  MediaQuery.of(context).size.width;
    double height =  MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: height*0.93,
      padding: EdgeInsets.all(10),
      child: Card(
        color: Color(0xff2A1F39).withOpacity(0.6),
          elevation: 3,
          child: Container(
              padding: EdgeInsets.all(30),
                child: Column(
                children: [
                  Text('Practice Looping On',
                  style: TextStyle(
                    fontSize: width*0.059,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(height: 10),
                  Text(txt2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width*0.044,
                  )),
                  SizedBox(height: 10),
                  Image.asset('assets/diagram.png', height: height*0.55),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => context.read<WordList>().start(), 
                    child: Text('GET STARTED'),
                  ),
                ],
              )
          )));
  }

  Widget _header(BuildContext context) {
    double width =  MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xff8F73AD).withOpacity(0.9),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 5),
              IconButton(
                  color: Colors.white,
                  icon: Icon(LineIcons.stream, size: 30),
                  onPressed: () =>  context.read<WordList>().togleActionSheet()
                  ),
              SizedBox(width: 5),
              Text('Oken', style: TextStyle(fontSize: width*0.055, color: Colors.white))
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
              children: [
                SizedBox(width: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black.withOpacity(0.3),
                    child: InkWell(
                      child: Icon(LineIcons.shoppingBasket, size: width*0.09, color: Colors.white),
                      onTap: () => Navigator.pushNamed(context, 'shop'),
                    )
                  ),
                ),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black.withOpacity(0.3),
                    child: InkWell(
                      child: Icon(LineIcons.user, size: width*0.09, color: Colors.white),
                      onTap: () => Navigator.pushNamed(context, 'login'),
                    )
                  ),
                ),
                SizedBox(width: 5),
              ],
          )),
        ],
      ),
    );
  }

  Widget _switchers(BuildContext context) {
    double width =  MediaQuery.of(context).size.width;

    return Container(
        width: MediaQuery.of(context).size.width,
        child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(),
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Material(
                color: Colors.black.withOpacity(0.2),
                child: InkWell(
                  customBorder: CircleBorder(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.create_outlined, size: width*0.125, color: Colors.white.withOpacity(0.8)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'chat');
                  },
                  splashColor: Colors.white.withOpacity(0.2)
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Material(
                color: Color(0xff68CB71),
                  child: InkWell(
                  customBorder: CircleBorder(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.mic_none, size: width*0.125, color: Colors.white.withOpacity(0.8)),
                  ),
                  onTap: () => _toast(),
                  splashColor: Colors.white.withOpacity(0.2)
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: Material(
                color: Colors.black.withOpacity(0.2),
                  child: InkWell(
                  customBorder: CircleBorder(),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.autorenew, size: width*0.125, color: Colors.white.withOpacity(0.8)),
                  ),
                  onTap: () {
                    context.read<WordList>().shuffle();
                  },
                  splashColor: Colors.white.withOpacity(0.2)
                ),
              ),
            ),
            SizedBox()
        ]));
  }

  void _toast() {
    Toast.show("Soon available", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

}
