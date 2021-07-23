class Helper {
  String toCapital(String txt) {
    return '${txt[0].toUpperCase()}${txt.substring(1)}';
  }

  String extractWord(txt) {
    RegExp re = RegExp(r'\w+');
    return re.firstMatch(txt).group(0);
  }
}
