import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/photo_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/widgets/audiobar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  PhotoProvider imgsProvider;
  TimerProvider timer;

  void scrollToBottom() {
    if (hasScrolled) return;
    Timer(Duration(milliseconds: 3500), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      hasScrolled = true;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    SystemChrome.setEnabledSystemUIOverlays([]);

    timer = Provider.of<TimerProvider>(context, listen: false);
    imgsProvider = Provider.of<PhotoProvider>(context, listen: false);
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    timer.stop();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  bool isPristine = true;
  bool hasScrolled = false;
  Map args;
  Size size;

  @override
  Widget build(BuildContext context) {
    Provider.of<PhotoProvider>(context);
    size = MediaQuery.of(context).size;

    if (isPristine) {
      args = ModalRoute.of(context).settings.arguments;
      imgsProvider.loadImgs(args['pack']);
      imgsProvider.setFistImg();
      isPristine = false;
    }

    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      SingleChildScrollView(
        controller: _scrollController,
        child: _background(),
      ),
      if (imgsProvider.showButtons)
        Positioned(child: _back(), top: size.height * 0.04, left: 20),
      if (imgsProvider.showButtons)
        Positioned(child: _settings(), top: size.height * 0.04, right: 20),
      if (imgsProvider.showButtons && !imgsProvider.isTalking)
        Positioned(child: _bullets(), left: 0, top: size.height * 0.11),
      if (imgsProvider.showButtons)
        Positioned(child: _switchers(), left: 0, top: size.height * 0.37),
      if (imgsProvider.isTalking)
        Positioned(
            child: Audiobar(small: true, shiftDimensions: true), left: size.width * 0.38, top: 190),
      if (imgsProvider.isTalking)
        Positioned(child: Clock(), left: 0, top: size.height * 0.05),
      Positioned(child: _menu(), left: 0, bottom: size.height * 0.05)
    ])));
  }

  Widget _background() {
    String imageURL = imgsProvider.imgUrl;

    return Image.network(
      imageURL,
      width: size.width,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          scrollToBottom();
          return child;
        }
        return Container(
            color: Colors.black.withOpacity(0.7),
            height: size.height,
            width: size.width,
            child: Center(
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: size.height * 0.18,
              ),
            ));
      },
    );
  }

  Widget _back() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.05),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.black.withOpacity(0.5),
            child: Icon(Icons.arrow_back,
                color: Colors.white, size: size.height * 0.095)),
      ),
    );
  }

  Widget _settings() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.045),
      child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.black.withOpacity(0.5),
          child: Icon(Icons.settings,
              color: Colors.white, size: size.height * 0.085)),
    );
  }

  Widget _bullets() {
    return Container(
      width: size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _oneBullet(imgsProvider.index < 0),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 1),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 2),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 3),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 4),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 5),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 6),
        SizedBox(width: 6),
        _oneBullet(imgsProvider.index < 7),
      ]),
    );
  }

  Widget _oneBullet(isLight) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Container(
          height: 4,
          width: size.width * 0.065,
          color: Colors.white.withOpacity(isLight ? 0.2 : 1)),
    );
  }

  Widget _switchers() {
    return Container(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: () => imgsProvider.decreaseIndex(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black.withOpacity(0.5),
                  child: Icon(LineIcons.angleLeft,
                      color: Colors.white, size: size.height * 0.19),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.45),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: () => imgsProvider.increaseIndex(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black.withOpacity(0.5),
                  child: Icon(LineIcons.angleRight,
                      color: Colors.white, size: size.height * 0.19),
                ),
              ),
            )
          ],
        ));
  }

  Widget _menu() {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imgsProvider.showButtons) _mic(),
          if (!imgsProvider.showButtons) SizedBox(),
          Container(
            width: size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _toggle(),
                if (imgsProvider.showButtons) _labels(),
                if (!imgsProvider.showButtons) SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mic() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.03),
      child: InkWell(
        onTap: () {
          if (timer.time > 1) {
            timer.stop();
            imgsProvider.toggleIsTalking();
          } else {
            timer.start();
            imgsProvider.toggleIsTalking();
          }
        },
        // onLongPress: () {
        //   timer.start();
        //   imgsProvider.toggleIsTalking();
        // },
        child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.all(5),
            child:
                Icon(Icons.mic, color: Colors.white, size: size.height * 0.12)),
      ),
    );
  }

  Widget _toggle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.055),
      child: InkWell(
        onLongPress: () => imgsProvider.toggleShowButtons(),
        child: Listener(
          onPointerUp: (e) => imgsProvider.toggleShowButtons(),
          child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.hide_source,
                  color: Colors.white, size: size.height * 0.08)),
        ),
      ),
    );
  }

  Widget _labels() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.055),
      child: InkWell(
        onTap: () => imgsProvider.toggleHints(),
        child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.label_outline,
                color: Colors.white, size: size.height * 0.08)),
      ),
    );
  }
}

class Clock extends StatelessWidget {
  const Clock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerProvider timer = Provider.of<TimerProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.black.withOpacity(0.5),
          child: Text(timer.time.toString(),
              style:
                  TextStyle(color: Colors.white, fontSize: size.height * 0.07)),
        ),
      ),
    );
  }
}
