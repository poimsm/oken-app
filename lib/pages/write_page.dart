import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'package:toast/toast.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _answerController = TextEditingController();
  Map args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Stack(
      children: [
        _body(),
        Positioned(top: 0, left: 0, child: _header()),
      ],
    ));
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 75),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                  args['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 19))),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
                controller: _answerController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Colors.black87, fontSize: 17.5),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Answer here...')),
          )
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        color: Color(COLOR.PURPLE),
        padding: EdgeInsets.only(right: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              _backBtn(),
              SizedBox(width: 8),
              _saveBtn(),
            ],
          ),
          _copyBtn()
        ]));
  }

  Widget _saveBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xffD8EEC0).withOpacity(0.4),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text('SAVE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )));
  }

  Widget _copyBtn() {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: _answerController.text));
        _toast('Copied');
      },
      child: IntrinsicHeight(
        child: Column(
          children: [
            Icon(Icons.content_copy, color: Colors.white),
            Text(
              'Copy',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _backBtn() {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Icon(Icons.arrow_back, color: Colors.white)));
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  }
}
