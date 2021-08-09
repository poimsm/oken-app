import 'package:flutter/material.dart';
import 'package:oken/utils/dimens.dart';
import 'package:oken/constants/color.dart' as COLOR;

class UnlockAlert extends StatelessWidget {
  UnlockAlert(this.elem);

  final Map elem;

  @override
  Widget build(BuildContext context) {
    Dimens dimens = Dimens(context);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Text(elem['title']),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            SizedBox(height: dimens.s(15)),
            Column(children: [
              _image(elem, dimens),
              SizedBox(height: dimens.s(20)),
              _banner(dimens),
              SizedBox(height: dimens.s(10)),
            ]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: dimens.s(10)),
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

  Widget _banner(dimens) {
    return Container(
      color: Color(COLOR.GREEN),
      padding:
          EdgeInsets.symmetric(horizontal: dimens.s(15), vertical: dimens.s(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Image.asset('assets/coin01.png', width: dimens.s(25)),
            SizedBox(width: dimens.s(5)),
            Text(elem['price'].toString(),
                style: TextStyle(fontSize: dimens.s(17), color: Colors.white)),
          ],
        ),
        Container(
            height: dimens.s(30),
            width: 2,
            color: Color(COLOR.SUPER_LIGHT_GREY)),
        Row(
          children: [
            Icon(Icons.alarm, color: Colors.white),
            SizedBox(width: dimens.s(20)),
            Container(
              width: dimens.s(100),
              child: Text(
                'Play for up to 20 min',
                style: TextStyle(color: Colors.white, fontSize: dimens.s(15)),
              ),
            )
          ],
        )
      ]),
    );
  }

  _image(elem, dimens) {
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
                    minHeight: dimens.s(50),
                    maxHeight: dimens.s(150),
                    minWidth: dimens.s(90),
                    maxWidth: dimens.s(200),
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
                        color: Colors.white, size: dimens.s(20)),
                  ))
            ],
          )),
    );
  }
}
