import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart';
import 'package:oken/utils/text_size.dart';
import 'package:provider/provider.dart';

class ReadingActionSheet extends StatefulWidget {
  ReadingActionSheet(this.word);
  final Map word;

  @override
  _ReadingActionSheetState createState() => _ReadingActionSheetState();
}

class _ReadingActionSheetState extends State<ReadingActionSheet> {
  UIProvider ui;
  Size size;
  VocabProvider vocabulary;
  bool collapse;

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    collapse =
        TextSize(widget.word['synonym']).isGreaterThan(size.width * 0.8, 17);

    return Container(
      color: Color(0xFF737373),
      height: size.width * (collapse ? 0.45 : 0.35),
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 20, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * 0.055),
              topRight: Radius.circular(size.width * 0.055),
            )),
        child: _actionSheetBody(widget.word),
      ),
    );
  }

  Widget _actionSheetBody(word) {
    Helper helper = Helper();
    String wordTxt = helper.extractWord(word['word']);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _bar(),
      Text(helper.toCapital(wordTxt),
          style: TextStyle(
            fontSize: size.width * 0.053,
            color: Colors.black87,
          )),
      SizedBox(height: 3),
      Text(helper.toCapital(word['synonym']),
          style:
              TextStyle(fontSize: size.width * 0.047, color: Colors.black54)),
      Container(
          padding: EdgeInsets.only(top: collapse ? 15 : 5),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: _actionSheetBtn())
    ]);
  }

  Widget _actionSheetBtn() {
    return IntrinsicWidth(
      child: InkWell(
        onTap: () {
          Navigator.pop(context, widget.word);
        },
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffE0E0E0)),
            child: Row(children: [
              Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.translate,
                      color: Color(0xff353535), size: size.width * 0.06)),
              SizedBox(width: 10),
              Text('Add',
                  style: TextStyle(
                    color: Color(0xff353535),
                    fontSize: size.width * 0.045,
                  ))
            ])),
      ),
    );
  }

  Widget _bar() {
    return Container(
        padding: EdgeInsets.only(bottom: size.width * 0.02),
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Container(
          width: size.width * 0.08,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffE7E6E6),
          ),
        ));
  }
}
