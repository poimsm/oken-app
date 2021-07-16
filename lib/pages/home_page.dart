import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/content_provider.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:oken/constants/types.dart' as TYPES;
import 'package:oken/widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  ContentProvider contentInstance;
  Size size;

  @override
  Widget build(BuildContext context) {
    contentInstance = ContentProvider();
    size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: SafeArea(child: NavDrawer()),
      appBar: baseAppBar(size, coins: true),
      body: Container(
        color: Color(0xff92D050),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                _pinGrid(context),
                  Positioned(
                    bottom: size.height*0.015,
                    left: 0,
                    child: _footerBar(context),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footerBar(context) {
    return Container(
      width: size.width,
      child: Center(
        child: Card(
          elevation: 3,
          child: Container(
              width: size.width * 0.75,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _icon(context, LineIcons.bars, 'menu'),
                    _icon(context, LineIcons.home, '/'),
                    _icon(context, LineIcons.edit, 'vocabulary'),
                    _icon(context, LineIcons.user, 'user'),
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

  Widget _icon(context2, icon, open) {
    return Builder(builder: (context) {
      return InkWell(
          onTap: () {
            if (open == 'menu') {
              return Scaffold.of(context).openDrawer();
            }
            Navigator.pushNamed(context, open);
          },
          child: Icon(icon, color: Colors.black38, size: size.width*0.08));
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
              borderRadius: BorderRadius.circular(10),
              child: Image.network(contentInstance.get(i)['img']),
            ),
            if (contentInstance.get(i)['isBlocked'])
              Positioned(right: 10, top: 10, child: _priceTag()),
            Positioned(
                right: 10,
                bottom: 6,
                child: _type(contentInstance.get(i)['type'])),
          ]),
          SizedBox(height: 3),
          Text(
            contentInstance.get(i)['title'],
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: size.width*0.045),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      )),
    );
  }

  Widget _priceTag() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              Icon(Icons.lock, color: Colors.white, size: size.width*0.06),
              SizedBox(width: 5),
              Text('200',
                  style: TextStyle(
                    fontSize: size.width*0.04,
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  Widget _type(type) {
    final iconTypes = {
      TYPES.QUESTION: Icons.quiz_outlined,
      TYPES.BOOK: Icons.format_align_right,
      TYPES.READING: Icons.format_align_right,
      TYPES.IMGS_HINT: Icons.collections,
      TYPES.QUIZ: Icons.style,
    };

    return Stack(
      children: [
        Image.asset('assets/red_type.png',
            width: size.width*0.13, color: Colors.grey.withOpacity(0.5)),
        Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Icon(iconTypes[type], color: Colors.white, size: size.width*0.075))
      ],
    );
  }
}
