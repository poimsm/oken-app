import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';
import 'package:oken/constants/color.dart' as COLOR;

class UnlockAlert extends StatelessWidget {
  UnlockAlert(this.elem);

  final Map elem;

  @override
  Widget build(BuildContext context) {
    Media media = Media(context);

    return AlertDialog(
      title: Text(elem['title']),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
                child: Column(children: [
              _image(elem, media),
              SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/coin01.png', width: media.s(25)),
                SizedBox(width: 5),
                Text(elem['price'].toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black87))
              ])
            ])),
            SizedBox(height: media.s(10)),
            Text(elem['selling_text']),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('UNLOCK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _image(elem, media) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 50,
                    maxHeight: 150,
                    minWidth: 80,
                    maxWidth: 220,
                  ),
                  child: Image.network(elem['img'], fit: BoxFit.cover)),
              Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.lock,
                        color: Colors.white, size: media.s(20)),
                  ))
            ],
          )),
    );
  }

  Widget _btn() {
    return Center(
      child: IntrinsicWidth(
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 50, top: 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(COLOR.SUPER_LIGHT_GREY)),
            child: Row(
              children: [
                Image.asset('assets/coin01.png', width: 20),
                SizedBox(width: 5),
                Text(
                  '5',
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(width: 15),
                Text(
                  'Unlock content',
                  style: TextStyle(color: Colors.black87),
                )
              ],
            )),
      ),
    );
  }
}
