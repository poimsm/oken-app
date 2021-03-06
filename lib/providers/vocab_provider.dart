import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oken/providers/dummy/words.dart';
import 'package:oken/utils/helper.dart' as helper;

class VocabProvider with ChangeNotifier {
  Words wordsInstance;
  List _history = [];
  List _allWords = [];
  List _words = [];
  List _questionWords = [];
  List _folders = [];
  bool _loading = false;

  void load() {
    if (wordsInstance != null) return;
    wordsInstance = Words();
    _allWords = wordsInstance.getWords();
    _words = _allWords.where((word) => word['new']).toList();
    _folders = wordsInstance.getFolders();
  }

  get words => _words;

  List getWords(String type) {
    switch (type) {
      case 'latest':
        return _allWords
            .where((word) => word['new'] || word['relearn'])
            .toList();
      case 'liked':
        return _allWords.where((word) => word['liked']).toList();
      case 'known':
        return _allWords.where((word) => word['known']).toList();
      case 'relearn':
        return _allWords.where((word) => word['relearn']).toList();
      default:
        return [];
    }
  }

  List getWordsByFolder(id) {
    return _allWords.where((word) => word['folder'] == id).toList();
  }

  get folders => _folders;

  void likeWord(id) {
    int index = _allWords.indexWhere((word) => word['id'] == id);
    _allWords[index]['liked'] = !_allWords[index]['liked'];
    notifyListeners();
  }

  void removeFromLikedList(id) {
    int index = _allWords.indexWhere((word) => word['id'] == id);
    _allWords[index]['liked'] = false;
    notifyListeners();
  }

  void markAsKnown(id) {
    int i = _allWords.indexWhere((word) => word['id'] == id);
    _allWords[i]['known'] = true;
    _allWords[i]['relearn'] = false;
    _allWords[i]['new'] = false;
    notifyListeners();
  }

  void markAsRelearn(id) {
    int i = _allWords.indexWhere((word) => word['id'] == id);
    _allWords[i]['known'] = false;
    _allWords[i]['relearn'] = true;
    notifyListeners();
  }

  void markAsKnownFromHistory(id, index) {
    _history[index]['known'] = true;
    _questionWords.removeWhere((w) => w['id'] == id);
    _allWords = _allWords.map((w) {
      if (w['id'] != id) return w;
      return {...w, 'known': true, 'relearn': false, 'new': false};
    }).toList();
    notifyListeners();
  }

  void deleteWord(elem) {
    _allWords.removeWhere((word) => word['id'] == elem['id']);

    Map folder =
        _folders.firstWhere((folder) => folder['id'] == elem['folder']);
    folder['total_words'] = folder['total_words'] - 1;

    if (folder['total_words'] < 1) {
      _folders.removeWhere((folder) => folder['id'] == elem['folder']);
    }
    notifyListeners();
  }

  void deleteFolder(elem, i) {}

  void addWord(title, synonyms) {
    int userId = 839221;
    int index = _folders.indexWhere((f) => f['id'] == userId);

    if (index < 0) {
      Map folder = {
        'name': 'My words',
        'id': userId,
        'default': true,
        'total_words': 0
      };

      _folders.add(folder);
      index = _folders.indexWhere((f) => f['id'] == userId);
    }

    _folders[index]['total_words']++;

    Map word = {
      'title': title,
      'synonyms': synonyms,
      'folder_name': 'My words',
      'folder': userId,
      'liked': false,
      'relearn': false,
      'known': false,
      'new': true,
      'id': Random().nextInt(100000)
    };

    _allWords.add(word);

    notifyListeners();
  }

  void addWordFromBook(book, word) {
    int i = _folders.indexWhere((f) => f['id'] == book['id']);

    Map wordElem = {
      'title': helper.extractWord(word['word']),
      'synonyms': word['synonym'],
      'folder_name': book['folder_name'],
      'folder': book['id'],
      'liked': false,
      'relearn': false,
      'known': false,
      'new': true,
      'id': Random().nextInt(100000)
    };

    _allWords.add(wordElem);

    if (i < 0) {
      Map folder = {
        'name': book['folder_name'],
        'id': book['id'],
        'default': false,
        'total_words': 1
      };

      return _folders.add(folder);
    }

    _folders[i]['total_words'] += 1;
    notifyListeners();
  }

  get history => _history.take(20).toList();

  get firstThreeWords => _questionWords.take(3).toList();

  void setQuestionWords() {
    List temp = _allWords.where((w) => w['relearn'] || w['new']).toList();
    _questionWords = helper.deepClone(temp);
  }

  void shuffle() {
    startLoading();
    List temp = _history + _questionWords.take(3).toList();
    _history = helper.deepClone(temp).reversed.toList();
    this._questionWords.shuffle();
    notifyListeners();
  }

  void startLoading() {
    _loading = true;
    Timer(Duration(milliseconds: 500), () {
      _loading = false;
      notifyListeners();
    });
  }

  get loading => _loading;
}
