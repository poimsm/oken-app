import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oken/constants/reading_types.dart' as TYPES;
import 'package:oken/providers/reading_provider.dart';
import 'package:oken/providers/rx_loader.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/word_provider.dart';
import 'package:oken/widgets/memory.dart';
import 'package:provider/provider.dart';

class Paragraph extends StatefulWidget {
  Paragraph(this.lines, this.i, this.visible, this.maxLength);

  List lines;
  bool visible;
  int i;
  int maxLength;

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  UIProvider ui;
  ReadingProvider reading;
  WordProvider words;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    words = Provider.of<WordProvider>(context, listen: false);
    reading = Provider.of<ReadingProvider>(context, listen: false);
    ui = Provider.of<UIProvider>(context, listen: false);

    if (widget.visible && widget.i == widget.maxLength - 1) {
      var rxLoader = RxLoader();
      rxLoader.stop();
    }

    return widget.visible ? _paragraph() : Container();
  }

  Widget _paragraph() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.lines.length, (index) {
          Widget elem;

          // if (widget.lines[index]['type'] == TYPES.LINE) {
          //   elem = _line(widget.lines[index]['words'], widget.i, index + 1);
          // } else if (widget.lines[index]['type'] == TYPES.QUESTION_LINE &&
          //     widget.lines[index]['visible']) {
          //   elem = _questionBox(widget.lines[index], widget.i, index);
          // } else {
          //   elem = SizedBox(width: 5);
          // }

          if (widget.lines[index]['type'] == TYPES.LINE) {
            elem = _line(widget.lines[index]['words'], widget.i, index + 1);
          } else {
            elem = SizedBox(width: 5);
          }

          return elem;
        }),
      ),
    );
  }

  Widget _questionBox(questionLine, i, j) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            color: Color(0xff7030A0),
            width: MediaQuery.of(context).size.width,
            child: _questionBoxContent(questionLine, i, j)));
  }

  Widget _questionBoxContent(questionLine, i, j) {
    return Column(
      children: [
        Text(questionLine['question'],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 17.5)),
        SizedBox(height: 20),
        Text('Answer combining these words:',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Indi Flower')),
        SizedBox(height: 15),
        InkWell(
            onTap: () => reading.toggleQuestionBox(i, j),
            child: Memory(true, true))
      ],
    );
  }

  Widget _questionMark(word, i, j) {
    return InkWell(
      onTap: () {
        words.shuffle();
        reading.toggleQuestionBox(i, j);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
            width: 23, height: 23, color: Colors.grey.withOpacity(0.5)),
      ),
    );
  }

  Widget _line(words, i, j) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: List.generate(words.length, (index) {
          return Row(children: [
            (words[index]['type'] == TYPES.WORD)
                ? _words(words[index])
                : Container(),
            // : _questionMark(words[index], i, j),
            SizedBox(width: 3.5)
          ]);
        }),
      ),
    );
  }

  Widget _words(word) {
    double opacity = (word['hasSynonym']) ? 0.6 : 0;
    return InkWell(
      onTap: () => _presentSynom(word),
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 2, color: Colors.black.withOpacity(opacity)),

              // width: 2, color: Color(0xff92D050).withOpacity(opacity)),
            ),
          ),
          child: Text(
            word['word'],
            style:
                TextStyle(fontSize: 17.5, color: Colors.black.withOpacity(0.7)),
          )),
    );
  }

  void _presentSynom(word) {
    if (word['hasSynonym']) {
      if (timer != null) {
        timer.cancel();
      }
      int msec = word['synonym'].length > 30 ? 6500 : 3500;
      timer = Timer(Duration(milliseconds: msec), () {
        ui.setSynomToast(false, word);
      });
      ui.setSynomToast(true, word);
    }
  }
}
