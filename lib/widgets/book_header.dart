import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class BookHeader extends StatefulWidget {
  const BookHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _BookHeaderState createState() => _BookHeaderState();
}

class _BookHeaderState extends State<BookHeader> {
  UIProvider ui;
  Size size;

  @override
  void dispose() {
    ui.resetChangeColor();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);
    size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.05,
          top: size.height * 0.045,
          bottom: 0),
      decoration: BoxDecoration(
        color: ui.changeColor ? Colors.white : Colors.transparent,
        border: Border(
          bottom: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(ui.changeColor ? 0.5 : 0)),
        ),
      ),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width * 0.08,
                    child: Icon(Icons.arrow_back,
                        size: size.width * 0.075,
                        color: ui.changeColor ? Colors.black54 : Colors.white),
                  )),
              SizedBox(width: size.width * 0.015),
              if (ui.changeColor)
                Container(
                  width: size.width*0.7,
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width * 0.053,
                        color: Colors.black.withOpacity(0.65)),
                  ),
                )
            ],
          ),
          Icon(Icons.settings,
              size: size.width * 0.075,
              color: ui.changeColor ? Colors.black54 : Colors.white),
        ],
      ),
    );
  }
}
