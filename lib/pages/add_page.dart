import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Size size;
  Map args;
  VocabProvider vocabulary;
  final _wordCtrl = TextEditingController();
  final _meaningCtrl = TextEditingController();

  @override
  void dispose() {
    _wordCtrl.dispose();
    _meaningCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    vocabulary = Provider.of<VocabProvider>(context, listen: false);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [_header(), _title(), _buildForm()],
      ),
    )));
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 1),
          Text(
            'New word',
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

  Widget _title() {
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            top: size.width * 0.09,
            bottom: size.width * 0.17,
            left: size.width * 0.052,
            right: size.width * 0.19),
        alignment: Alignment.center,
        child: Text(
          'Create a new word to study it!',
          style:
              TextStyle(fontSize: size.width * 0.08, color: Color(0xff404040)),
        ));
  }

  Widget _buildForm() {
    return Container(
      alignment: Alignment.center,
      child: Container(
          width: size.width * 0.9,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: [_buildWord(), _buildMeaning(), _buildSaveBtn()],
          )),
    );
  }

  Widget _buildWord() {
    return IntrinsicWidth(
        child: Container(
      padding: EdgeInsets.only(bottom: 30),
      width: size.width * 0.9,
      child: TextField(
        controller: _wordCtrl,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.black, fontSize: size.width * 0.052),
        decoration: InputDecoration(
            // border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            hintText: 'Enter a new word...'),
      ),
    ));
  }

  Widget _buildMeaning() {
    return IntrinsicWidth(
        child: Container(
      padding: EdgeInsets.only(bottom: 30),
      width: size.width * 0.9,
      child: TextField(
        controller: _meaningCtrl,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.black, fontSize: size.width * 0.052),
        decoration: InputDecoration(
            hintStyle:
                TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 15),
            isDense: true,
            contentPadding: EdgeInsets.all(12),
            hintText: 'Meaning (optional)'),
      ),
    ));
  }

  Widget _buildSaveBtn() {
    return Container(
      width: size.width * 0.9,
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_wordCtrl.text.length == 0) return;
          String _meaning =
              _meaningCtrl.text.length == 0 ? 'No meaning' : _meaningCtrl.text;
          vocabulary.addWord(_wordCtrl.text, _meaning);
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
      ),
    );
  }
}
