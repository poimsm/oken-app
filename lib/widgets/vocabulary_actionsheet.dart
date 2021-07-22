import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocabulary_provider.dart';
import 'package:oken/utils/helper.dart';
import 'package:provider/provider.dart';

class VocabularyActionSheet extends StatefulWidget {
  VocabularyActionSheet(this.elem, this.knownTab);
  final Map elem;
  final bool knownTab;

  @override
  _VocabularyActionSheetState createState() => _VocabularyActionSheetState();
}

class _VocabularyActionSheetState extends State<VocabularyActionSheet> {
  UIProvider ui;
  Size size;
  VocabularyProvider vocabulary;

  String extractWord(txt) {
    RegExp re = RegExp(r'\w+');
    return re.firstMatch(txt).group(0);
  }

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabularyProvider>(context, listen: false);
    return Container(
      color: Color(0xFF737373),
      height: size.width * 0.7,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * 0.045),
              topRight: Radius.circular(size.width * 0.045),
            )),
        child: _actionSheetBody(widget.elem, widget.knownTab),
      ),
    );
  }

  Widget _actionSheetBody(elem, knownTab) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _bar(),
      _actionSheetHeader(elem),
      SizedBox(height: size.width * 0.035),
      ListTile(
          dense: true,
          leading: Icon(knownTab ? LineIcons.redo : LineIcons.check,
              size: size.width * 0.066),
          title: Text(
            knownTab ? 'Re-learn' : 'Learned',
            style:
                TextStyle(fontSize: size.width * 0.049, color: Colors.black87),
          ),
          onTap: () {
            Navigator.pop(context);
            if (knownTab) return vocabulary.markAsRelearn(elem['id']);
            vocabulary.markAsKnown(elem['id']);
          }),
      ListTile(
          dense: true,
          leading: Icon(LineIcons.copy, size: size.width * 0.066),
          title: Text('Copy',
              style: TextStyle(
                  fontSize: size.width * 0.047, color: Colors.black87)),
          onTap: () {
            Clipboard.setData(ClipboardData(text: elem['title']));
            Navigator.pop(context, 'copy');
          }),
      ListTile(
          dense: true,
          leading: Icon(LineIcons.times, size: size.width * 0.066),
          title: Text('Delete',
              style: TextStyle(
                  fontSize: size.width * 0.047, color: Colors.black87)),
          onTap: () {
            vocabulary.deleteWord(elem);
            Navigator.pop(context, 'delete');
          }),
    ]);
  }

  Widget _actionSheetHeader(elem) {
    return Container(
        padding: EdgeInsets.only(left: size.width * 0.052),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(Helper().toCapital(elem['title']),
              style: TextStyle(
                  fontSize: size.width * 0.052, color: Colors.black87)),
          SizedBox(height: size.width * 0.01),
          Text(Helper().toCapital(elem['synonyms']),
              style: TextStyle(
                  fontSize: size.width * 0.042, color: Colors.black54))
        ]));
  }

  Widget _bar() {
    return Container(
        padding: EdgeInsets.only(
            top: size.width * 0.045,
            right: size.width * 0.052,
            bottom: size.width * 0.03),
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
