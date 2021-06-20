import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height:5),
            _header(context),           
            _addBucket(context),
             Divider(),
            _logo(),
            _mainBtn(context),
            SizedBox(height:40),
          ]
        )
        ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            Text('Home', style: TextStyle(fontSize: 20))
          ],
        )
        ,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:   InkWell(
          child: Icon(LineIcons.user, size: 35),
          onTap: () {
            Navigator.pushNamed(context, 'profile');
          }
        )
        ),
      ],
    );
  }

  Widget _addBucket(BuildContext context) {

    final _textStyle = new TextStyle(fontSize: 18);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [        
        Image.asset('assets/bucket.png', height:100, fit:BoxFit.cover),
        Column(
          children: [
            Text('Add words or phrases', style: _textStyle),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide()
              ),
              child: Text('ADD2'),
              onPressed: () {
                Navigator.pushNamed(context, 'talk');
              }
            )
          ],
        )
      ]
    );
  }

  Widget _logo() {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/logo.png', height:200, fit:BoxFit.cover),
          Text('Wordbucket', style: TextStyle(fontSize: 25))
        ]
      )
    );
  }


  Widget _mainBtn(BuildContext context) {
    return RaisedButton(
      color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal:60, vertical: 10),
      child: Text('Lets Talk!', style: TextStyle(fontSize:22, color: Colors.white)),
      onPressed: () {
        Navigator.pushNamed(context, 'word-list');
      },
    );
  }
}
