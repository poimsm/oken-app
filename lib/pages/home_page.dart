import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/content_provider.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:oken/constants/types.dart' as TYPES;
import 'package:oken/widgets/base_drawer.dart';
import 'package:oken/widgets/unlock_alert.dart';
import 'package:oken/widgets/vocab_btn.dart';
import 'package:toast/toast.dart';
import 'package:oken/constants/color.dart' as COLOR;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContentProvider contentProvider;

  Size size;

  @override
  Widget build(BuildContext context) {
    contentProvider = ContentProvider();
    size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: SafeArea(child: BaseDrawer()),
      appBar: BaseAppBar(coins: true),
      body: Container(
        color: Color(COLOR.GREEN),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                _pinGrid(context),
                Positioned(
                  bottom: size.height * 0.015,
                  left: 0,
                  child: _footerBar(context),
                ),
                Positioned(
                  bottom: 32,
                  left: 155,
                  child: VocabBtn(),
                ),
                // _categories(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
        color: Colors.white,
        child: Row(children: [
          _cat('Books', active: true),
          SizedBox(width: 8),
          _cat('Stories', active: false),
          SizedBox(width: 8),
          _cat('Images', active: false),
          SizedBox(width: 8),
          _cat('Quiz', active: false),
        ]));
  }

  Widget _cat(txt, {active}) {
    active = active ?? false;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
          color: active ? Color(COLOR.DARK_GREY) : Color(COLOR.GREY),
          borderRadius: BorderRadius.circular(50)),
      child: Text(txt,
          style: TextStyle(
            fontSize: 17,
            color: active ? Colors.white : Color(0xff595959),
          )),
    );
  }

  Widget _footerBar(context) {
    return Container(
      width: size.width,
      child: Center(
        child: Card(
          color: Colors.black.withOpacity(0.4),
          elevation: 3,
          child: Container(
              width: size.width * 0.75,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 45),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _icon(LineIcons.bars, page: 'menu', title: 'Menu'),
                    SizedBox(width: 30),
                    _icon(LineIcons.user, page: 'user', title: 'Me'),
                  ])),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon(icon, {title, page}) {
    return Builder(builder: (context) {
      return InkWell(
        customBorder: CircleBorder(),
          onTap: () {
            if (page == 'menu') {
              return Scaffold.of(context).openDrawer();
            }
            Navigator.pushNamed(context, page);
          },
          child: Column(
            children: [
              Icon(icon, color: Colors.white70, size: size.width * 0.08),
              Text(title, style: TextStyle(color: Colors.white70, fontSize: 13))
            ],
          ));
    });
  }

  Widget _pinGrid(context) {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 6, right: 6),
        child: _grid(context));
  }

  Widget _grid(context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: contentProvider.length(),
      itemBuilder: (BuildContext context, int index) => _cell(index, context),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }

  Widget _cell(i, context) {
    Map content = contentProvider.get(i);
    return InkWell(
      onTap: () {
        if (content['isBlocked']) return unlockPopup(content);
        Navigator.pushNamed(context, content['nav'], arguments: content);
      },
      child: Container(
          child: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(content['img']),
            ),
            if (content['isBlocked'])
              Positioned(right: 10, top: 10, child: _priceTag(content)),
          ]),
          SizedBox(height: 3),
          Text(
            content['title'],
            style:
                TextStyle(color: Colors.black87, fontSize: size.width * 0.045),
          ),
          // if (i == 1) SizedBox(height: 5),
          // if (i == 1) _counter(),
          SizedBox(height: 5),
          Row(
            children: [
              _typeTag(content['type']),
              if (content['isNew']) SizedBox(width: 7),
              if (content['isNew']) _newTag(),
              if (i == 1) SizedBox(width: 7),
              if (i == 1) _counter(),
            ],
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      )),
    );
  }

  Widget _counter() {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(COLOR.GREEN)),
            child: Text('29', style: TextStyle(color: Colors.white))),
        SizedBox(width: 2),
        Text(':'),
        SizedBox(width: 2),
        Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(COLOR.GREEN)),
            child: Text('03', style: TextStyle(color: Colors.white))),
      ],
    );
  }

  Widget _typeTag(type) {
    final iconTypes = {
      TYPES.QUIZ: 'Quiz',
      TYPES.BOOK: 'Book',
      TYPES.READING: 'Book',
      TYPES.PHOTOS: 'Photos',
      TYPES.ROUTINE: 'Routine',
    };

    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.7))),
        child: Text(iconTypes[type],
            style: TextStyle(fontSize: 13, color: Colors.black54)));
  }

  Widget _newTag() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3), color: Colors.redAccent),
        child:
            Text('New', style: TextStyle(fontSize: 13, color: Colors.white)));
  }

  Widget _priceTag(content) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              Icon(Icons.lock, color: Colors.white, size: size.width * 0.06),
              SizedBox(width: 5),
              Text(content['price'].toString() + ' ',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  unlockPopup(elem) {
    Future alert =
        showDialog(context: context, builder: (context) => UnlockAlert(elem));

    alert.then((val) {
      val = val ?? false;
      if (!val) return;
      _toast('Added');
    });
  }

  void _toast(txt) {
    Timer(
        Duration(milliseconds: 300),
        () => Toast.show(txt, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM));
  }
}
