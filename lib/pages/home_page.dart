import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/content_provider.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:oken/constants/types.dart' as TYPES;
import 'package:oken/widgets/base_drawer.dart';
import 'package:oken/widgets/vocab_btn.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  ContentProvider contentInstance;
  Size size;

  @override
  Widget build(BuildContext context) {
    contentInstance = ContentProvider();
    size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: SafeArea(child: BaseDrawer()),
      appBar: BaseAppBar(coins: true),
      body: Container(
        color: Color(0xff92D050),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                _pinGrid(context),
                Positioned(
                  bottom: size.height * 0.015,
                  left: 0,
                  child: _footerBar(context),
                ),
                Positioned(
                  bottom: 32,
                  left: 155,
                  child: VocabBtn(),
                ),
                // _categories(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categories() {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
        color: Colors.white,
        child: Row(children: [
          _cat('Books', active: true),
          SizedBox(width: 8),
          _cat('Stories', active: false),
          SizedBox(width: 8),
          _cat('Images', active: false),
          SizedBox(width: 8),
          _cat('Quiz', active: false),
        ]));
  }

  Widget _cat(txt, {active}) {
    active = active == null ? false : active;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      decoration: BoxDecoration(
          color: active ? Color(0xff404040) : Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(50)),
      child: Text(txt,
          style: TextStyle(
            fontSize: 17,
            color: active ? Colors.white : Color(0xff595959),
          )),
    );
  }

  Widget _footerBar(context) {
    return Container(
      width: size.width,
      child: Center(
        child: Card(
          color: Colors.black.withOpacity(0.4),
          elevation: 3,
          child: Container(
              width: size.width * 0.75,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 45),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _icon(LineIcons.bars, page: 'menu', title: 'Menu'),
                    SizedBox(width: 30),
                    _icon(LineIcons.user, page: 'user', title: 'Me'),
                  ])),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon(icon, {title, page}) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () {
            if (page == 'menu') {
              return Scaffold.of(context).openDrawer();
            }
            Navigator.pushNamed(context, page);
          },
          child: Column(
            children: [
              Icon(icon, color: Colors.white70, size: size.width * 0.08),
              Text(title, style: TextStyle(color: Colors.white70, fontSize: 13))
            ],
          ));
    });
  }

  Widget _pinGrid(context) {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 6, right: 6),
        child: _grid(context));
  }

  Widget _grid(context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: contentInstance.length(),
      itemBuilder: (BuildContext context, int index) => _cell(index, context),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }

  Widget _cell(i, context) {
    return InkWell(
      onTap: () {
        Map content = contentInstance.get(i);
        if (content['isBlocked']) return;
        Navigator.pushNamed(context, content['nav'], arguments: content);
      },
      child: Container(
          child: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(contentInstance.get(i)['img']),
            ),
            if (contentInstance.get(i)['isBlocked'])
              Positioned(right: 10, top: 10, child: _priceTag()),
          ]),
          SizedBox(height: 3),
          Text(
            contentInstance.get(i)['title'],
            style:
                TextStyle(color: Colors.black87, fontSize: size.width * 0.045),
          ),
          _tag(contentInstance.get(i)['type'])
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      )),
    );
  }

  Widget _tag(type) {
    final iconTypes = {
      TYPES.QUIZ: 'Quiz',
      TYPES.BOOK: 'Book',
      TYPES.READING: 'Book',
      TYPES.PHOTOS: 'Photos',
      TYPES.ROUTINE: 'Routine',
    };

    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.7))),
        child: Text(iconTypes[type],
            style: TextStyle(fontSize: 13, color: Colors.black54)));
  }

  Widget _priceTag() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              Icon(Icons.lock, color: Colors.white, size: size.width * 0.06),
              SizedBox(width: 5),
              Text('200',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }
}
