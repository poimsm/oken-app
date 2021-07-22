class Words {
  getWords() {
    return _wordList;
  }

  getFolders() {
    return _folders;
  }
}

List<Map> _wordList = [
  {
    'title': 'Ground',
    'synonyms': 'soil, floor, land',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': true,
    'known': false,
    'new': false,
    'id': 143983
  },
  {
    'title': 'Totally clueless',
    'synonyms': 'No meaning',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': true,
    'known': false,
    'new': false,
    'id': 254726
  },  
  {
    'title': 'Out of nowhere',
    'synonyms': 'that happend suddenly',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': false,
    'known': true,
    'new': false,
    'id': 468325
  },
  {
    'title': 'Apologize',
    'synonyms': 'No meaning',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': true,
    'known': false,
    'new': false,
    'id': 569372
  },
  {
    'title': 'Screaming',
    'synonyms': 'No meaning',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': true,
    'known': false,
    'new': false,
    'id': 577393
  },
  {
    'title': 'A drawback',
    'synonyms': 'a disadvantage',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': false,
    'known': false,
    'new': true,
    'id': 599823
  },
  {
    'title': 'Tranquil river',
    'synonyms': 'a calmy river',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': true,
    'relearn': false,
    'known': false,
    'new': true,
    'id': 343745
  },
  {
    'title': 'Gimme a break!',
    'synonyms': 'Hmm Hell stop it!',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': false,
    'known': false,
    'new': true,
    'id': 554823
  },
  {
    'title': 'Exceedingly difficult',
    'synonyms': 'No meaning',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': false,
    'known': false,
    'new': true,
    'id': 349838
  },
  {
    'title': 'Gym',
    'synonyms': 'No meaning',
    'folder_name': 'My words',
    'folder': 839221,
    'liked': false,
    'relearn': false,
    'known': false,
    'new': true,
    'id': 883726
  },
  {
    'title': 'depth',
    'synonyms': 'deepness, profundity',
    'folder_name': 'My words',
    'folder': 324584,
    'liked': false,
    'relearn': false,
    'known': true,
    'new': false,
    'id': 883755
  },
  {
    'title': 'feared',
    'synonyms': 'scared, afraid',
    'folder_name': 'My words',
    'folder': 324584,
    'liked': false,
    'relearn': false,
    'known': true,
    'new': false,
    'id': 883766
  },
  {
    'title': 'glimpse',
    'synonyms': 'glance, look, see',
    'folder_name': 'My words',
    'folder': 324584,
    'liked': false,
    'relearn': false,
    'known': true,
    'new': false,
    'id': 883777
  },
];

List<Map> _folders = [
  {
    'name': 'My words',
    'total_words': 10,
    'id': 839221,
    'default': true
  },
  {
    'name': 'Dracula - Bram Stoker',
    'total_words': 3,
    'id': 324584,
    'default': false
  }
];