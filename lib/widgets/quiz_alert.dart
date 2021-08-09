import 'package:flutter/material.dart';
import 'package:oken/utils/dimens.dart';
import 'package:oken/constants/color.dart' as COLOR;

class QuizAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dimens dimens = Dimens(context);

    return AlertDialog(
      title: const Text('Expand your vocabulary'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Study the words that you have saved in the vocabulary section and make them part of your daily conversations!'),
            SizedBox(height: dimens.s(20)),
            Image.asset('assets/pop04.png', width: dimens.s(22)),
            SizedBox(height: dimens.s(20)),
            Center(child: _gotItBtn(context, dimens))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, dimens) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: dimens.s(8), vertical: dimens.s(5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(COLOR.GREEN),
        ),
        child: Text(
          'Got it!',
          style: TextStyle(color: Colors.white, fontSize: dimens.s(14)),
        ),
      ),
    );
  }
}
