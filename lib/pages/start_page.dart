import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    // final List<String> wordList = Provider.of<WordList>(context).wordlist;

    return SafeArea(
        child: 
        Scaffold(body:
        Stack(children: [
          _background(),
          ])
          )
      );
  }

  Widget _background() {
    // return Image.asset('assets/bg02.png', height:double.infinity, fit:BoxFit.cover);
  }

  
}
