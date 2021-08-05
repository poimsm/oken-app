import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CoinEffect extends StatefulWidget {
  @override
  _CoinEffectState createState() => _CoinEffectState();
}

class _CoinEffectState extends State<CoinEffect> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offeset;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _offeset =
        Tween(begin: Offset.zero, end: Offset(0, -2)).animate(_controller);
    _opacity = Tween(begin: 1.0, end: 0.0).animate(_controller);
    // _controller.forward();
  }

  UIProvider uiProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    uiProvider = Provider.of<UIProvider>(context);
    if (uiProvider.showCoinEffect) {
      _controller.forward();
    } else {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    uiProvider = Provider.of<UIProvider>(context);

    return FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _offeset,
          child: uiProvider.showCoinEffect
              ? Row(
                  children: [
                    Text('+1',
                        style: TextStyle(fontSize: 17, color: Colors.black87)),
                    SizedBox(width: 5),
                    Image.asset('assets/coin01.png', width: 35),
                  ],
                )
              : Container(),
        ));
  }
}
