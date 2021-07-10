import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oken/providers/dummy/content.dart';

class ContentProvider with ChangeNotifier {
  
  List<Map> _content = DataContent().get();

 get(i) {
   return _content[i];
 }

 length() {
   return _content.length;
 }

 void open(context) {
   Navigator.pushNamed(context, 'word-list');
 }

}