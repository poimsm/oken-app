import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:provider/provider.dart';

class ToastSynonym extends StatefulWidget {
  ToastSynonym(this.book);
  Map book;

  @override
  _ToastSynonymState createState() => _ToastSynonymState();
}

class _ToastSynonymState extends State<ToastSynonym> {
  UIProvider ui;
  Size size;
  VocabProvider vocabulary;

  String extractWord(txt) {
    RegExp re = RegExp(r'\w+');
    return re.firstMatch(txt).group(0);
  }

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    return ui.showSynomToast ? _body() : Container();
  }

  Widget _body() {
    return Container(
      width: size.width,
      child: Center(
        child: Container(
            width: size.width * 0.95,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(100),
              color: Colors.black.withOpacity(0.85),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.translate, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: 110,
                          minHeight: 40,
                          maxWidth: size.width * 0.55,
                          minWidth: size.width * 0.4),
                      child: Container(
                          child: ui.synomSaved ? _saved() : _normal()),
                    )
                  ],
                ),
                InkWell(
                    onTap: () {
                      ui.setSynomSaved();
                      vocabulary.addWordFromBook(
                          widget.book, extractWord(ui.word['word']));
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Widget _saved() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(Icons.check, color: Colors.white, size: size.width * 0.06),
            SizedBox(width: 5),
            Text(
              'Saved',
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: Colors.white,
              ),
            )
          ],
        ));
  }

  Widget _normal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_word(), _synom()],
    );
  }

  Widget _word() {
    String word = extractWord(ui.word['word']);
    return Text(
      '${word[0].toUpperCase()}${word.substring(1)}',
      style: TextStyle(
          fontSize: size.width * 0.045,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }

  Widget _synom() {
    return Flexible(
      child: Text(
        ui.word['synonym'],
        style: TextStyle(fontSize: size.width * 0.043, color: Colors.white),
      ),
    );
  }
}
