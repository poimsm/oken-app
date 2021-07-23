import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart';
import 'package:oken/widgets/vocab_actionsheet.dart';
import 'package:oken/widgets/vocab_appbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class VocabPage extends StatefulWidget {
  @override
  _VocabPageState createState() => _VocabPageState();
}

class _VocabPageState extends State<VocabPage> with TickerProviderStateMixin {
  Size size;
  TabController _tabController;
  VocabProvider vocabulary;
  int currIndex = 0;
  int oldIndex = 0;

  String getTab(index) {
    switch (index) {
      case 0:
        return 'new';
      case 1:
        return 'relearn';
      case 2:
        return 'known';
      case 3:
        return 'liked';
      default:
        return 'new';
    }
  }

  @override
  void initState() {
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    vocabulary.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Provider.of<VocabProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: vocabAppBar(size, _tabController),
          body: TabBarView(
            controller: _tabController,
            children: [
              Stack(
                children: [
                  _list('latest'),
                  Positioned(
                      bottom: size.width * 0.066,
                      right: size.width * 0.045,
                      child: _favBtn())
                ],
              ),
              _list('known'),
              _list('liked'),
              _folderList(),
            ],
          )),
    );
  }

  Widget _folderBtn() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'add', arguments: {
        'header': 'New folder',
        'title': "Group your words in folders, let's learn!",
        'label': 'Enter folder name'
      }),
      child: DottedBorder(
          color: Color(0xffFFD966),
          borderType: BorderType.RRect,
          dashPattern: [8, 4],
          radius: Radius.circular(7),
          strokeWidth: 1,
          child: Container(
              color: Color(0xffFFF4D5),
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
              child: Text('ADD FOLDER',
                  style: TextStyle(fontSize: 14, color: Color(0xffBF9000))))),
    );
  }

  Widget _favBtn() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'add', arguments: {
        'header': 'New word',
        'title': 'Create a new word to study it!',
        'label': 'Enter a new word…'
      }),
      child: Container(
          height: size.width * 0.15,
          width: size.width * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xff92D050),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.add, color: Colors.white, size: size.width * 0.07)),
    );
  }

  Widget _list(String type) {
    List words = vocabulary.getWords(type);
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(children: [
            ...List.generate(
                words.length,
                (i) => _item(
                      words[i],
                      type,
                    )),
            SizedBox(height: 100),
          ])),
    );
  }

  Widget _item(elem, type) {
    bool likedTab = type == 'liked';

    return Container(
        width: size.width,
        padding:
            EdgeInsets.symmetric(vertical: 8, horizontal: size.width * 0.052),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffE7E6E6)))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () {
              if (type == 'liked') return;
              _presentActionSheet(elem, type);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              alignment: Alignment.center,
              child: Text(
                Helper().toCapital(elem['title']),
                style: TextStyle(
                    color: Color(0xff7F7F7F), fontSize: size.width * 0.052),
              ),
            ),
          ),
          if (likedTab)
            InkWell(
                onTap: () => vocabulary.removeFromLikedList(elem['id']),
                child: Icon(LineIcons.times,
                    color: Colors.black26, size: size.width * 0.065)),
          if (!likedTab)
            InkWell(
              onTap: () => vocabulary.likeWord(elem['id']),
              child: Icon(elem['liked'] ? Icons.favorite : LineIcons.heart,
                  color: elem['liked'] ? Color(0xffFF6565) : Color(0xffD9D9D9),
                  size: size.width * 0.065),
            )
        ]));
  }

  _folderList() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: size.width * 0.052),
          child: Column(
              children: List.generate(vocabulary.folders.length,
                  (index) => _folderItem(vocabulary.folders[index])))),
    );
  }

  Widget _folderItem(elem) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'folder', arguments: elem),
      child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.048, horizontal: size.width * 0.052),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffE7E6E6)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.folder,
                      color: Colors.black45, size: size.width * 0.065),
                  SizedBox(width: 10),
                  Container(
                    width: size.width * 0.6,
                    child: Text(elem['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: Color(0xff7F7F7F))),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '(${elem['total_words'].toString()})',
                    style: TextStyle(
                      fontSize: size.width * 0.052,
                      color: Color(0xff7F7F7F),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.black45)
                ],
              )
            ],
          )),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove folder and words?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This action will also remove the words from the folder.'),
                SizedBox(height: 5),
                Text('Do you want to Continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _presentActionSheet(elem, type) {
    Future modal = showModalBottomSheet(
        context: context,
        builder: (context) {
          bool knownTab = type == 'known';
          return VocabActionSheet(elem, knownTab);
        });
    modal.then((val) {
      switch (val) {
        case 'delete':
          _toast('Deleted');
          break;
        case 'copy':
          _toast('Copied');
          break;
      }
    });
  }

  void _toast(txt) {
    Timer(
        Duration(milliseconds: 300),
        () => Toast.show(txt, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM));
  }
}
