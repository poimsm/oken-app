import 'package:flutter/material.dart';

class BaseAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove folder and words?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This action will also remove the words from the folder.'),
            SizedBox(height: 5),
            Text('Do you want to Continue?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}