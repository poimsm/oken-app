import 'package:flutter/material.dart';

class TextSize {
  String text;

  TextSize(this.text);

  bool isGreaterThan(double val, double fontSize) {
    final TextStyle textStyle = TextStyle(
      fontSize: fontSize,
    );
    final Size txtSize = _textSize(text, textStyle);
    return txtSize.width > val;
  }

  double getSize(double fontSize) {
    final TextStyle textStyle = TextStyle(
      fontSize: fontSize,
    );
    final Size txtSize = _textSize(text, textStyle);
    return txtSize.width;
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
