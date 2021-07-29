import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/utils/media.dart';

class CoinAlert extends StatefulWidget {
  @override
  State<CoinAlert> createState() => _CoinAlertState();
}

class _CoinAlertState extends State<CoinAlert> {
  Media m;

  @override
  Widget build(BuildContext context) {
    m = Media(context);

    return Center(
      child: IntrinsicHeight(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: m.width * 0.9,
            child: Column(children: [
              Card(
                elevation: 6,
                child: Container(
                    height: 290,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _title(),
                        _buyTile(),
                        _inviteTile(),
                        _adsTile()
                      ],
                    )),
              ),
              SizedBox(height: 40),
              _closeIcon()
            ]),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text('GET COINS',
          textAlign: TextAlign.start, style: TextStyle(fontSize: 17)),
    );
  }

  Widget _buyTile() {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        onTap: () => Navigator.of(context).pop(),
        leading: Image.asset('assets/bag01.png', width: 40),
        title: Text('Buy 1500 coins', style: TextStyle(fontSize: 17)),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color(0xffE7E6E6),
          ),
          child: Text('\$1.5', style: TextStyle(fontSize: 16)),
        ));
  }

  Widget _inviteTile() {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        onTap: () => Navigator.of(context).pop(),
        leading: Image.asset('assets/bag02.png', width: 40),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invite a friend'),
            Text('and get 800 coins'),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color(0xffE7E6E6),
          ),
          child: Text('Free', style: TextStyle(fontSize: 16)),
        ));
  }

  Widget _adsTile() {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: EdgeInsets.only(top: 5),
        height: m.width * 0.22,
        width: m.width * 0.75,
        child: Stack(children: [
          Positioned(
              top: 20,
              left: 0,
              child: Container(
                  padding: EdgeInsets.only(left: 60),
                  width: m.width * 0.75,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff954ECA),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text('Watch AD for 8 coins',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      )))),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/ads01.png', width: 50),
          ),
        ]),
      ),
    );
  }

  Widget _closeIcon() {
    return InkWell(
        customBorder: CircleBorder(),
        onTap: () => Navigator.of(context).pop(),
        child: Icon(LineIcons.timesCircle, color: Colors.white, size: 40));
  }
}
