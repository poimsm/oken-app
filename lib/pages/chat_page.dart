import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/word_list.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> words = Provider.of<WordList>(context).wordlistAll;
    double width =  MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: 
        Scaffold(
          body: Stack(children: [
          _background(),
          _chatMsg(words),
          _header(context),          
          Positioned(
            bottom: 0,
            left: 0,
            child: _footer(),
          ),
        ]
        ),
      ),);
  }

  Widget _footer() {
    double width =  MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
            // Icon(LineIcons.commentDots, color: Colors.black.withOpacity(0.5), size: 35),
            IntrinsicWidth(child:
            Container(
              // color: Colors.red,
              width: width*0.68,
              child: TextField(
                // textCapitalization: TextCapitalization.sentences,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  // fillColor: Colors.white.withOpacity(0.9),
                  // filled: true,
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                  // border: OutlineInputBorder(),
                  hintText: 'Enter a new word here...'
                ),
              ),
            )),
             ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Color(0xff68CB71),
                  child: InkWell(
                  customBorder: CircleBorder(),
                  child: Container(
                    height: 50,
                    width: 70,
                    child: Icon(Icons.create_outlined, size: width*0.11, color: Colors.white)
                  ),
                  onTap: () {
                    context.read<WordList>().shuffle();
                  },
                  splashColor: Colors.black.withOpacity(0.2)
                ),
              ),
            ),
          ]
        )
      );
  }

  Widget _chatMsg(words) {
    ScrollController _controller = new ScrollController();

    Timer( Duration(milliseconds: 200), () => 
      _controller.jumpTo(_controller.position.maxScrollExtent));

    return Container(
      padding: EdgeInsets.only(bottom: 80, top: 60),
      child: ListView.builder(
        controller: _controller,            
        shrinkWrap: true,
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(words[index], index);
        }
      ),
    );
  }

  Widget _background() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xff434157)
    );
  }

  Widget _header(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Color(0xff8F73AD),
      child: _appBar(context),
    );
  }
 
  Widget _appBar(BuildContext context) {
    double width =  MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            Text('Oken', style: TextStyle(fontSize: width*0.056, color: Colors.white))
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:   InkWell(
          child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black.withOpacity(0.3),
                  child: InkWell(
                    child: Icon(Icons.search, size: width*0.09, color: Colors.white),
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
  

  Widget _item(text, i) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _toast(),
        child: Container(
          alignment: Alignment.topRight,
          width: double.infinity,
          padding: EdgeInsets.all(15),  
          child: _itemBody(text, i),
        )
      ),
    );
}

  Widget _itemBody(text, i) {
    double width =  MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border.all(
            color: Colors.white.withOpacity(0.9),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Text(text, style: TextStyle(fontSize: width*0.043))
      ),
      SizedBox(height: 5),
        if(i.isOdd) Row(
          children: [
            Icon(LineIcons.check, color: Colors.white, size: width*0.055),
            Text('Known', style: TextStyle(fontSize: 12, color: Colors.white)),
        SizedBox(width: 10),
          ],
        ),
          if(!i.isOdd) Row(
          children: [
             Icon(LineIcons.alternateSync, color: Colors.white, size: width*0.055),
            Text('Relearn', style: TextStyle(fontSize: 12, color: Colors.white)),
        SizedBox(width: 10),
            Icon(LineIcons.clock, color: Colors.white, size: width*0.055),
            Text('New', style: TextStyle(fontSize: 12, color: Colors.white)),
        SizedBox(width: 10),
          ],
        )] 
      ),  
      SizedBox(width: 10),
      Image.asset('assets/pixel07.png', height: width*0.09),
      ]
    );
  }

  void _toast() {
    Toast.show("Soon available", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
