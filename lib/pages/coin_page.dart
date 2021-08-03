import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/media.dart';
import 'package:oken/widgets/base_appbar.dart';
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  Media media;
  VocabProvider vocabulary;

  @override
  Widget build(BuildContext context) {
    media = Media(context);
    vocabulary = Provider.of<VocabProvider>(context);

    return Scaffold(
        appBar: BaseAppBar(
            title: 'Coin store', back: true, shadow: false, help: true),
        body: SingleChildScrollView(
            child: Column(
          children: [_head(), _freeCoins(), _buyCoins()],
        )));
  }

  Widget _head() {
    return Container(
      color: Color(COLOR.GREEN),
      height: media.sH(150),
      child: Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/coin01.png', width: media.s(45)),
                SizedBox(width: media.s(10)),
                Text(
                  '10.41',
                  style: TextStyle(
                      fontSize: media.s(35),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ]),
              SizedBox(height: media.sH(10)),
              Text(
                'Total coins',
                style: TextStyle(fontSize: media.s(15), color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _freeCoins() {
    return Column(
      children: [
        SizedBox(height: media.sH(20)),
        ListTile(
            onTap: () {},
            leading: Image.asset('assets/ig09.png', width: 50),
            title: Text('Get free coins with ads',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
            trailing:
                Icon(Icons.chevron_right, color: Colors.black38, size: 35)),
        SizedBox(height: media.sH(35)),
        ListTile(
            onTap: () {},
            leading: Image.asset('assets/ig08.png', width: media.s(40)),
            title: Text('Invite a Friend and get Rewards',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.chevron_right,
                color: Colors.black38, size: media.s(35))),
      ],
    );
  }

  Widget _buyCoins() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: media.sH(40)),
        Container(
          padding: EdgeInsets.only(left: media.s(20)),
          child: Text('Buy coins',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black38)),
        ),
        SizedBox(height: 10),
        ListTile(
            onTap: () {},
            leading: Image.asset('assets/ig06.png', width: media.s(40)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Handful of coins',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                Text('30 coins',
                    style: TextStyle(
                      color: Colors.black54,
                    )),
              ],
            ),
            trailing: _price('1.5')),
        Divider(),
        ListTile(
            onTap: () {},
            leading: Image.asset('assets/ig02.png', width: media.s(40)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stack of coins',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                Text('60 coins',
                    style: TextStyle(
                      color: Colors.black54,
                    )),
              ],
            ),
            trailing: _price('2.0')),
        Divider(),
        ListTile(
            onTap: () {},
            leading: Image.asset('assets/ig04.png', width: media.s(40)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bag of coins',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                Text('150 coins',
                    style: TextStyle(
                      color: Colors.black54,
                    )),
              ],
            ),
            trailing: _price('3.5')),
      ],
    );
  }

  Widget _price(value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.orange),
      child: Text(
        'US \$$value',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
