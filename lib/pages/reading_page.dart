import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oken/providers/reading_provider.dart';
import 'package:oken/providers/rx_loader.dart';
import 'package:oken/providers/rx_paragraph.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/providers/word_provider.dart';
import 'package:oken/widgets/reading_header.dart';
import 'package:oken/widgets/loader.dart';
import 'package:oken/widgets/paragraph.dart';
import 'package:oken/widgets/toast_synom.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({Key key}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  ReadingProvider reading;
  WordProvider words;

  ScrollController _scrollController = new ScrollController();
  VocabProvider vocabulary;

  @override
  void initState() {
    reading = Provider.of<ReadingProvider>(context, listen: false);
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    vocabulary.load();
    super.initState();
  }

  initParagraphs(width, args) async {
    int i = args['paginatorIndex'];
    List chapters = args['chapters'];
    String path = args['hasChapters'] ? chapters[i]['path'] : args['path'];
    await reading.getById(2, width * 0.97, path, chapters);
    rxParagraph = RxParagraph(index: 2);
    rxParagraph.generateObsList(reading.paragraphs.length);
  }

  setParagraphs(width, path, index) async {
    rxLoader.start();
    await reading.changeReadingText(width, path, index);
    rxParagraph.dispose();
    rxParagraph.generateObsList(reading.paragraphs.length);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    rxParagraph.dispose();
    reading.dispose();
    super.dispose();
  }

  double currentScroll = 0;
  Timer timer;
  Map elem;
  bool isPristine = true;
  UIProvider ui;
  RxParagraph rxParagraph;
  RxLoader rxLoader;
  Map args;
  Size size;

  @override
  Widget build(BuildContext context) {
    Provider.of<ReadingProvider>(context);
    words = Provider.of<WordProvider>(context, listen: false);
    ui = Provider.of<UIProvider>(context, listen: false);
    rxLoader = RxLoader();
    size = MediaQuery.of(context).size;

    if (isPristine) {
      args = ModalRoute.of(context).settings.arguments;
      rxLoader.start();
      initParagraphs(size.width, args);
      isPristine = false;
    }

    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      double maxExtent = _scrollController.position.maxScrollExtent;
      ui.changeColorHandler(currentScroll);
      rxParagraph.scrollHandler(currentScroll, maxExtent);
    });

    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _img(),
                  _chapterTitle(),
                  _textBody(),
                  if (args['hasChapters']) _paginator()
                ],
              ),
            ),
            Positioned(
                child: HeaderReading(title: args['title']), top: 0, left: 0),
            Positioned(
                child: ToastSynonym(args),
                bottom: size.height * 0.025,
                left: 0),
            StreamBuilder(
                stream: rxLoader.isLoading,
                builder: (context, snapshot) {
                  return Loader(snapshot.data);
                })
          ],
        ),
      ),
    );
  }

  Widget _chapterTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.045),
      child: Center(child: args['hasChapters'] ? _titleOne() : _titleTwo()),
    );
  }

  Widget _titleOne() {
    return Column(children: [
      Text('CHAPTER ' + args['chapterNumber'].toString(),
          style: TextStyle(
              fontSize: size.width * 0.07,
              color: Colors.black.withOpacity(0.7))),
      SizedBox(height: size.height * 0.015),
      if (args['author'].length > 0)
        Text(args['author'].toUpperCase(),
            style: TextStyle(
                fontSize: size.width * 0.045,
                color: Colors.black.withOpacity(0.7))),
    ]);
  }

  Widget _titleTwo() {
    return Text(args['title'],
        style: TextStyle(
            fontSize: size.width * 0.07, color: Colors.black.withOpacity(0.7)));
  }

  Widget _textBody() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...List.generate(reading.paragraphs.length, (index) {
            return StreamBuilder(
                stream: rxParagraph.getObs(index),
                builder: (context, snapshot) {
                  List words = reading.paragraphs[index];
                  bool visible = snapshot.data != null ? snapshot.data : false;
                  int maxLength = reading.paragraphs.length;

                  return Paragraph(words, index, visible, maxLength, args);
                });
          }),
        ]),
      ),
    );
  }

  Widget _img() {
    String imageURL = args['cover'];

    return Image.network(
      imageURL,
      fit: BoxFit.cover,
      width: size.width,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
            color: Colors.grey.withOpacity(0.4),
            height: 350,
            width: size.width);
      },
    );
  }

  Widget _paginator() {
    return Container(
      padding: EdgeInsets.only(
          left: size.width * 0.07,
          right: size.width * 0.07,
          top: size.width * 0.035,
          bottom: size.width * 0.14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(reading.chapters.length, (i) {
              return Row(
                children: [
                  _page(i, reading.chapters[i]),
                  // TODO: Hardcoded paginatorIndex
                  if (i != args['paginatorIndex'] - 1) SizedBox(width: size.width * 0.04),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _page(index, data) {
    bool isChapter = data['type'] == 'chapter';
    String txt = data['text'];
    bool comingSoon = data['comingSoon'];
    bool selected = data['selected'];
    String path = data['path'];

    return index == args['paginatorIndex'] - 1
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(
                horizontal: isChapter ? 15 : 3, vertical: isChapter ? 5 : 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Color(0xff595959)),
            ),
            child: InkWell(
                onTap: () {
                  if (comingSoon) return _toast();
                  if (isChapter) index++;

                  double width = size.width;
                  _scrollController.jumpTo(0);
                  setParagraphs(width, path, index);
                },
                child: isChapter ? _chapterBubble(txt) : _bullet(selected)));
  }

  Widget _bullet(selected) {
    return Container(
      height: size.width * 0.065,
      width: size.width * 0.065,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: selected ? Color(0xff595959) : Colors.white),
    );
  }

  Widget _chapterBubble(text) {
    return Text(text,
        style:
            TextStyle(color: Color(0xff595959), fontSize: size.width * 0.045));
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
