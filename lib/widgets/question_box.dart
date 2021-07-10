import 'package:flutter/material.dart';
import 'package:oken/providers/reading_provider.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/widgets/memory.dart';
import 'package:provider/provider.dart';

class QuestionBox extends StatefulWidget {
  QuestionBox({Key key, this.questionLine, this.i, this.j}) : super(key: key);

  Map questionLine;
  int i;
  int j;

  @override
  _QuestionBoxState createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  UIProvider ui;
  ReadingProvider reading;

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    reading = Provider.of<ReadingProvider>(context, listen: false);

    return ui.showQuestionBox
        ? _body(widget.questionLine, widget.i, widget.j)
        : Container();
  }

  Widget _body(questionLine, i, j) {
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
}
