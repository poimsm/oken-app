import 'package:flutter/material.dart';
import 'package:oken/utils/dimens.dart';
import 'package:oken/constants/color.dart' as COLOR;

class BookAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dimens dimens = Dimens(context);

    return AlertDialog(
      title: const Text('Learn New English Words'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
                'Start exploring and mining strange words from books, add those words to the vocabulary section and learn them all!'),
            SizedBox(height: dimens.s(20)),
            Image.asset('assets/pop02.png'),
            SizedBox(height: dimens.s(20)),
            Center(child: _gotItBtn(context, dimens))
          ],
        ),
      ),
    );
  }

  Widget _gotItBtn(BuildContext context, Dimens dimens) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: dimens.s(8), vertical: dimens.s(5)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(COLOR.PURPLE),
        ),
        child: Text(
          'Got it!',
          style: TextStyle(color: Colors.white, fontSize: dimens.s(15)),
        ),
      ),
    );
  }
}
