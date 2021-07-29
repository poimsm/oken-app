import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';

class BookAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media m = Media(context);

    return AlertDialog(
      title: const Text('Learn New English Words'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Start exploring and mining strange words from the book, add words to the vocabulary section to learn them all!'),
            SizedBox(height: m.s(20)),
            Image.asset('assets/pop02.png'),
            SizedBox(height: m.s(20)),
            Center(child: _gotItBtn(context, m))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, Media m) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: m.s(8), vertical: m.s(5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xff8C3FC5),
        ),
        child: Text(
          'Got it!',
          style: TextStyle(color: Colors.white, fontSize: m.s(15)),
        ),
      ),
    );
  }
}
