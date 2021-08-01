import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';
import 'package:oken/constants/color.dart' as COLOR;

class BookAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);

    return AlertDialog(
      title: const Text('Learn New English Words'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Start exploring and mining strange words from books, add those words to the vocabulary section and learn them all!'),
            SizedBox(height: media.s(20)),
            Image.asset('assets/pop02.png'),
            SizedBox(height: media.s(20)),
            Center(child: _gotItBtn(context, media))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, Media media) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: media.s(8), vertical: media.s(5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(COLOR.PURPLE),
        ),
        child: Text(
          'Got it!',
          style: TextStyle(color: Colors.white, fontSize: media.s(15)),
        ),
      ),
    );
  }
}
