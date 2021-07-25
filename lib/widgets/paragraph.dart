import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oken/constants/reading_types.dart' as TYPES;
import 'package:oken/providers/book_provider.dart';
import 'package:oken/providers/rx_loader.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/widgets/book_actionsheet.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Paragraph extends StatefulWidget {
  Paragraph(this.lines, this.i, this.visible, this.maxLength, this.book);

  final List lines;
  final bool visible;
  final int i;
  final int maxLength;
  final Map book;

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  UIProvider ui;
  BookProvider book;
  Timer timer;
  Size size;
  VocabProvider vocabulary;

  @override
  void initState() {
    vocabulary = Provider.of<VocabProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    book = Provider.of<BookProvider>(context, listen: false);
    ui = Provider.of<UIProvider>(context, listen: false);
    size = MediaQuery.of(context).size;

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
      onTap: () => _presentActionSheet(word),
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 2, color: Colors.black.withOpacity(opacity)),
            ),
          ),
          child: Text(
            word['word'],
            style: TextStyle(
                fontSize: size.width * 0.0475,
                color: Colors.black.withOpacity(0.7)),
          )),
    );
  }

  void _presentActionSheet(word) {
    if (!word['hasSynonym']) return;

    Future modal = showModalBottomSheet(
        context: context,
        builder: (context) {
          return BookActionSheet(word);
        });

    modal.then((val) {
      if (val == null) return;
      vocabulary.addWordFromBook(widget.book, val);
      _toast('Added to vocabulary');
    });
  }

  void _toast(txt) {
    Timer(
        Duration(milliseconds: 300),
        () => Toast.show(txt, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM));
  }
}
