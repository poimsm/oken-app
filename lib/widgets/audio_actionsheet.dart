import 'package:flutter/material.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:provider/provider.dart';

class AudioActionSheet extends StatefulWidget {
  @override
  _AudioActionSheetState createState() => _AudioActionSheetState();
}

class _AudioActionSheetState extends State<AudioActionSheet> {
  Size size;
  VocabProvider vocabulary;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    return Container(
      height: size.height * 0.8,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * 0.045),
            topRight: Radius.circular(size.width * 0.045),
          )),
      child: _actionSheetBody(),
    );
  }

  Widget _actionSheetBody() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(), _list()],
        ),
        Positioned(bottom: 0, left: 0, child: _footer())
      ],
    );
  }

  Widget _title() {
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            top: size.width * 0.09,
            bottom: size.width * 0.1,
            left: size.width * 0.052,
            right: size.width * 0.19),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.music_note, color: Colors.white),
            SizedBox(
              width: 5,
            ),
            Text(
              'My records (9)',
              style:
                  TextStyle(fontSize: size.width * 0.052, color: Colors.white),
            ),
          ],
        ));
  }

  Widget _list() {
    return Container(
      height: size.height * 0.58,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _item(),
            // _item(ok: true),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
            _item(),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Container(
              height: size.width * 0.14,
              width: size.width * 0.14,
              child: Image.asset('assets/trash.png',
                  fit: BoxFit.contain, color: Colors.white.withOpacity(0.9))),
        ));
  }

  Widget _item({ok}) {
    ok = ok == null ? false : ok;
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        leading: Icon(Icons.play_circle, size: 45, color: Color(0xffCBCBCB)),
        title: Text(
          '2021-06-19 16:35',
          style: TextStyle(fontSize: size.width * 0.047, color: Colors.white),
        ),
        trailing: Text('3:21',
            style:
                TextStyle(fontSize: size.width * 0.047, color: Colors.white)));
  }
}
