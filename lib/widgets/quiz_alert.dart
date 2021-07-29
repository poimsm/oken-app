import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';

class QuizAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Media m = Media(context);

    return AlertDialog(
      title: const Text('Expand your vocabulary'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Study the words that you have saved in the vocabulary section and make them part of your daily conversations!'),
            SizedBox(height: m.s(20)),
            Image.asset('assets/pop01.png', width: m.s(22)),
            SizedBox(height: m.s(20)),
            Center(child: _gotItBtn(context, m))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, m) {
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
          style: TextStyle(color: Colors.white, fontSize: m.s(14)),
        ),
      ),
    );
  }
}
