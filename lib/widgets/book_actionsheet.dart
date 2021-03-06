import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart' as helper;
import 'package:oken/utils/text_size.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class BookActionSheet extends StatefulWidget {
  BookActionSheet(this.word);
  final Map word;

  @override
  _BookActionSheetState createState() => _BookActionSheetState();
}

class _BookActionSheetState extends State<BookActionSheet> {
  UIProvider ui;
  Size size;
  VocabProvider vocaProvider;
  bool collapse;

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    size = MediaQuery.of(context).size;
    vocaProvider = Provider.of<VocabProvider>(context, listen: false);
    collapse =
        TextSize(widget.word['synonym']).isGreaterThan(size.width * 0.8, 17);

    return Container(
      color: Color(COLOR.DARK_GREY),
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
                color: Color(COLOR.SUPER_LIGHT_GREY)),
            child: Row(children: [
              Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.translate,
                      color: Color(COLOR.SUPER_DARK_GREY),
                      size: size.width * 0.06)),
              SizedBox(width: 10),
              Text('Add',
                  style: TextStyle(
                    color: Color(COLOR.SUPER_DARK_GREY),
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
            color: Color(COLOR.BAR_GREY),
          ),
        ));
  }
}
