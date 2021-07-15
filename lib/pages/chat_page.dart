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

class _ChatPageState extends State<ChatPage> {
  String asd = '';
  bool showMenu = false;
  Size size;

  @override
  Widget build(BuildContext context) {
    final List<String> words = Provider.of<WordList>(context).wordlistAll;
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: baseAppBar(size, title: 'My words', back: true, search: true),
      body: Stack(children: [
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
            top: size.height * 0.2,
            left: 0,
            child: _word(),
          ),
        if (showMenu)
          Positioned(
            top: size.height * 0.3,
            left: 0,
            child: _menu(),
          ),
      ]),
    );
  }

  Widget _word() {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.043, horizontal: size.width * 0.04),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(asd,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.black.withOpacity(0.9),
                      ))
                ],
              ))),
    );
  }

  Widget _menu() {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.065, horizontal: size.width * 0.045),
          child: Column(
            children: [
              _menuItem(Icons.check, 'Known'),
              Divider(),
              _menuItem(Icons.sync, 'Relearn'),
              Divider(),
              _menuItem(Icons.delete_outline, 'Delete'),
            ],
          )),
    );
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
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.03, horizontal: size.width * 0.03),
        width: size.width,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(Icons.plus_one, color: Colors.grey, size: size.width * 0.07),
          IntrinsicWidth(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.2),
            ),
            width: size.width * 0.6,
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              style:
                  TextStyle(color: Colors.black, fontSize: size.width * 0.047),
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
                      height: size.width * 0.13,
                      width: size.width * 0.18,
                      child: Icon(Icons.create_outlined,
                          size: size.width * 0.1, color: Colors.white)),
                  onTap: () {
                    FocusScope.of(context).unfocus();
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
      padding: EdgeInsets.only(bottom: size.height * 0.1),
      child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return _item(words[index], index);
          }),
    );
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
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(text,
                style: TextStyle(
                    fontSize: size.width * 0.043,
                    color: Colors.black.withOpacity(0.7)))),
        SizedBox(height: 5),
        if (i.isOdd)
          Row(
            children: [
              Icon(LineIcons.check,
                  color: Colors.black54, size: size.width * 0.055),
              Text('Known',
                  style: TextStyle(
                      fontSize: size.width * 0.035, color: Colors.black54)),
              SizedBox(width: 10),
            ],
          ),
        if (!i.isOdd)
          Row(
            children: [
              Icon(LineIcons.alternateSync,
                  color: Colors.black54, size: size.width * 0.055),
              Text('Relearn',
                  style: TextStyle(
                      fontSize: size.width * 0.035, color: Colors.black54)),
              SizedBox(width: 10),
              Icon(LineIcons.clock,
                  color: Colors.black54, size: size.width * 0.055),
              Text('New',
                  style: TextStyle(
                      fontSize: size.width * 0.035, color: Colors.black54)),
              SizedBox(width: 10),
            ],
          )
      ]),
      SizedBox(width: 10),
      Image.asset('assets/pixel07.png', height: size.width * 0.09),
    ]);
  }

  void _toast() {
    Toast.show("Coming soon", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
