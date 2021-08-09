import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class VocabAdd extends StatefulWidget {
  @override
  _VocabAddState createState() => _VocabAddState();
}

class _VocabAddState extends State<VocabAdd> {
  Size size;
  VocabProvider vocabProvider;
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
    vocabProvider = Provider.of<VocabProvider>(context, listen: false);
    return Container(
      height: size.height * 0.88,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * 0.045),
            topRight: Radius.circular(size.width * 0.045),
          )),
      child: _actionSheetBody(),
    );
  }

  Widget _actionSheetBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_close(), _title(), _buildForm(), Container(height: 200)],
    );
  }

  Widget _close() {
    return InkWell(
      onTap: () => Navigator.pop(context, false),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Icon(LineIcons.times, size: 25, color: Colors.black87)),
    );
  }

  Widget _title() {
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            top: size.width * 0.09,
            bottom: size.width * 0.17,
            left: size.width * 0.052,
            right: size.width * 0.2),
        alignment: Alignment.center,
        child: Text(
          'Create a new word to study it!',
          style: TextStyle(
              fontSize: size.width * 0.065,
              color: Color(COLOR.SUPER_DARK_GREY)),
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
            hintText: 'Add a meaning or translation (optional)'),
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
          vocabProvider.addWord(_wordCtrl.text, _meaning);
          Navigator.pop(context, true);
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.02, horizontal: size.width * 0.04),
            decoration: BoxDecoration(
                color: Color(COLOR.GREEN),
                borderRadius: BorderRadius.circular(size.width * 0.04)),
            child: Icon(Icons.edit_outlined,
                color: Colors.white, size: size.width * 0.085)),
      ),
    );
  }
}
