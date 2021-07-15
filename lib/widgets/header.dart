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
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.03, horizontal: size.width * 0.027),
        color: Color(widget.color),
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
                color: Colors.white, size: size.width*0.065),
            SizedBox(
              width: 8,
            ),
            Text(widget.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
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
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.023, vertical: size.width * 0.012),
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              Image.asset('assets/coin01.png', width: size.width * 0.065),
              SizedBox(width: 5),
              Text(
                '900',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
