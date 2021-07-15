import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oken/widgets/base_appbar.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: baseAppBar(size, title: 'Me', back: true, shadow: false),
        body: Stack(children: [
          _background(),
          SingleChildScrollView(child: _body()),
        ]));
  }

  Widget _body() {
    return Container(
        padding: EdgeInsets.only(top: size.height * 0.05, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: size.width * 0.06),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/girl.jpg',
                          width: size.width * 0.2)),
                  SizedBox(width: size.width * 0.06),
                  Text(
                    '@poimsm320',
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.black.withOpacity(0.8)),
                  )
                ],
              ),
            ),
            SizedBox(height: size.width * 0.03),
            Divider(),
            SizedBox(height: size.width * 0.03),
            Text(
              'MY WORDS (15)',
              style: TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.black.withOpacity(0.6)),
            ),
            Container(
                padding: EdgeInsets.only(right: size.width * 0.06),
                width: size.width,
                child: _words()),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'chat'),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff92D050),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.edit,
                      color: Colors.white, size: size.width * 0.06)),
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
        SizedBox(height: size.width * 0.045),
        _element('Downwash'),
        SizedBox(height: size.width * 0.045),
        _element('Hello'),
        SizedBox(height: size.width * 0.045),
        _element('Briming with energy'),
        SizedBox(height: size.width * 0.045),
        _element('Swoope'),
        SizedBox(height: size.width * 0.045),
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
        style:
            TextStyle(fontSize: size.width * 0.041, color: Color(0xff7F7F7F)),
      ),
    );
  }

  Widget _menu() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: size.width * 0.045),
          _item('Email'),
          SizedBox(height: size.width * 0.045),
          _item('Coins'),
          SizedBox(height: size.width * 0.045),
          _item('Change password'),
          SizedBox(height: size.width * 0.08),
        ],
      ),
    );
  }

  Widget _item(txt) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
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
