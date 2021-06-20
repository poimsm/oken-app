import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oken/pages/chart.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          _background(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              _userPic(),
              SizedBox(height: 10),
              _chart(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    _userData(),
              SizedBox(height: 30),
              _backBtn()
                  ],
                )
              )
            ],
          )
        ]
      )
    );
  }

  Widget _background() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black
    );
  }

  Widget _userPic() {
    return Image.asset('assets/user01.png');
  }

  Widget _chart() {
    final data = [55.0, 90.0, 50.0, 40.0, 35.0, 55.0, 70.0, 100.0];

    return Stack(
      children: [
        Container(
            height: 200,
            width: 360,
            child: Chart(
            data: data,
          ),
        ),
        Container(
          width: 350,
          child: Text('Productivity', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 18))
        )
      ],
    );
  }


  Widget _userData() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.email_outlined),
            SizedBox(width: 10),
            Text('Email'),
            SizedBox(width: 100),
            Text('poimsm@gmail.com', style: TextStyle(color: Colors.grey),),
            Icon(Icons.chevron_right, size: 30)
          ],
        ),
        SizedBox(height: 10),
          Row(
          children: [
            Icon(Icons.account_box_outlined),
            SizedBox(width: 10),
            Text('User name'),
            SizedBox(width: 90),
            Text('AdDelicious8806', style: TextStyle(color: Colors.grey),),
            Icon(Icons.chevron_right, size: 30)
          ],
        ),
        SizedBox(height: 10),
          Row(
          children: [
            Icon(Icons.lock_open_outlined),
            SizedBox(width: 10),
            Text('Password'),
            SizedBox(width: 150),
            Text('Change', style: TextStyle(color: Colors.grey),),
            Icon(Icons.chevron_right, size: 30)
          ],
        ),
      ],
    );
  }

   Widget _backBtn() {
     return Row(
       children: [
         Icon(Icons.arrow_back),
         SizedBox(width: 20),
         Container(
           width: 200,
           child: RaisedButton(
             padding: EdgeInsets.all(15),
            color: Colors.red,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.red)
            ),
             child: Text('Save', style: TextStyle(fontSize: 16)),
             onPressed: () {}
            ),
         )
       ],
     );
  }
}