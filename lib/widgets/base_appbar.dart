import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

AppBar baseAppBar({
  String title = 'Oken',
  bool whiteBtn = false,
  bool coins = false,
  bool back = false,
  bool shadow = true,
  bool search = false,
}) {
  return AppBar(
      elevation: shadow ? 3 : 0,
      title: Text(title),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(back ? Icons.arrow_back : Icons.android),
          onPressed: () {
            if (back) {
              return Navigator.pop(context);
            }

            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      }),
      titleSpacing: 0,
      backgroundColor: Color(0xff92D050),
      actions: [
        if (whiteBtn)
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: TextButton(
                onPressed: () => {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(LineIcons.edit, color: Colors.black38),
                      SizedBox(width: 5),
                      Text(
                        'Words',
                        style: TextStyle(color: Colors.black45, fontSize: 16.5),
                      )
                    ],
                  ),
                )),
          ),
        if (search) IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
        if (coins)
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: TextButton(
                onPressed: () => {},
                child: Row(
                  children: [
                    Image.asset('assets/coin01.png', width: 23),
                    SizedBox(width: 5),
                    Text(
                      '900',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          )
      ]);
}
