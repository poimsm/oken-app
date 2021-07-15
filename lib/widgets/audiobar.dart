import 'package:flutter/material.dart';

class Audiobar extends StatefulWidget {
  Audiobar({
    Key key,
    this.small = false,
    this.shiftDimensions = false
  }) : super(key: key);

  bool small;
  bool shiftDimensions;

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
    Size size = MediaQuery.of(context).size;
    double dimension = widget.shiftDimensions ? size.height : size.width;

    return FadeTransition(
      opacity: opacidad,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimension * 0.02),
            color: Color(0xffF2F2F2).withOpacity(0.9),
            border: Border.all(
                width: widget.small ? 0 : 1, color: Color(0xffD9D9D9))),
        width: widget.small ? dimension * 0.55 : dimension * 0.65,
        height: widget.small ? dimension * 0.09 : dimension * 0.1,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: dimension * 0.015),
            decoration: BoxDecoration(
              color: Color(0xff8E50D0),
              borderRadius: BorderRadius.circular(9),
            ),
            height: widget.small ? dimension * 0.09 : dimension * 0.1,
            child: Image.asset('assets/signal.png',
                height: widget.small ? dimension * 0.08 : dimension * 0.1),
          ),
        ),
      ),
    );
  }
}
