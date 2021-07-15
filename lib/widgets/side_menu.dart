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
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('Activity',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('Settings',
                style: TextStyle(
                    fontSize: size.width*0.047, color: Colors.black.withOpacity(0.7))),
            onTap: () => {Navigator.of(context).pop()},
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
