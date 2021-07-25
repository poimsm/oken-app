import 'package:flutter/material.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart';
import 'package:oken/utils/text_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Memory extends StatefulWidget {
  bool showWords = false;
  bool lightMode = false;
  String timelinePath;
  Color textColor;
  Color loaderColor;

  Memory(this.showWords, [this.lightMode = false]);

  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  Size size;
  VocabProvider vocabulary;

  @override
  Widget build(BuildContext context) {
    vocabulary = Provider.of<VocabProvider>(context);
    size = MediaQuery.of(context).size;

    widget.timelinePath =
        widget.lightMode ? 'assets/timeline.png' : 'assets/time_black.png';

    widget.textColor = widget.lightMode ? Colors.white : Colors.black;

    widget.loaderColor = widget.lightMode
        ? Colors.white.withOpacity(0.7)
        : Color(0xff92D050).withOpacity(0.6);

    return Container(
        height: widget.showWords ? size.height * 0.28 : size.height * 0.25,
        child: _shifter());
  }

  Widget _shifter() {
    if (vocabulary.loading && widget.showWords) {
      return SpinKitRotatingCircle(
        color: widget.loaderColor,
        size: size.width * 0.16,
      );
    }
    return _stack();
  }

  Widget _stack() {
    List words = vocabulary.firstThreeWords;
    Helper helper = Helper();

    if (words.length < 3) return Container();

    return Stack(
      children: [
        if (widget.showWords)
          Positioned(
              child:
                  Image.asset(widget.timelinePath, height: size.height * 0.26),
              top: 0,
              left: size.width * 0.29),
        if (!widget.showWords)
          Positioned(
              child: Container(
                child: Column(
                  children: [
                    Image.asset('assets/chat01.png',
                        width: size.width * 0.15,
                        fit: BoxFit.fill,
                        color: Color(0xff92D050).withOpacity(0.45)),
                    Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('V O C A B U L A R Y',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff92D050).withOpacity(0.5)))),
                  ],
                ),
              ),
              top: size.height * 0.07,
              left: size.width * 0.2),
        if (widget.showWords)
          Positioned(
              child: Text(
                helper.toCapital(words[0]['title']),
                style: TextStyle(
                    fontSize: size.width * 0.05, color: widget.textColor),
              ),
              top: 0,
              left: size.width * 0.36),
        if (widget.showWords)
          Positioned(
              child: Container(
                width: 190,
                child: Text(
                  helper.toCapital(words[1]['title']),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: size.width * 0.05, color: widget.textColor),
                ),
              ),
              top: size.height * 0.137,
              left: size.width * 0.03),
        if (widget.showWords)
          Positioned(
              child: Container(
                width: words[2]['title'].length < 10
                    ? size.width * 0.35
                    : words[2]['title'].length < 16
                        ? size.width * 0.4
                        : size.width * 0.45,
                child: Text(
                  helper.toCapital(words[2]['title']),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: size.width * 0.05, color: widget.textColor),
                ),
              ),
              top: TextSize(helper.toCapital(words[2]['title']))
                      .isGreaterThan(size.width * 0.45, 17.5)
                  ? size.height * 0.18
                  : size.height * 0.2,
              left: 0)
      ],
    );
  }
}
