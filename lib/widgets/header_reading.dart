import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class HeaderReading extends StatefulWidget {
  const HeaderReading({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _HeaderReadingState createState() => _HeaderReadingState();
}

class _HeaderReadingState extends State<HeaderReading> {
  UIProvider ui;

  @override
  void dispose() {
    ui.resetChangeColor();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);

    return Container(
      padding: EdgeInsets.only(left: 10, right: 20, top: 35, bottom: 0),
      decoration: BoxDecoration(
        color: ui.changeColor ? Colors.white : Colors.transparent,
        border: Border(
          bottom: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(ui.changeColor ? 0.5 : 0)),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 48,
                    width: 45,
                    child: Icon(Icons.arrow_back,
                        size: 27,
                        color: ui.changeColor ? Colors.black54 : Colors.white),
                  )),
              SizedBox(width: 5),
              if (ui.changeColor)
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18.5, color: Colors.black.withOpacity(0.65)),
                )
            ],
          ),
          Icon(Icons.settings,
              size: 27, color: ui.changeColor ? Colors.black54 : Colors.white),
        ],
      ),
    );
  }
}
