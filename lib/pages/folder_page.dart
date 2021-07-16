import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/widgets/base_appbar.dart';

class FolderPage extends StatefulWidget {
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: baseAppBar(size, title: 'Dracula - Bram Robe', back: true, shadow: false),
        body: _body()
    );
  }

  Widget _body() {
    return _list();
  }


  Widget _list() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          _item('Swoop', false),
          _item('Brimming with energy', false),
          _item('throw up', true),
          _item('hello', false),
          _item('Swoop', false),
          _item('Brimming with energy', false),
          _item('throw up', true),
          _item('hello', false),
          _item('Swoop', false),
          _item('Brimming with energy', false),
          _item('throw up', true),
          _item('hello', false),
        ],)
      ),
    );
  }

  Widget _item(txt, liked) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffE7E6E6))
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        SizedBox(width: 1),
        Text(txt, style: TextStyle(
          color: Color(0xff7F7F7F),
          fontSize: 18
        ),),
        Icon(liked ? Icons.favorite :  LineIcons.heart, color: liked ? Color(0xffFF6565) : Color(0xffD9D9D9))        ]
      )
    );
  }
  
}
