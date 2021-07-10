import 'package:flutter/material.dart';

class Audiobar extends StatefulWidget {
  Audiobar({
    Key key,
    this.small = false,
  }) : super(key: key);

  bool small;

  @override
  _AudiobarState createState() => _AudiobarState();
}

class _AudiobarState extends State<Audiobar>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacidad;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    opacidad = new Tween(begin: 0.0, end: 0.9).animate(controller);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacidad,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF2F2F2).withOpacity(0.9),
            border: Border.all(
                width: widget.small ? 0 : 1, color: Color(0xffD9D9D9))),
        width: widget.small ? 200 : 260,
        height: widget.small ? 30 : 40,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Color(0xff8E50D0),
              borderRadius: BorderRadius.circular(9),
            ),
            height: widget.small ? 30 : 40,
            child: Image.asset('assets/signal.png',
                height: widget.small ? 30 : 40),
          ),
        ),
      ),
    );
  }
}
