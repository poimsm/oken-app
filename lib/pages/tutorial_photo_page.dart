import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oken/constants/color.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/photo_provider.dart';
import 'package:flutter/services.dart';

class TutorialPhotoPage extends StatefulWidget {
  TutorialPhotoPage({Key key}) : super(key: key);

  @override
  _TutorialPhotoPageState createState() => _TutorialPhotoPageState();
}

class _TutorialPhotoPageState extends State<TutorialPhotoPage> {
  PhotoProvider photoProvider;
  AudioProvider audioProvider;
  SwiperController _controller = new SwiperController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  void setOrentation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  bool shouldSetOrentation = true;

  @override
  void dispose() {
    if (shouldSetOrentation) {
      setOrentation();
    }
    super.dispose();
  }

  Size size;
  Map args;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(height: size.height, width: size.width, child: _swiper()),
    );
  }

  Widget _swiper() {
    return Swiper(
        scrollDirection: Axis.horizontal,
        duration: 800,
        loop: false,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => _slides(index),
        viewportFraction: 1,
        scale: 1,
        controller: _controller,
        pagination: new SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
          return Align(
              alignment: Alignment.bottomCenter,
              child: _bullets(config.activeIndex, config.controller));
        }));
  }

  Widget _slides(index) {
    if (index == 0) return _slideA();
    if (index == 1) return _slideB();
    return _slideC();
  }

  _slideA() {
    return Container(
        child: Stack(
      children: [
        Container(),
        Positioned(top: 20, left: 20, child: _back()),
        Positioned(top: 80, left: 60, child: _describe()),
        Positioned(top: 210, left: 100, child: _oneMin()),
        Positioned(bottom: 20, left: 100, child: _next()),
        Positioned(bottom: 0, right: 0, child: _rightBoxA()),
      ],
    ));
  }

  _slideB() {
    return Container(
        child: Stack(
      children: [
        Container(),
        Positioned(top: 20, left: 20, child: _back()),
        Positioned(top: 80, left: 60, child: _smileTile()),
        Positioned(top: 180, left: 50, child: _micTile()),
        Positioned(bottom: 20, left: 100, child: _next()),
        Positioned(bottom: 0, right: 0, child: _rightBoxB()),
      ],
    ));
  }

  _slideC() {
    return Container(
        child: Stack(
      children: [
        Container(),
        Positioned(top: 20, left: 20, child: _back()),
        Positioned(top: 80, left: 60, child: _example()),
        Positioned(top: 180, left: 80, child: _play()),
        Positioned(bottom: 20, left: 100, child: _startTalking()),
        Positioned(bottom: 0, right: 0, child: _rightBoxC()),
      ],
    ));
  }

  _back() {
    return InkWell(
        customBorder: CircleBorder(),
        onTap: () => Navigator.pop(context),
        child: Container(
            padding: EdgeInsets.all(7),
            child: Image.asset('assets/tutorial/t06.png', width: 40)));
  }

  _example() {
    return Image.asset('assets/tutorial/t01.png', width: 250);
  }

  _startTalking() {
    return InkWell(
      onTap: () {
        shouldSetOrentation = false;
        Navigator.pushReplacementNamed(context, 'photos', arguments: args);
      },
      child: Container(
        padding: EdgeInsets.all(7),
        child: Row(
          children: [
            Text('Start talking',
                style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(width: 10),
            Image.asset('assets/tutorial/t10.png', width: 30)
          ],
        ),
      ),
    );
  }

  _play() {
    return Image.asset('assets/tutorial/t14.png', width: 230);
  }

  _smileTile() {
    return Row(children: [
      Stack(children: [
        Container(
          margin: EdgeInsets.only(bottom: 20, left: 0),
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(SUPER_LIGHT_GREY),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 5,
            child: Image.asset('assets/tutorial/t05.png', width: 50)),
      ]),
      SizedBox(width: 20),
      Container(
        width: 300,
        child: Text(
            'Look at the picture carefully and take a few moments to think before you start talking.',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            )),
      )
    ]);
  }

  _micTile() {
    return Row(children: [
      Stack(children: [
        Container(
          margin: EdgeInsets.only(bottom: 50, left: 20),
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(SUPER_LIGHT_GREY),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 0,
            child: Image.asset('assets/tutorial/t04.png', width: 90)),
      ]),
      SizedBox(width: 20),
      Container(
        width: 300,
        child: Text('You have one minute to do the task, use every second!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            )),
      )
    ]);
  }

  _describe() {
    return Image.asset('assets/tutorial/t09.png', width: 300);
  }

  _oneMin() {
    return Column(
      children: [
        Text('IN 1 MIN', style: TextStyle(fontSize: 22, color: Colors.black54)),
        Image.asset('assets/tutorial/t08.png',
            width: 110, color: Color(0xff8C5E44))
      ],
    );
  }

  _next() {
    return InkWell(
      onTap: () => _controller.next(),
      child: Container(
        padding: EdgeInsets.all(7),
        child: Row(
          children: [
            Text('Next', style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(width: 10),
            Image.asset('assets/tutorial/t10.png', width: 30)
          ],
        ),
      ),
    );
  }

  _rightBoxA() {
    return Image.asset('assets/tutorial/t13.png', height: size.height);
  }

  _rightBoxB() {
    return Stack(children: [
      Image.asset('assets/tutorial/t13.png', height: size.height),
      Positioned(
          top: 120,
          right: 90,
          child: Image.asset('assets/tutorial/t03.png', height: 180))
    ]);
  }

  _rightBoxC() {
    return Stack(children: [
      Container(width: 450, height: size.height),
      Positioned(
        right: 0,
        bottom: 0,
        child: Image.asset('assets/tutorial/t13.png', height: size.height),
      ),
      Positioned(
          top: 80,
          right: 30,
          child: Image.asset('assets/tutorial/t02.png', width: 370))
    ]);
  }

  _bullets(index, controller) {
    return IntrinsicWidth(
      child: Row(
        children: [
          _oneBullet(0, index == 0, controller),
          _oneBullet(1, index == 1, controller),
          _oneBullet(2, index == 2, controller),
        ],
      ),
    );
  }

  _oneBullet(int index, bool active, SwiperController controller) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        if (index == 2 && active) return;
        controller.move(index);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20, right: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(active ? GREEN : LIGHT_GREY),
        ),
        height: 27,
        width: 27,
      ),
    );
  }
}
