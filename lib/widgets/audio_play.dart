import 'package:flutter/material.dart';
import 'dart:math' as math;

class AudioPlay extends StatefulWidget {
  AudioPlay(this.size);

  final double size;

  @override
  _AudioPlayState createState() => _AudioPlayState();
}

class _AudioPlayState extends State<AudioPlay>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat(reverse: true);
  }

  AnimationController _controller;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, asdr) => Transform.rotate(
                  angle: _controller.status == AnimationStatus.forward
                      ? (math.pi * 2 * _controller.value)
                      : -(math.pi * 2 * _controller.value),
                  child: Container(
                      height: widget.size,
                      width: widget.size,
                      child:
                          CustomPaint(painter: Play(radius: _animation.value))),
                )));
  }
}

class Play extends CustomPainter {
  Play({this.radius});

  double radius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc);

    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
