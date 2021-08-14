import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/photo_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/widgets/audio_bar.dart';
import 'package:oken/widgets/audio_list_photo.dart';
import 'package:oken/widgets/microphone_photo.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ImagePage extends StatefulWidget {
  ImagePage({Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  PhotoProvider photoProvider;
  AudioProvider audioProvider;

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
    super.initState();
  }

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    audioProvider.onDispose();
    super.dispose();
  }

  bool isPristine = true;
  bool hasScrolled = false;
  Map args;
  Size size;

  @override
  Widget build(BuildContext context) {
    Provider.of<PhotoProvider>(context);
    photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    size = MediaQuery.of(context).size;
    audioProvider = Provider.of<AudioProvider>(context);

    if (isPristine) {
      args = ModalRoute.of(context).settings.arguments;
      photoProvider.loadImgs(args['pack']);
      photoProvider.setFistImg();
      isPristine = false;
    }

    return SafeArea(
        child: GestureDetector(
      onTap: () => audioProvider.reset(setState: true),
      child: Scaffold(
          body: Stack(children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: _background(),
        ),
        if (photoProvider.showButtons)
          Positioned(child: _back(), top: size.height * 0.04, left: 20),
        if (photoProvider.showButtons)
          Positioned(child: _settings(), top: size.height * 0.04, right: 20),
        if (photoProvider.showButtons)
          Positioned(child: _switchers(), left: 0, top: size.height * 0.37),
        Positioned(child: Clock(), left: 0, top: size.height * 0.05),
        Positioned(child: _menu(), left: 0, bottom: size.height * 0.05),
        if (photoProvider.showAudioList)
          Positioned(child: AudioListPhoto(), right: 0, bottom: 0),
        AudioBar(
          small: true,
          shiftDimensions: true,
          leftOffset: size.width * 0.33,
          bottomOffset: 150.0,
          bottomCardOffset: 130.0,
        ),
      ])),
    ));
  }

  Widget _background() {
    String imageURL = photoProvider.imgUrl;

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
    return InkWell(
      onTap: () => photoProvider.showAudioList = true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.black.withOpacity(0.2),
            child: Row(
              children: [
                Icon(Icons.music_note, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Records (${audioProvider.userAudios.length})',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _bullets() {
    return Container(
      width: size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _oneBullet(photoProvider.index < 0),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 1),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 2),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 3),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 4),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 5),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 6),
        SizedBox(width: 0),
        _oneBullet(photoProvider.index < 7),
      ]),
    );
  }

  Widget _oneBullet(isLight) {
    Widget circle = Container(
      height: 15,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.black.withOpacity(0.2)),
    );

    Widget stick = Container(
      height: 15,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0), color: Colors.white),
    );

    return isLight ? circle : stick;
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
                onTap: () => photoProvider.decreaseIndex(),
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
                onTap: () => photoProvider.increaseIndex(),
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
          if (photoProvider.showButtons) MicrophonePhoto(),
          if (!photoProvider.showButtons) SizedBox(),
          Container(
            width: size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _toggle(),
                if (photoProvider.showButtons) _labels(),
                if (!photoProvider.showButtons) SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _toggle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.height * 0.055),
      child: InkWell(
        onLongPress: () => photoProvider.toggleShowButtons(),
        child: Listener(
          onPointerUp: (e) => photoProvider.toggleShowButtons(),
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
        onTap: () => photoProvider.toggleHints(),
        child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.extension_outlined,
                color: Colors.white, size: size.height * 0.08)),
      ),
    );
  }
}

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerProvider timerProvider = Provider.of<TimerProvider>(context);
    AudioProvider audioProvider = Provider.of<AudioProvider>(context);
    Size size = MediaQuery.of(context).size;

    return audioProvider.isTalking
        ? Container(
            width: size.width,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.5),
                child: Text(timerProvider.time.toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: size.height * 0.07)),
              ),
            ),
          )
        : Container();
  }
}
