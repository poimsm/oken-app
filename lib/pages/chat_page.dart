import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/word_list.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}
String asd = '';

class _ChatPageState extends State<ChatPage> {
  bool showMenu = false;
  @override
  Widget build(BuildContext context) {
    final List<String> words = Provider.of<WordList>(context).wordlistAll;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: baseAppBar(title: 'My words', back: true, search: true),
      body: Stack(children: [
        // _background(),
        _chatMsg(words),
        Positioned(
          bottom: 0,
          left: 0,
          child: _footer(),
        ),
        if (showMenu)
          InkWell(
            onTap: () {
              setState(() => showMenu = false);
            },
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
        if (showMenu)
          Positioned(
            top: 195,
            left: 20,
            child: _word(),
          ),
        if (showMenu)
          Positioned(
            top: 270,
            left: 20,
            child: _menu(),
          ),
      ]),
    );
  }

  // Widget _

  Widget _word() {
    return Container(
        width: 320,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(asd,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.9),
                    ))
              ],
            )));
  }

  Widget _menu() {
    return Container(
        width: 320,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          children: [
            _menuItem(Icons.check, 'Known'),
            Divider(),
            _menuItem(Icons.sync, 'Relearn'),
            Divider(),
            _menuItem(Icons.delete_outline, 'Delete'),
          ],
        ));
  }

  Widget _menuItem(icon, text) {
    return InkWell(
      onTap: () => setState(() => showMenu = false),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.9),
                  ))
            ],
          )),
    );
  }

  Widget _footer() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        width: MediaQuery.of(context).size.width,
        // color: Colors.black.withOpacity(0.2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(Icons.plus_one, color: Colors.grey),
          // SizedBox(width: 5),
          IntrinsicWidth(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.2),
            ),
            width: 200,
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: Colors.black, fontSize: 16.5),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Enter a new word...'),
            ),
          )),
          SizedBox(width: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Color(0xff68CB71),
              child: InkWell(
                  customBorder: CircleBorder(),
                  child: Container(
                      height: 45,
                      width: 60,
                      child: Icon(Icons.create_outlined,
                          size: width * 0.1, color: Colors.white)),
                  onTap: () {
                    context.read<WordList>().shuffle();
                  },
                  splashColor: Colors.black.withOpacity(0.2)),
            ),
          ),
        ]));
  }

  Widget _chatMsg(words) {
    ScrollController _controller = new ScrollController();

    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));

    return Container(
      padding: EdgeInsets.only(bottom: 80),
      child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return _item(words[index], index);
          }),
    );
  }

  Widget _background() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff434157));
  }

  Widget _item(text, i) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          // onTap: () => _toast(),
          onLongPress: () {
            asd = text;
            setState(() => showMenu = true);
          },
          child: Container(
            alignment: Alignment.topRight,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: _itemBody(text, i),
          )),
    );
  }

  Widget _itemBody(text, i) {
    double width = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(text,
                style: TextStyle(
                    fontSize: width * 0.043,
                    color: Colors.black.withOpacity(0.7)))),
        SizedBox(height: 5),
        if (i.isOdd)
          Row(
            children: [
              Icon(LineIcons.check, color: Colors.black54, size: width * 0.055),
              Text('Known',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              SizedBox(width: 10),
            ],
          ),
        if (!i.isOdd)
          Row(
            children: [
              Icon(LineIcons.alternateSync,
                  color: Colors.black54, size: width * 0.055),
              Text('Relearn',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              SizedBox(width: 10),
              Icon(LineIcons.clock, color: Colors.black54, size: width * 0.055),
              Text('New',
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              SizedBox(width: 10),
            ],
          )
      ]),
      SizedBox(width: 10),
      Image.asset('assets/pixel07.png', height: width * 0.09),
    ]);
  }

  void _toast() {
    Toast.show("Coming soon", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
