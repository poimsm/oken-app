import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // final List<String> wordList = Provider.of<WordList>(context).wordlist;

    return Scaffold(
        appBar: baseAppBar(title: 'Me', back: true, shadow: false),
        body: Stack(children: [
          _background(),
          SingleChildScrollView(child: _body()),
        ]));
  }

  Widget _body() {
    return Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/girl.jpg', width: 70)),
                  SizedBox(width: 20),
                  Text(
                    '@poimsm320',
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'MY WORDS (15)',
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.6)),
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                width: MediaQuery.of(context).size.width,
                child: _words()),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'chat'),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff92D050),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.edit, color: Colors.white)),
            ),
            Divider(),
            _menu(),            
          ],
        ));
  }

  Widget _background() {
    return Container(color: Color(0xfff2f2f2));
  }

  Widget _words() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 15),
        _element('Downwash'),
        SizedBox(height: 15),
        _element('Hello'),
        SizedBox(height: 15),
        _element('Briming with energy'),
        SizedBox(height: 15),
        _element('Swoope'),
        SizedBox(height: 15),
        _element('Abvode mentioned'),
      ],
    );
  }

  Widget _element(text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: Color(0xffBFBFBF))),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, color: Color(0xff7F7F7F)),
      ),
    );
  }

  Widget _menu() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15),
          _item('Email'),
          SizedBox(height: 15),
          _item('Coins'),
          SizedBox(height: 15),
          _item('Change password'),
        ],
      ),
    );
  }

  Widget _item(txt) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt,
            style:
                TextStyle(fontSize: 17, color: Colors.black.withOpacity(0.8)),
          ),
          Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.4))
        ],
      ),
    );
  }
}
