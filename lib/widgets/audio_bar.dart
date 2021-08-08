import 'package:flutter/material.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/widgets/keyboard_visibility_builder.dart';
import 'package:provider/provider.dart';

class AudioBar extends StatefulWidget {
  AudioBar({Key key, this.small = false, this.shiftDimensions = false})
      : super(key: key);

  final bool small;
  final bool shiftDimensions;

  @override
  _AudioBarState createState() => _AudioBarState();
}

class _AudioBarState extends State<AudioBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> opacidad;

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    opacidad = new Tween(begin: 0.0, end: 0.9).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size size;
  double dimension;
  AudioProvider audioProvider;
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    dimension = widget.shiftDimensions ? size.height : size.width;
    audioProvider = Provider.of<AudioProvider>(context);

    Widget result = Container();

    if (audioProvider.isTalking) {
      result = FadeTransition(opacity: opacidad, child: _bar());
    }

    if (audioProvider.hasNewAudioToBeSaved) {
      result = Row(
        children: [_barStack(), SizedBox(width: 15), _saveBtn()],
      );
    }

    if (audioProvider.isSaving) {
      result = _saveCard();
    }

    return KeyboardVisibilityBuilder(
        builder: (context, child, isKeyboardVisible) {
      return Stack(
        children: [
          Container(),
          Positioned(
              left: audioProvider.isSaving ? 0 : 50,
              bottom: isKeyboardVisible ? 10 : 250,
              child: audioProvider.isSaving
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: result),
                    )
                  : result)
        ],
      );
    });
  }

  Widget _saveCard() {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 10,
        child: Container(
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _saveBtnCard(),
                SizedBox(height: 25),
                TextField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: Colors.black87, fontSize: 17),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 17),
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Title'),
                ),
                SizedBox(height: 5),
                Container(height: 1, width: 180, color: Color(COLOR.GREY)),
                SizedBox(height: 20)
              ],
            )),
      ),
    );
  }

  Widget _saveBtnCard() {
    return Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: InkWell(
            onTap: () {
              audioProvider.saveAudio(_titleController.text, 'routine');
              _titleController.clear();
            },
            child: Icon(Icons.save_alt, color: Colors.black54, size: 28)));
  }

  Widget _barStack() {
    return InkWell(
      onTap: () => audioProvider.play(),
      child: Container(
        width: 210,
        child: Stack(
          children: [
            Container(),
            Positioned(left: 10, top: 5, child: _bar()),
            Positioned(left: 160, top: 13, child: _timeText()),
            _playIcon(),
          ],
        ),
      ),
    );
  }

  Widget _timeText() {
    return Text(audioProvider.audioLength,
        style: TextStyle(fontSize: 16, color: Colors.black54));
  }

  Widget _playIcon() {
    return Stack(children: [
      Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Color(COLOR.PURPLE),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(100))),
      Container(
          height: 40,
          width: 40,
          child: Icon(Icons.play_arrow, size: 30, color: Colors.white))
    ]);
  }

  Widget _bar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dimension * 0.03),
          color: Color(COLOR.ALMOST_WHITE).withOpacity(0.9),
          border: Border.all(
              width: widget.small ? 0 : 1, color: Color(COLOR.LIGHT_GREY))),
      width: 200,
      height: 32,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: dimension * 0.015),
          decoration: BoxDecoration(
            color: Color(COLOR.PURPLE),
            borderRadius: BorderRadius.circular(9),
          ),
          height: 32,
          child: Image.asset('assets/signal.png',
              height: widget.small ? dimension * 0.08 : dimension * 0.1),
        ),
      ),
    );
  }

  Widget _saveBtn() {
    return InkWell(
        onTap: () => audioProvider.isSaving = true,
        child: Icon(Icons.save_alt, color: Colors.white, size: 33));
  }
}
