import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';

class CodeAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String msg =
        "Invite a friend to sign up with your code and you'll get a reward!";

    Media media = Media(context);

    return AlertDialog(
      title: const Text('This is your code:'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('LA84HA7', style: TextStyle(fontSize: media.s(30))),
            SizedBox(height: media.s(15)),
            Text(msg),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('COPY'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
