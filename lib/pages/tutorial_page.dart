import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:oken/constants/color.dart' as COLOR;

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: BaseAppBar(title: 'Tutorial', back: true, shadow: false),
        body: Stack(children: [
          _background(),
          SingleChildScrollView(child: _body()),
        ]));
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Instructions'),
          SizedBox(height: 15),
          _text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.'),
          SizedBox(height: 15),
          _infographic(
              'https://res.cloudinary.com/ddon9fx1n/image/upload/v1626324679/j04.png'),
          SizedBox(height: 15),
          _text(
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.'),
          SizedBox(height: 15),
          _infographic(
              'https://res.cloudinary.com/ddon9fx1n/image/upload/v1626324696/j06.png'),
          SizedBox(height: 15),
          _text('Duis aute irure dolor in reprehenderit in voluptate.'),
          SizedBox(height: 5),
          _text(
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
          SizedBox(height: 15),
          _infographic(
              'https://res.cloudinary.com/ddon9fx1n/image/upload/v1626324696/j01.png'),
          SizedBox(height: 15),
          _text(
              'Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil!'),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _title(String txt) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: size.width * 0.075, color: Color(COLOR.DARK_GREY)),
    );
  }

  Widget _text(String txt) {
    return Text(txt,
        style: TextStyle(fontSize: size.width * 0.047, color: Colors.black54));
  }

  Widget _infographic(String imageURL) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'viewer', arguments: {'url': imageURL}),
      child: Stack(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageURL,
                height: size.height * 0.6,
                width: size.width * 0.9,
                fit: BoxFit.cover)),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.fullscreen,
                  color: Colors.white, size: size.width * 0.085)),
        )
      ]),
    );
  }

  Widget _background() {
    return Container(color: Color(COLOR.ALMOST_WHITE));
  }
}
