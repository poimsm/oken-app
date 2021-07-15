import 'dart:convert' as JSON;

import 'package:flutter/material.dart';

class ParagraphsBuilder {
  var jsonData;
  num maxCharsPerLine;
  bool decodeJSON;
  String hm;

  ParagraphsBuilder(this.jsonData, this.maxCharsPerLine,
      {this.decodeJSON = true});

  build(fontSize) {
    // var data = JSON.jsonDecode(jsonData);
    var data;

    if (decodeJSON) {
      data = JSON.jsonDecode(jsonData);
    } else {
      data = this.jsonData;
    }
    List paragraphs = [];

    for (var i = 0; i < data.length; i++) {
      num sizeCounter = 0;
      List currentLine = [];
      List lines = [];
      bool foundQuestion = false;
      String question = '';

      for (var j = 0; j < data[i].length; j++) {
        double sizeCounterTemp = 0;

        if (data[i][j]['type'] == 'word') {
          sizeCounterTemp = getSize(data[i][j]['word'] + ' ', fontSize);
          sizeCounter += sizeCounterTemp;
        } else {
          foundQuestion = true;
          sizeCounterTemp = 25;
          sizeCounter += 25;
          question = data[i][j]['question'];
        }

        if (sizeCounter <= maxCharsPerLine) {
          currentLine.add(data[i][j]);
        } else {
          lines.add({'type': 'line', 'words': currentLine});
          currentLine = [];
          currentLine.add(data[i][j]);
          bool isQuestionAtLast = data[i][j]['type'] == 'questionMark';
          if (foundQuestion && !isQuestionAtLast) {
            lines.add({
              'type': 'questionLine',
              'question': question,
              'visible': false
            });
            foundQuestion = false;
          }
          sizeCounter = sizeCounterTemp;
        }

        if (j + 1 == data[i].length) {
          lines.add({'type': 'line', 'words': currentLine});
          if (foundQuestion) {
            lines.add({
              'type': 'questionLine',
              'question': question,
              'visible': false
            });
            foundQuestion = false;
          }
        }
      }
      paragraphs.add(lines);
    }

    return paragraphs;
  }

  double getSize(text, size) {
    final TextStyle textStyle = TextStyle(
      fontSize: size,
      color: Colors.white,
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
