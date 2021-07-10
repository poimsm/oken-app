import 'package:flutter/material.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class ToastSynonym extends StatefulWidget {
  ToastSynonym({
    Key key,
  }) : super(key: key);

  @override
  _ToastSynonymState createState() => _ToastSynonymState();
}

class _ToastSynonymState extends State<ToastSynonym> {
  UIProvider ui;

  @override
  Widget build(BuildContext context) {
    ui = Provider.of<UIProvider>(context);

    double width = MediaQuery.of(context).size.width;
    return ui.showSynomToast ? _body(width) : Container();
  }

  Widget _body(width) {
    return Container(
      width: width,
      child: Center(
        child: Container(
            width: width * 0.95,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(100),
              color: Colors.black.withOpacity(0.85),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/coffee.png',
                        width: 40, color: Colors.white.withOpacity(0.7)),
                    SizedBox(width: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: 110,
                          minHeight: 40,
                          maxWidth: width * 0.55,
                          minWidth: width * 0.4),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_word(), _synom()],
                        ),
                      ),
                    )
                  ],
                ),
                Icon(Icons.add, color: Colors.white, size: 26)
              ],
            )),
      ),
    );
  }

  Widget _word() {
    return Text(
      "${ui.word['word'][0].toUpperCase()}${ui.word['word'].substring(1)}",
      style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _synom() {
    return Flexible(
      child: Text(
        ui.word['synonym'],
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
