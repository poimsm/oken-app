import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';
import 'package:oken/constants/color.dart' as COLOR;

class QuizAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);

    return AlertDialog(
      title: const Text('Expand your vocabulary'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Study the words that you have saved in the vocabulary section and make them part of your daily conversations!'),
            SizedBox(height: media.s(20)),
            Image.asset('assets/pop04.png', width: media.s(22)),
            SizedBox(height: media.s(20)),
            Center(child: _gotItBtn(context, media))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, media) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: media.s(8), vertical: media.s(5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(COLOR.GREEN),
        ),
        child: Text(
          'Got it!',
          style: TextStyle(color: Colors.white, fontSize: media.s(14)),
        ),
      ),
    );
  }
}
