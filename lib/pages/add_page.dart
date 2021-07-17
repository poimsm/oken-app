import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocabulary_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Size size;
  Map args;
  VocabularyProvider vocabulary;
  final _txtController = TextEditingController();

  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    vocabulary = Provider.of<VocabularyProvider>(context, listen: false);

    return Scaffold(body: SafeArea(child: _body()));
  }

  Widget _body() {
    return Column(
      children: [
        _header(args['header']),
        _title(args['title']),
        _form(args['label'])
      ],
    );
  }

  Widget _header(txt) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1),
          Text(
            txt,
            style: TextStyle(
              fontSize: 21,
              color: Color(0xff92D050),
            ),
          ),
          InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(LineIcons.times, color: Color(0xff92D050), size: 30))
        ],
      ),
    );
  }

  Widget _title(txt) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 30, bottom: 60, left: 20, right: 70),
        alignment: Alignment.center,
        child: Text(
          txt,
          style: TextStyle(fontSize: 27, color: Color(0xff404040)),
        ));
  }

  Widget _form(txt) {
    return Container(
      alignment: Alignment.center,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_inputBox(txt), _saveBtn()],
          )),
    );
  }

  Widget _inputBox(txt) {
    return IntrinsicWidth(
        child: Container(
      width: size.width * 0.6,
      child: TextField(
        controller: _txtController,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.black, fontSize: size.width * 0.052),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            hintText: txt),
      ),
    ));
  }

  Widget _saveBtn() {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (_txtController.text.length == 0) return;
        vocabulary.addWord(_txtController.text);
        Navigator.pop(context);
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: Color(0xff92D050),
              borderRadius: BorderRadius.circular(15)),
          child: Icon(Icons.edit_outlined, color: Colors.white, size: 32)),
    );
  }
}
