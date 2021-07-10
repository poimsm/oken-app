import 'package:flutter/material.dart';
import 'package:oken/providers/word_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Memory extends StatefulWidget {
  bool showWords = false;
  bool lightMode = false;
  String timeline_path;
  Color text_color;
  Color loader_color;

  Memory(this.showWords, [this.lightMode = false]);

  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  WordProvider words;

  @override
  Widget build(BuildContext context) {
    words = Provider.of<WordProvider>(context);

    widget.timeline_path =
        widget.lightMode ? 'assets/timeline.png' : 'assets/time_black.png';

    widget.text_color = widget.lightMode ? Colors.white : Colors.black;

    widget.loader_color = widget.lightMode
        ? Colors.white.withOpacity(0.7)
        : Color(0xff92D050).withOpacity(0.6);

    return Container(height: widget.showWords ? 200 : 100, child: _shifter());
  }

  Widget _shifter() {
    if (words.loading && widget.showWords) {
      return SpinKitRotatingCircle(
        color: widget.loader_color,
        size: 50.0,
      );
    }
    return _stack();
  }

  Widget _stack() {
    return Stack(
      children: [
        if (widget.showWords)
          Positioned(
              child: Image.asset(widget.timeline_path, height: 200),
              top: 0,
              left: 100),
        if (widget.showWords)
          Positioned(
              child: Image.asset('assets/chat01.png',
                  width: 50,
                  color: Color(0xff92D050).withOpacity(0.9),
                  fit: BoxFit.fill),
              top: 50,
              left: 30),
        if (!widget.showWords)
          Positioned(
              child: Image.asset('assets/chat01.png',
                  width: 50,
                  fit: BoxFit.fill,
                  color: Color(0xff92D050).withOpacity(0.45)),
              top: 50,
              left: 125),
        if (widget.showWords)
          Positioned(
              child: Text(
                words.firstThreeWords[0],
                style: TextStyle(fontSize: 17.5, color: widget.text_color),
              ),
              top: 0,
              left: 130),
        if (widget.showWords)
          Positioned(
              child: Container(
                width: 190,
                child: Text(
                  words.firstThreeWords[1],
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 17.5, color: widget.text_color),
                ),
              ),
              top: 105,
              left: 10),
        if (widget.showWords)
          Positioned(
              child: Container(
                width: words.firstThreeWords[2].length < 10
                    ? 130
                    : words.firstThreeWords[2].length < 16
                        ? 150
                        : 170,
                child: Text(
                  words.firstThreeWords[2],
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 17.5, color: widget.text_color),
                ),
              ),
              top: words.firstThreeWords[2].length < 20 ? 155 : 140,
              left: 0)
      ],
    );
  }
}
