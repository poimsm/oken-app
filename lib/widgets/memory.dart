import 'package:flutter/material.dart';
import 'package:oken/providers/word_provider.dart';
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
  WordProvider words;
  Size size;

  @override
  Widget build(BuildContext context) {
    words = Provider.of<WordProvider>(context);
    size = MediaQuery.of(context).size;

    widget.timelinePath =
        widget.lightMode ? 'assets/timeline.png' : 'assets/time_black.png';

    widget.textColor = widget.lightMode ? Colors.white : Colors.black;

    widget.loaderColor = widget.lightMode
        ? Colors.white.withOpacity(0.7)
        : Color(0xff92D050).withOpacity(0.6);

    return Container(
        height: widget.showWords ? size.height * 0.28 : size.height * 0.15,
        child: _shifter());
  }

  Widget _shifter() {
    if (words.loading && widget.showWords) {
      return SpinKitRotatingCircle(
        color: widget.loaderColor,
        size: size.width * 0.16,
      );
    }
    return _stack();
  }

  Widget _stack() {
    return Stack(
      children: [
        if (widget.showWords)
          Positioned(
              child:
                  Image.asset(widget.timelinePath, height: size.height * 0.26),
              top: 0,
              left: size.width * 0.29),
        // if (widget.showWords)
        //   Positioned(
        //       child: Image.asset('assets/chat01.png',
        //           width: size.width * 0.15,
        //           color: Color(0xff92D050).withOpacity(0.9),
        //           fit: BoxFit.fill),
        //       top: size.height * 0.07,
        //       left: size.width * 0.08),
        if (!widget.showWords)
          Positioned(
              child: Image.asset('assets/chat01.png',
                  width: size.width * 0.15,
                  fit: BoxFit.fill,
                  color: Color(0xff92D050).withOpacity(0.45)),
              top: size.height * 0.07,
              left: size.width * 0.32),
        if (widget.showWords)
          Positioned(
              child: Text(
                words.firstThreeWords[0],
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
                  words.firstThreeWords[1],
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
                width: words.firstThreeWords[2].length < 10
                    ? size.width * 0.35
                    : words.firstThreeWords[2].length < 16
                        ? size.width * 0.4
                        : size.width * 0.45,
                child: Text(
                  words.firstThreeWords[2],
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: size.width * 0.05, color: widget.textColor),
                ),
              ),
              top: TextSize(words.firstThreeWords[2])
                      .isGreaterThan(size.width * 0.45, 17.5)
                  ? size.height * 0.18
                  : size.height * 0.2,
              left: 0)
      ],
    );
  }
}
