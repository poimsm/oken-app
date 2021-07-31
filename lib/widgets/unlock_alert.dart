import 'package:flutter/material.dart';
import 'package:oken/utils/media.dart';

class UnlockAlert extends StatelessWidget {

  UnlockAlert(this.elem);
  
  final Map elem;

  @override
  Widget build(BuildContext context) {
    Media m = Media(context);

    return AlertDialog(
            title: Text(elem['title']),

      // title: Text("Planet's Most Jaw-Dropping Landscapes"),
      // title: Wrap(children: [Text('Unlock '), 
      // // Text('Dracula - Bram ', style: TextStyle(
      // //   color: Color(0xff8C3FC5)
      // // ),),
      // // Text('Broker ', style: TextStyle(
      // //   color: Color(0xff8C3FC5)
      // // ),),
      // Text('with coins')],),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
                child: Column(children: [
              _image(elem, m),
              SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset('assets/coin01.png', width: m.s(25)),
                SizedBox(width: 5),
                Text(elem['price'].toString(), style: TextStyle(fontSize: 20, color: Colors.black87))
              ])
            ])),
            SizedBox(height: m.s(10)),
            if (false) RichText(
              text: TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            children: [
              // TextSpan(text: 'Unlock '),
              TextSpan(text: 'Get '),
              TextSpan(text: elem['title'].toUpperCase() + ' '),


              // TextSpan(text: 'Get THE WAR OF THE WORLDS '),
              // TextSpan(text: 'THE WAR OF THE WORLDS ISLAND ', style: TextStyle(fontWeight: FontWeight.bold)),
              // TextSpan(text: 'THE WAR OF THE WORLDS ISLAND ', style: TextStyle(color: Colors.green)),
              // TextSpan(text: 'DRACULA ', style: TextStyle(color: Colors.green)),

              // TextSpan(text: 'THE WAR OF THE WORLDS ISLAND ', style: TextStyle(fontWeight: FontWeight.bold)),
              // TextSpan(text: 'using '),
              // TextSpan(text: '5 ', style: TextStyle(fontSize: 17)),
              // TextSpan(text: 'coins, and take your English to the next level!'),
              
              
              TextSpan(text: 'using your coins, and take English to the next level!'),


              // TextSpan(text: 'of your coins, and take your English to the next level!'),
            ],
          )),

            // Text("Unlock THE WAR OF THE WORLDS ISLAND using 5 of your coins, and take your English to the next level!"),
            // SizedBox(height: 15),
           

//             Text('''This TRAINING IMAGE PACK sale consists of a pack of 60 Digimon Card Game.

// Each pack includes 60 random Cards distributed as follows:
// • 1 Foil Card (Holographic).
// • 4 Rare Cards.
// • 50 Common Cards.'''),


//     Text('''Set of 10 visually stunning ENGLISH TRAINING PHOTOS that come with a complete labeling of items.

// • Practice your speaking ability after describing what is going on in each picture
// • Includes 10 pictures fully labeled, meant for Intermediate levels
// • Boost your improvisation when speaking
// • Learn and explore new English words'''),

    Text(elem['selling_text']),

          // SizedBox(height: 10),
          // Text("You will have access forever", style: TextStyle(
          //   color: Colors.black38,
          //   fontSize: 14
          // ))

          // SizedBox(height: 20),
          // _btn()
          ],
        ),
      ),


      
     actions: <Widget>[
        TextButton(
          child: const Text(
            'CANCEL',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('UNLOCK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],



    );
  }

  _image(elem, m) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),        
          child: Stack(
            children: [
              // child: Image.network(elem['img'], width: m.sH(120), height: 100)),

              ConstrainedBox(
                constraints: new BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                  minWidth: 80,
                  maxWidth: 220,
                ),
                child: Image.network(elem['img'], fit: BoxFit.cover)),
              Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(Icons.lock, color: Colors.white, size: m.s(20)),
              ))
            ],
          )),
    );
  }


 Widget _btn() {
     return Center(
              child: IntrinsicWidth(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 50, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xffE7E6E6)
                  ),
                  child: Row(children: [
                    Image.asset('assets/coin01.png', width: 20),
                    SizedBox(width: 5),
                    Text('5', style: TextStyle(
                      color: Colors.black87
                    ),),
                    SizedBox(width: 15),
                    Text('Unlock content', style: TextStyle(
                      color: Colors.black87
                    ),)
                  ],)
                ),
              ),
            );
 }
}
