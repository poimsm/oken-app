import 'package:flutter/material.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/widgets/audio_play.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class AudioActionSheet extends StatefulWidget {
  @override
  _AudioActionSheetState createState() => _AudioActionSheetState();
}

class _AudioActionSheetState extends State<AudioActionSheet> {
  Size size;
  VocabProvider vocabulary;
  AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabProvider>(context, listen: false);
    audioProvider = Provider.of<AudioProvider>(context);

    return Container(
      height: size.height * 0.8,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * 0.045),
            topRight: Radius.circular(size.width * 0.045),
          )),
      child: _actionSheetBody(),
    );
  }

  Widget _actionSheetBody() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(), _list()],
        ),
        Positioned(bottom: 0, left: 0, child: _footer())
      ],
    );
  }

  Widget _title() {
    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            top: size.width * 0.09,
            bottom: size.width * 0.1,
            left: size.width * 0.052,
            right: size.width * 0.19),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.music_note, color: Colors.white),
            SizedBox(
              width: 5,
            ),
            Text(
              'My records (${audioProvider.userAudios.length})',
              style:
                  TextStyle(fontSize: size.width * 0.052, color: Colors.white),
            ),
          ],
        ));
  }

  Widget _list() {
    List audios = audioProvider.userAudios;
    return Container(
      height: size.height * 0.58,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(audios.length, (i) => _item(audios[i], i))),
      ),
    );
  }

  Widget _footer() {
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Container(
              height: size.width * 0.14,
              width: size.width * 0.14,
              child: Image.asset('assets/trash.png',
                  fit: BoxFit.contain, color: Colors.white.withOpacity(0.9))),
        ));
  }

  Widget _item(elem, i) {
    bool isTitle = elem['title'].length > 0;
    String title = isTitle ? elem['title'] : elem['date'];

    return ListTile(
        onTap: () => audioProvider.play(isAudioList: true, index: i),
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        leading: Container(
          height: 45,
          width: 45,
          child: Stack(
            children: [
              if (elem['isPlaying']) Center(child: AudioPlay(40)),
              Center(
                  child: Icon(Icons.play_circle,
                      size: 45, color: Color(COLOR.LIGHT_GREY)))
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  TextStyle(fontSize: size.width * 0.047, color: Colors.white),
            ),
            if (isTitle)
              Text(
                elem['date'],
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
          ],
        ),
        trailing: Text(elem['length'],
            style:
                TextStyle(fontSize: size.width * 0.047, color: Colors.white)));
  }
}
