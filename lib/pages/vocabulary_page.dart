import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:oken/widgets/vocabulary_appbar.dart';
import 'package:dotted_border/dotted_border.dart';

class VocabularyPage extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  Size size;
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: vocabularyAppBar(size, _tabController),
          body: TabBarView(
            children: [
              Stack(
                children: [
                  _list(),
                  Positioned(
                    bottom: 25,
                    right: 15,
                    child: _favBtn()
                  )
                ],
              ),
              _list(),
              _list(),
              _list(likedTab: true),
              Column(children: [
                _folderList(),
                SizedBox(height: 20),
                _folderBtn()
              ],)
            ],
          )),
    );
  }

  Widget _folderBtn() {
    return InkWell(
      // onTap: () => Navigator.pushNamed(context, 'add', arguments: {
      //   'header': 'New folder',
      //   'title': "Group your words in folders, let's learn!",
      //   'label': 'Enter folder name'
      // }),
      // onTap:() => _showMyDialog(),
      // onTap:() => _showAction(),
      // onTap:() => _showCupertino(),
      onTap:() => Navigator.pushNamed(context, 'folder'),

      child: DottedBorder(
        color: Color(0xffFFD966),
        borderType: BorderType.RRect,
        dashPattern: [8, 4],
        radius: Radius.circular(7),
        strokeWidth: 1,
        child: Container(
          color: Color(0xffFFF4D5),
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 25),
          child: Text('ADD FOLDER', style: TextStyle(
            fontSize: 14,
            color: Color(0xffBF9000)
          )))
      ),
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
          child: Icon(Icons.add, color: Colors.white)
        ),
    );
  }

  Widget _list({likedTab}) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          _item('Swoop', false, likedTab: likedTab),
          _item('Brimming with energy', false, likedTab: likedTab),
          _item('throw up', true, likedTab: likedTab),
          _item('hello', false, likedTab: likedTab),
          _item('Swoop', false, likedTab: likedTab),
          _item('Brimming with energy', false, likedTab: likedTab),
          _item('throw up', true, likedTab: likedTab),
          _item('hello', false, likedTab: likedTab),
          _item('Swoop', false, likedTab: likedTab),
          _item('Brimming with energy', false, likedTab: likedTab),
          _item('throw up', true, likedTab: likedTab),
          _item('hello', false, likedTab: likedTab),
        ],)
      ),
    );
  }

  Widget _item(txt, liked, {likedTab}) {
    likedTab = likedTab != null ? likedTab : false;
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
        if (likedTab) Icon(LineIcons.times, color: Colors.black26),
        if (!likedTab) Icon(  
        liked ? Icons.favorite :  LineIcons.heart, color: liked ? Color(0xffFF6565) : Color(0xffD9D9D9))        ]
      )
    );
  }


  _folderList() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          _folderItem('Dracula - Bram', 43),
          _folderItem('The War Of The Wolrds', 213),
          _folderItem('Treasure Island - Robert', 76),
          _folderItem('Complex', 81),
          _folderItem('Must-Know now', 9),
        ],)
      ),
    );
  }

  Widget _folderItem(String txt, int savedWords) {
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
        Row(
           mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.folder, color: Colors.black45),
            SizedBox(width: 10),
            Text(txt, style: TextStyle(fontSize: 18, color: Color(0xff7F7F7F)))
        ],),
        Row(children: [
          Text('(${savedWords.toString()})', style: TextStyle(
            fontSize: 18,
            color: Color(0xff7F7F7F),
          ),),
          Icon(Icons.chevron_right, color: Colors.black45)
        ],)
      ],)
    );
  }


  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
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

  void _showAction() {
    showModalBottomSheet(context: context, builder: (context) {
    return Container(
      color: Color(0xFF737373),
      height: 250,
      child: Container(
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               Row(children: [
                Icon(LineIcons.mitten, color: Colors.black87, size:22),
                SizedBox(width: 5),
                Text('Swoope', style: TextStyle(
                fontSize: 18,
                color: Colors.black87
              )),
              ],),
              SizedBox(height: 3),
              Row(children: [
                SizedBox(width: 10),
                Text('Dracula - Bram Rob', style: TextStyle(
                fontSize: 15,
                color: Colors.black54
              )),
              ],)
              ])
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            ListTile(
              title: Text('Known'),
              onTap: () => Navigator.pop(context)
            ),
            ListTile(
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context)
            ),
          ]
        ),
      ),
    );}
    );
  }

  void _showCupertino() {
    final sheet = CupertinoActionSheet(
      // title: Text('My title'),
      message: Text('Brimming with energy', style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.black87
      )),
      actions: [
        CupertinoActionSheetAction(
          child: Text('Relearn'),
          onPressed: (){},
        ),
        CupertinoActionSheetAction(
          child: Text('Known'),
          onPressed: (){},
        )
      ],
      cancelButton: CupertinoActionSheetAction(
          child: Text('Delete', style: TextStyle(color: Colors.red)),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
    );

    showCupertinoModalPopup(context: context, builder: (context) => sheet);
  }
}
