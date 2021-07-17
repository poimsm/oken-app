import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocabulary_provider.dart';
import 'package:oken/widgets/vocabulary_appbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class VocabularyPage extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage>
    with TickerProviderStateMixin {
  Size size;
  TabController _tabController;
  VocabularyProvider vocabulary;
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
    vocabulary = Provider.of<VocabularyProvider>(context, listen: false);
    vocabulary.load();
    // _tabController =
    //     TabController(length: 5, vsync: this, initialIndex: 0);
    // _tabController.addListener(() {
    //   currIndex = _tabController.index;
    //   vocabulary.setWords(getTab(_tabController.index));
    //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Provider.of<VocabularyProvider>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: vocabularyAppBar(size, _tabController),
          body: TabBarView(
            controller: _tabController,
            children: [
              Stack(
                children: [
                  _list('latest'),
                  Positioned(bottom: 25, right: 15, child: _favBtn())
                ],
              ),
              _list('relearn'),
              _list('known', knownTab: true),
              _list('liked', likedTab: true),
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
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xff92D050),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.add, color: Colors.white)),
    );
  }

  Widget _list(String type, {likedTab, knownTab}) {
    List words = vocabulary.getWords(type);
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: List.generate(
                words.length,
                (i) => _item(
                      words[i],
                      type,
                    )),
          )),
    );
  }

  Widget _item(elem, type) {
    bool likedTab = type == 'liked';

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: Text(
                elem['title'],
                style: TextStyle(color: Color(0xff7F7F7F), fontSize: 18),
              ),
            ),
          ),
          if (likedTab)
            InkWell(
                onTap: () => vocabulary.removeFromLikedList(elem['id']),
                child: Icon(LineIcons.times, color: Colors.black26)),
          if (!likedTab)
            InkWell(
              onTap: () => vocabulary.likeWord(elem['id']),
              child: Icon(elem['liked'] ? Icons.favorite : LineIcons.heart,
                  color: elem['liked'] ? Color(0xffFF6565) : Color(0xffD9D9D9)),
            )
        ]));
  }

  _folderList() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
              children: List.generate(vocabulary.folders.length,
                  (index) => _folderItem(vocabulary.folders[index])))),
    );
  }

  Widget _folderItem(elem) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'folder', arguments: elem),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffE7E6E6)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.folder, color: Colors.black45),
                  SizedBox(width: 10),
                  Text(elem['name'],
                      style: TextStyle(fontSize: 18, color: Color(0xff7F7F7F)))
                ],
              ),
              Row(
                children: [
                  Text(
                    '(${elem['total_words'].toString()})',
                    style: TextStyle(
                      fontSize: 18,
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          bool knownTab = type == 'known';
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: _actionSheetBody(elem, knownTab),
            ),
          );
        });
  }

  Widget _actionSheetBody(elem, knownTab) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 30),
      _actionSheetHeader(elem),
      SizedBox(height: 10),
      Divider(),
      SizedBox(height: 10),
      ListTile(
          title: Text(knownTab ? 'Relearn' : 'Known'),
          onTap: () {
            if (knownTab) {
              vocabulary.markAsRelearn(elem['id']);
            } else {
              vocabulary.markAsKnown(elem['id']);
            }
            Navigator.pop(context);
          }),
      ListTile(
          title: Text('Delete', style: TextStyle(color: Colors.red)),
          onTap: () {
            vocabulary.deleteWord(elem);
            Navigator.pop(context);
          }),
    ]);
  }

  Widget _actionSheetHeader(elem) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Icon(LineIcons.mitten, color: Colors.black87, size: 22),
              SizedBox(width: 5),
              Text(elem['title'],
                  style: TextStyle(fontSize: 18, color: Colors.black87)),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: [
              SizedBox(width: 10),
              Text(elem['folder_name'],
                  style: TextStyle(fontSize: 15, color: Colors.black54)),
            ],
          )
        ]));
  }
}
