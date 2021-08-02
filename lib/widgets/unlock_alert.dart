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
      contentPadding: EdgeInsets.zero,
      title: Text(elem['title']),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            SizedBox(height: media.s(15)),
            Column(children: [
              _image(elem, media),
              SizedBox(height: media.s(20)),
              _banner(media),
              SizedBox(height: media.s(10)),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: media.s(10)),
                  Text(elem['selling_text']),
                ],
              ),
            ),
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
          child: const Text('PLAY'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _banner(media) {
    return Container(
      color: Color(COLOR.GREEN),
      padding:
          EdgeInsets.symmetric(horizontal: media.s(15), vertical: media.s(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Image.asset('assets/coin01.png', width: media.s(25)),
            SizedBox(width: media.s(5)),
            Text(elem['price'].toString(),
                style: TextStyle(fontSize: media.s(17), color: Colors.white)),
          ],
        ),
        Container(
            height: media.s(30),
            width: 2,
            color: Color(COLOR.SUPER_LIGHT_GREY)),
        Row(
          children: [
            Icon(Icons.alarm, color: Colors.white),
            SizedBox(width: media.s(20)),
            Container(
              width: media.s(100),
              child: Text(
                'Play for up to 20 min',
                style: TextStyle(color: Colors.white, fontSize: media.s(15)),
              ),
            )
          ],
        )
      ]),
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
                    minHeight: media.s(50),
                    maxHeight: media.s(150),
                    minWidth: media.s(90),
                    maxWidth: media.s(200),
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
}
