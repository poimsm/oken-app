class TextProcessor {
  String text;
  List<String> questions;
  List<Map> synonyms;

  TextProcessor(this.text, this.questions, this.synonyms);

  buildStructure() {
    RegExp re = RegExp(r'.*?(?=qqqq)');
    List<String> sentences = [];
    List<Map> responseLast = [];

    if (re.hasMatch(text)) {
      sentences = text.split('qqqq');
      for (var i = 0; i < sentences.length; i++) {
        List<String> words = sentences[i].split(' ');
        List<String> wordsLast = [];

        for (var j = 0; j < words.length; j++) {
          if (words[j].length > 0) {
            wordsLast.add(words[j]);
          }
        }

        if (wordsLast.length > 0) {
          responseLast.add({'type': 'sentence', 'words': wordsLast});
        }

        if (i < questions.length) {
          responseLast.add({'type': 'questionMark', 'question': questions[i]});
        }
      }
    }

    List<Map> structure = [];

    for (var i = 0; i < responseLast.length; i++) {
      if (responseLast[i]['type'] == 'sentence') {
        structure = structure + buildWords(responseLast[i]['words'], synonyms);
      } else {
        structure.add(responseLast[i]);
      }
    }

    return structure;
  }

  buildWords(List<String> words, List<Map> synonyms) {
    List<Map> wordlast = [];
    for (var i = 0; i < words.length; i++) {
      bool founded = false;
      String synom = '';
      for (var j = 0; j < synonyms.length; j++) {
        if (words[i] == synonyms[j]['name']) {
          founded = true;
          synom = synonyms[j]['synonym'];
        }
      }

      if (founded) {
        wordlast.add({
          'type': 'word',
          'word': words[i],
          'synonym': synom,
          'hasSynonym': true
        });
      } else {
        wordlast.add({'type': 'word', 'word': words[i], 'hasSynonym': false});
      }
    }
    return wordlast;
  }
}
