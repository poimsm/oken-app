import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/word_list.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Shop extends StatefulWidget {
  Shop({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<Shop> {
  ScrollController _controller;

  bool changeColor = false;
  String wasState = 'transparent';
  String currentState = 'transparent';

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      
      if( _controller.offset > 165) {
        changeColor = true;
        wasState = 'transparent';
      } else {
        changeColor = false;
        wasState = 'purple';
      }

      if (currentState != wasState) {
        currentState = wasState;
        setState(() { });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> words = Provider.of<WordList>(context).wordlistAll;
    double width =  MediaQuery.of(context).size.width;  
    
    return SafeArea(
      child: 
        Scaffold(
          body: Stack(children: [
          _background(),
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 250),
                  child: Image.asset('assets/bg01.png', 
                  height: 800,
                  fit:BoxFit.cover
                  ),
                ),
                Image.asset('assets/banner02.png', width: double.infinity),
                _body()
              ],
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: _header(context, changeColor),
          ),
        ]
        ),
      ),);
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 170),
          Container(
            padding: EdgeInsets.only(left: 190),
            child: Image.asset('assets/banner01.png', width: 150)
          ),
          SizedBox(height: 10),
          Text('QUESTIONS', style: TextStyle(color: Color(0xffF2F2F2), fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _questionPacks(),
          SizedBox(height: 30),
          Text('WORDS AND PHRASES', style: TextStyle(color: Color(0xffF2F2F2), fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _wordAndPhrasesPacks(),
          SizedBox(height: 40),
          _getCoinBoxes(),
          SizedBox(height: 40),
          _getCoinBanner(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _getCoinBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('assets/chess_coin_01.png', width: 110),
        Image.asset('assets/chess_coin_02.png', width: 110),
      ],
    );
  }

  Widget _getCoinBanner() {
    return Center(child: Image.asset('assets/banner_coins.png', width: 270));
  }

  Widget _questionPacks() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _box('assets/box01.png', 'Pack Random Questions', 'Free', true),
          _box('assets/box02.png', 'Pack Interview Questions', '1500', false)
        ],
      )
    );
  }

   Widget _wordAndPhrasesPacks() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _box('assets/box03.png', 'Most common idoms', '3000', true),
          _box('assets/box04.png', 'Phrasal verbs with Get', 'Free', false)
        ],
      )
    );
  }

  Widget _box(imgPath, title, price, condensed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 140,
        height: 190,
        padding: EdgeInsets.all(10),
        color: Color(0xffF2F2F2),
        child: Column(
          children: [
            Expanded(child: Image.asset(imgPath)),
            if(!condensed) SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: TextStyle(color: Color(0xff595959))),
            SizedBox(height: 10),
            _btnPrice(price)
          ],
        )
      )
    );
  }

  Widget _btnPrice(price) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 60,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5),
        color: Color(0xff68CB71),
        child: Text(price, style: TextStyle(
          color: Color(0xffF2F2F2),
          fontWeight: FontWeight.bold
        ))
      )
    );
  }

  Widget _background() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xff434157)
    );
  }

  Widget _header(context, changeColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: (changeColor) ? Color(0xff8F73AD) : Colors.transparent,
      child: _appBar(context, changeColor),
    );
  }
 
  Widget _appBar(BuildContext context, bool changeColor) {
    double width =  MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            IconButton(icon: Icon(Icons.arrow_back, color: Color(0xffF2F2F2)), onPressed: () => Navigator.pop(context)),
            if(changeColor) Text('Oken', style: TextStyle(fontSize: width*0.056, color: Color(0xffF2F2F2)))
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:   InkWell(
          // child: Icon(Icons.search, size: width*0.09),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.black.withOpacity(0.3),
              child: InkWell(
                child: Icon(Icons.search, size: width*0.09, color: Color(0xffF2F2F2)),
                onTap: () => _toast(),
              )
            ),
          ),
          onTap: () => _toast(),
          )
        ),
      ],
    );
  }

  void _toast() {
    Toast.show("Soon available", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
