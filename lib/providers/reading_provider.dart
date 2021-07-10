import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/content.dart';
import 'package:oken/utils/paragraphs_builder.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ReadingProvider with ChangeNotifier {
  List<Map> _content = DataContent().get();
  List _paragraphs = [];
  List _chapters = [];

  Future<String> getJson(path) {
    return rootBundle.loadString('assets/books/' + path);
  }

  Future getById(id, size, path, [chapters]) async {
    List data = await json.decode(await getJson(path));
    _paragraphs = ParagraphsBuilder(data, size, decodeJSON: false).build();
    _chapters = chapters;
    notifyListeners();
  }

  Future changeReadingText(size, path, index) async {
    List data = await json.decode(await getJson(path));
    _paragraphs = ParagraphsBuilder(data, size, decodeJSON: false).build();
    _chapters = _chapters.map((chapter) => {...chapter, 'selected': false }).toList();
    _chapters[index]['selected'] = true;
    notifyListeners();
  }

  get chapters => _chapters;

  get paragraphs => _paragraphs;

  void dispose() {
    _paragraphs = [];
    _chapters = [];
  }

  set paragraphs(val) {
    _paragraphs = val;
    notifyListeners();
  }

  showSynonym(word, synon) {
    return _content.length;
  }

  void toggleQuestionBox(i, j) {
    bool visibleTemp = paragraphs[i][j]['visible'];
    turnFalseAllQuestionLines();
    paragraphs[i][j]['visible'] = !visibleTemp;
    notifyListeners();
  }

  void turnFalseAllQuestionLines() {
    for (var i = 0; i < _paragraphs.length; i++) {
      for (var j = 0; j < _paragraphs[i].length; j++) {
        if (_paragraphs[i][j]['type'] == 'questionLine') {
          _paragraphs[i][j]['visible'] = false;
        }
      }
    }

    paragraphs = _paragraphs;
  }
}
