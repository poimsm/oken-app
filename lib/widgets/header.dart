import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  Header(
      {Key key,
      this.color = 0xff92D050,
      this.back = false,
      this.title = 'Oken'})
      : super(key: key);

  int color;
  bool back;
  String title;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        color: Color(widget.color),
        // color: Colors.black.withOpacity(0.3),

        child: Row(
          children: [_leftBox(), _rightBox()],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
  }

  _leftBox() {
    return InkWell(
      onTap: () => widget.back ? Navigator.pop(context) : print('none'),
      child: Container(
        child: Row(
          children: [
            Icon(widget.back ? Icons.arrow_back : Icons.menu,
                color: Colors.white),
            SizedBox(
              width: 8,
            ),
            Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  _rightBox() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              // Icon(Icons.toll, color: Colors.white),
              Image.asset('assets/coin01.png', width: 23),
              SizedBox(width: 5),
              Text(
                '900',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
