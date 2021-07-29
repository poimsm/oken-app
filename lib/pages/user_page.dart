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
        appBar: BaseAppBar(title: 'Me', back: true, shadow: false),
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
              'MY WORDS (13)',
              style: TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.black.withOpacity(0.6)),
            ),
            Container(
                padding: EdgeInsets.only(
                    right: size.width * 0.06, top: size.width * 0.03),
                width: size.width,
                child: _words()),
            SizedBox(height: size.width * 0.02),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'vocabulary'),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff92D050),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.edit,
                      color: Colors.white, size: size.width * 0.06)),
            ),
            SizedBox(height: 10),
            Divider(),
            _menu(),
          ],
        ));
  }

  Widget _background() {
    return Container(color: Color(0xfff2f2f2));
  }

  Widget _words() {
    return Wrap(
      children: [
        SizedBox(height: size.width * 0.045),
        _element('Shattered'),
        SizedBox(height: size.width * 0.045),
        _element('Gimme a break!'),
        SizedBox(height: size.width * 0.045),
        _element('Hello'),
        SizedBox(height: size.width * 0.045),
        _element('Swoop'),
        SizedBox(height: size.width * 0.045),
        _element('A drawback'),
      ],
    );
  }

  Widget _element(text) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.width * 0.012, horizontal: size.width * 0.012),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1, color: Color(0xffBFBFBF))),
        child: Text(
          text,
          style:
              TextStyle(fontSize: size.width * 0.041, color: Color(0xff7F7F7F)),
        ),
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
          _item('Coins', coins: true),
          SizedBox(height: size.width * 0.045),
          _item('Change password'),
          SizedBox(height: size.width * 0.15),
          Container(
              width: size.width,
              alignment: Alignment.center,
              child: Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: size.width * 0.047,
                  color: Colors.red.withOpacity(0.8),
                ),
              ))
        ],
      ),
    );
  }

  Widget _item(txt, {coins}) {
    coins = coins == null ? false : coins;
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
          Row(
            children: [
              if (coins) _coins(),
              Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.4))
            ],
          )
        ],
      ),
    );
  }

  Widget _coins() {
    return Row(
      children: [
        Image.asset('assets/coin01.png', width: size.width * 0.065),
        SizedBox(width: 5),
        Text(
          '900',
          style: TextStyle(
            color: Colors.black54,
            fontSize: size.width * 0.047,
          ),
        )
      ],
    );
  }
}
