class Helper {
  String toCapital(String txt) {
    return '${txt[0].toUpperCase()}${txt.substring(1)}';
  }

  String extractWord(txt) {
    RegExp re = RegExp(r'\w+');
    return re.firstMatch(txt).group(0);
  }

  List deepClone(List entryList) {
    List newList = [];

    for (int i = 0; i < entryList.length; i++) {
      Map newMap = {};
      entryList[i].forEach((key, value) {
        newMap[key] = value;
      });
      newList.add(newMap);
    }

    return newList;
  }
}
