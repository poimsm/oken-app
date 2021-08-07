import 'package:flutter/material.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/coin_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'audio_actionsheet.dart';

class Header extends StatefulWidget {
  Header(
      {Key key,
      this.color = COLOR.GREEN,
      this.back = false,
      this.title = 'Oken'})
      : super(key: key);

  final int color;
  final bool back;
  final String title;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Size size;
  CoinProvider coinProvider;
  AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    coinProvider = CoinProvider();
    audioProvider = Provider.of<AudioProvider>(context);

    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.03, horizontal: size.width * 0.027),
        color: Color(widget.color),
        child: Row(
          children: [_leftBox(), _rightBox()],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }

  _leftBox() {
    return InkWell(
      onTap: () => widget.back ? Navigator.pop(context) : print('none'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(widget.back ? Icons.arrow_back : Icons.menu,
                color: Colors.white, size: size.width * 0.065),
            SizedBox(
              width: 8,
            ),
            Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  _rightBox() {
    return Row(
      children: [
        // _coinButton(),
        // SizedBox(width: 15),
        _audioRecordButton(),
      ],
    );
  }

  _coinButton() {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.023, vertical: size.width * 0.012),
        color: Colors.black.withOpacity(0),
        child: Row(
          children: [
            Image.asset('assets/coin01.png', width: size.width * 0.065),
            SizedBox(width: 5),
            Text(
              coinProvider.totalCoins,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.048,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  _audioRecordButton() {
    return InkWell(
      onTap: () => _audioList(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.023, vertical: size.width * 0.012),
            color: Colors.black.withOpacity(0.2),
            child: Row(
              children: [
                Icon(Icons.music_note, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Records (${audioProvider.userAudios.length})',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.045,
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _audioList() {
    Future modal = showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AudioActionSheet();
        });

    modal.then((val) {
      val = val ?? false;
      if (!val) return;
      _toast('Added');
    });
  }

  void _toast([text = 'Coming soon']) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }
}
