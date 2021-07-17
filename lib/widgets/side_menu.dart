import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: Container(
                  child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset('assets/girl.jpg', width: size.width*0.2)),
              SizedBox(width: size.width*0.06),
              Text(
                '@poimsm32',
                style: TextStyle(fontSize: size.width*0.047),
              )
            ],
          ))),
          Container(
            padding: EdgeInsets.only(bottom: size.height*0.03),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'tutorial');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: size.height*0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff8D35CF).withOpacity(0.9),
                ),
                width: size.width*0.45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Icon(Icons.campaign, color: Colors.white, size: size.width*0.06),
                  SizedBox(width: 10),
                  Text('Tutorial', style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width*0.055
                  ),)
                ],)
              ),
            )
          ),
          ListTile(
            title: Text('Sing In  /  Sign Up',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => {},
          ),
          ListTile(
            title: Text('Explore',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Activity',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Settings',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: size.height*0.3),
          Center(
              child: Text('V1.0.0',
                  style: TextStyle(
                      fontSize: size.width*0.047, color: Colors.black.withOpacity(0.6)))),
        ],
      ),
    );
  }
}
