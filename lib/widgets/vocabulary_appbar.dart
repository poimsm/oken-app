import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

AppBar vocabularyAppBar(
  Size size, 
  TabController _tabController,
  {
  String title = 'Vocabulary',
  Controller
}) {
  return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(fontSize: size.width * 0.06)),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.arrow_back,
              size: size.width * 0.07),
          onPressed: () =>  Navigator.pop(context)
        );
      }),
      titleSpacing: 0,
      backgroundColor: Color(0xff92D050),
      actions: [
        IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
      ],
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 6,
        // labelPadding: EdgeInsets.only(bottom: 0),
        // indicatorSize: TabBarIndicatorSize.label,
        // indicator: ,
        // indicatorPadding:  EdgeInsets.only(left: 30),
        // indicatorPadding: EdgeInsets.only(left: 15.0, right: 100.0),

        onTap: (index) {
          print(index);
        },
      tabs: [
        Tab(
          child: Container(child: Text('Latest', style: TextStyle(fontSize: 17)))
        ),
         Tab(
          child: Container(child: Text('Relearn', style: TextStyle(fontSize: 17)))
        ),
         Tab(
          child: Container(child: Text('Known', style: TextStyle(fontSize: 17)))
        ),
         Tab(
           child: Container(child: Row(
            children: [
              Icon(Icons.favorite_outline, color: Colors.white),
              SizedBox(width: 5),
              Text('Liked', style: TextStyle(fontSize: 17)),
              ]
            ))
        ),
         Tab(
          child: Container(child: Row(
            children: [
              Icon(Icons.folder_outlined, color: Colors.white),
              SizedBox(width: 5),
              Text('Folders', style: TextStyle(fontSize: 17)),
              ]
            ))
        ),
      ],
      )  
      );
}
