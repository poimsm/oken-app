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
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1),
          Text(
            txt,
            style: TextStyle(
              fontSize: size.width * 0.06,
              color: Color(0xff92D050),
            ),
          ),
          InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(LineIcons.times,
                  color: Color(0xff92D050), size: size.width * 0.085))
        ],
      ),
    );
  }

  Widget _title(txt) {
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            top: size.width * 0.09,
            bottom: size.width * 0.17,
            left: 20,
            right: size.width * 0.19),
        alignment: Alignment.center,
        child: Text(
          txt,
          style:
              TextStyle(fontSize: size.width * 0.08, color: Color(0xff404040)),
        ));
  }

  Widget _form(txt) {
    return Container(
      alignment: Alignment.center,
      child: Container(
          width: size.width * 0.9,
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
          padding: EdgeInsets.symmetric(
              vertical: size.width * 0.02, horizontal: size.width * 0.04),
          decoration: BoxDecoration(
              color: Color(0xff92D050),
              borderRadius: BorderRadius.circular(size.width * 0.04)),
          child: Icon(Icons.edit_outlined,
              color: Colors.white, size: size.width * 0.085)),
    );
  }
}
