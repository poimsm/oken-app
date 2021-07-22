import 'package:flutter/material.dart';

class VocabBtn extends StatefulWidget {

  @override
  State<VocabBtn> createState() => _VocabBtnState();
}

class _VocabBtnState extends State<VocabBtn> with SingleTickerProviderStateMixin {
  Size size;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 10.0, end: 15.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut)
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
              Navigator.pushNamed(context, 'vocabulary');
            },
           child: AnimatedBuilder(
            animation: _animation,
             builder: (context, child) => Container(
              padding: EdgeInsets.all(_animation.value),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: Color(0xff92D050),
              ),
              child: Icon(Icons.translate, color: Colors.white, size: size.width*0.08)),
           ),
      );
    });
  }
}