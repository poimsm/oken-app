import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';
import 'package:oken/widgets/coin_alert.dart';
import 'package:toast/toast.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  BaseAppBar({
    this.title = 'Oken',
    this.coins = false,
    this.back = false,
    this.shadow = true,
    this.search = false,
  });

  final String title;
  final bool coins;
  final bool back;
  final bool search;
  final bool shadow;

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  Media m;

  @override
  Widget build(BuildContext context) {
    m = Media(context);

    return AppBar(
        elevation: widget.shadow ? 3 : 0,
        title: _title(),
        leading: _menuBtn(),
        titleSpacing: 0,
        backgroundColor: Color(0xff92D050),
        actions: [
          if (widget.search) _searchBtn(),
          if (widget.coins) _coinBtn()
        ]);
  }

  Widget _title() {
    return Text(widget.title, style: TextStyle(fontSize: m.s(22)));
  }

  Widget _menuBtn() {
    return IconButton(
      icon: Icon(widget.back ? Icons.arrow_back : Icons.android, size: m.s(26)),
      onPressed: () {
        if (widget.back) return Navigator.pop(context);
        Scaffold.of(context).openDrawer();
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
  }

  Widget _searchBtn() {
    return IconButton(onPressed: () => {}, icon: Icon(Icons.search));
  }

  Widget _coinBtn() {
    return TextButton(
        onPressed: () => _showCoinPopup(),
        child: Row(
          children: [
            Image.asset('assets/coin01.png', width: m.s(24)),
            SizedBox(width: 5),
            Text(
              '900',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: m.s(17),
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  void _showCoinPopup() {
    Future alert =
        showDialog(context: context, builder: (context) => CoinAlert());

    alert.then((val) {
      val = val == null ? false : val;
      if (!val) return;
      _toast('Added');
    });
  }

  void _toast(txt) {
    Timer(
        Duration(milliseconds: 300),
        () => Toast.show(txt, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM));
  }
}
