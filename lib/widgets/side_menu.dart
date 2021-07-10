import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset('assets/girl.jpg', width: 70)),
              SizedBox(width: 20),
              Text(
                '@poimsm32',
                style: TextStyle(fontSize: 17),
              )
            ],
          ))),
          ListTile(
            title: Text('Sing In  /  Sign Up',
                style: TextStyle(
                    fontSize: 17, color: Colors.black.withOpacity(0.7))),
            onTap: () => {},
          ),
          ListTile(
            title: Text('Explore',
                style: TextStyle(
                    fontSize: 17, color: Colors.black.withOpacity(0.7))),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('Activity',
                style: TextStyle(
                    fontSize: 17, color: Colors.black.withOpacity(0.7))),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('Settings',
                style: TextStyle(
                    fontSize: 17, color: Colors.black.withOpacity(0.7))),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SizedBox(height: 200),
          Center(
              child: Text('V1.0.0',
                  style: TextStyle(
                      fontSize: 17, color: Colors.black.withOpacity(0.6)))),
        ],
      ),
    );
  }
}
