import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart' as helper;
import 'package:oken/widgets/base_appbar.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class FolderPage extends StatefulWidget {
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  Size size;
  Map args;
  VocabProvider vocabulary;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    vocabulary = Provider.of<VocabProvider>(context);

    return Scaffold(
        appBar: BaseAppBar(title: args['name'], back: true, shadow: false),
        body: _body());
  }

  Widget _body() {
    return _list();
  }

  Widget _list() {
    List words = vocabulary.getWordsByFolder(args['id']);
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: size.width * 0.052),
          child: Column(
            children: List.generate(words.length, (i) => _item(words[i])),
          )),
    );
  }

  Widget _item(word) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.05, horizontal: size.width * 0.052),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(COLOR.SUPER_LIGHT_GREY)))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(width: 1),
          Text(
            helper.toCapital(word['title']),
            style: TextStyle(
                color: Color(COLOR.GREY), fontSize: size.width * 0.05),
          ),
          InkWell(
            onTap: () => vocabulary.likeWord(word['id']),
            child: Icon(word['liked'] ? Icons.favorite : LineIcons.heart,
                color: word['liked']
                    ? Color(COLOR.LIGHT_RED)
                    : Color(COLOR.LIGHT_GREY)),
          )
        ]));
  }
}
