import 'package:flutter/material.dart';
import 'package:oken/constants/color.dart' as COLOR;

AppBar vocabAppBar(
  Size size,
  TabController _tabController, {
  String title = 'Vocabulary',
}) {
  return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(fontSize: size.width * 0.06)),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
            icon: Icon(Icons.arrow_back, size: size.width * 0.07),
            onPressed: () => Navigator.pop(context));
      }),
      titleSpacing: 0,
      backgroundColor: Color(COLOR.GREEN),
      actions: [
        IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
      ],
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: size.width * 0.015,
        tabs: [
          Tab(
              child: Text('Latest',
                  style: TextStyle(fontSize: size.width * 0.048))),
          Tab(
              child: Text('Learned',
                  style: TextStyle(fontSize: size.width * 0.048))),
          Tab(
              child: Container(
                  child: Row(children: [
            Icon(Icons.favorite_outline,
                color: Colors.white, size: size.width * 0.06),
            SizedBox(width: 5),
            Text('Liked', style: TextStyle(fontSize: size.width * 0.048)),
          ]))),
          Tab(
              child: Container(
                  child: Row(children: [
            Icon(Icons.folder_outlined,
                color: Colors.white, size: size.width * 0.06),
            SizedBox(width: 5),
            Text('Folders', style: TextStyle(fontSize: size.width * 0.048)),
          ]))),
        ],
      ));
}
