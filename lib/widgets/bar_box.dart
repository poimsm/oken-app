import 'dart:math';

import 'package:flutter/material.dart';

class BarBox extends StatefulWidget {
  BarBox({this.playAnimation = false, this.audioLength = '0:00'});

  final bool playAnimation;
  final String audioLength;

  @override
  _BarBoxState createState() => _BarBoxState();
}

class _BarBoxState extends State<BarBox> {
  List<int> duration = [800, 600, 700, 500, 400];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffA374F0),
              Color(0xffF16CA6),
            ],
          )),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child:
                  Icon(Icons.play_arrow, color: Color(0xffA374F0), size: 18)),
          SizedBox(width: 10),
          Container(
              width: 100,
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) => widget.playAnimation
                        ? AnimatedBar(
                            duration: duration[index % 5], index: index)
                        : StaticBar(index: index),
                  ))),
          SizedBox(width: 10),
          Text(widget.audioLength,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.5,
              ))
        ],
      ),
    );
  }
}

class AnimatedBar extends StatefulWidget {
  AnimatedBar({this.duration, this.index});

  final int duration;
  final int index;

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar>
    with TickerProviderStateMixin {
  final int totalBars = 10;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(begin: 0.0, end: 25.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  height: 5 + _animation.value,
                  width: 4.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                          .withOpacity(1 - widget.index / totalBars)),
                );
              }),
        ],
      ),
    );
  }
}

class StaticBar extends StatelessWidget {
  const StaticBar({this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 5 + Random().nextInt(20).toDouble(),
            width: 4.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white.withOpacity(1 - index / 10)),
          )
        ],
      ),
    );
  }
}
