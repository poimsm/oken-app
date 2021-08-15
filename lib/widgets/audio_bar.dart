import 'package:flutter/material.dart';
import 'package:oken/constants/color.dart' as COLOR;
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/widgets/bar_box.dart';
import 'package:oken/widgets/keyboard_visibility_builder.dart';
import 'package:provider/provider.dart';

class AudioBar extends StatefulWidget {
  AudioBar({
    this.small: false,
    this.shiftDimensions: false,
    this.simple: false,
    this.leftOffset: 50,
    this.bottomOffset: 250,
    this.bottomCardOffset: 250,
  });

  final bool small;
  final bool shiftDimensions;
  final bool simple;
  final double leftOffset;
  final double bottomOffset;
  final double bottomCardOffset;

  @override
  _AudioBarState createState() => _AudioBarState();
}

class _AudioBarState extends State<AudioBar> {
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
              left: audioProvider.isSaving ? 0 : widget.leftOffset,
              bottom: isKeyboardVisible
                  ? 10
                  : audioProvider.isSaving
                      ? widget.bottomCardOffset
                      : widget.bottomOffset,
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
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.save_alt, color: Colors.black54, size: 28))));
  }

  Widget _barStack() {
    return InkWell(
        onTap: () => audioProvider.play(),
        child: BarBox(
            playAnimation: audioProvider.isPlaying,
            audioLength: audioProvider.audioLength));
  }

  Widget _saveBtn() {
    return InkWell(
        onTap: () => audioProvider.onSave(),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Icon(Icons.save_alt, color: Colors.black54, size: 28)));
  }
}
