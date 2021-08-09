import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/photo_provider.dart';
import 'package:oken/widgets/audio_play.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class AudioListPhoto extends StatefulWidget {
  const AudioListPhoto({Key key}) : super(key: key);

  @override
  _AudioListPhotoState createState() => _AudioListPhotoState();
}

class _AudioListPhotoState extends State<AudioListPhoto> {
  AudioProvider audioProvider;
  PhotoProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    audioProvider = Provider.of<AudioProvider>(context);
    photoProvider = Provider.of<PhotoProvider>(context, listen: false);

    return Container(
        height: MediaQuery.of(context).size.height,
        width: 310,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: Colors.black.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(), _list()],
        ));
  }

  Widget _title() {
    return Row(
      children: [
        InkWell(
            onTap: () => photoProvider.showAudioList = false,
            child: Icon(LineIcons.times, color: Colors.white, size: 30)),
        SizedBox(width: 20),
        Icon(Icons.music_note, color: Colors.white),
        SizedBox(
          width: 5,
        ),
        Text(
          'My records (${audioProvider.userAudios.length})',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }

  Widget _list() {
    List audios = audioProvider.userAudios;
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(audios.length, (i) => _item(audios[i], i))),
      ),
    );
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
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            if (isTitle)
              Text(
                elem['date'],
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
          ],
        ),
        trailing: Text(elem['length'],
            style: TextStyle(fontSize: 17, color: Colors.white)));
  }
}
