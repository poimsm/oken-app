import 'package:flutter/material.dart';

class UnlockAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove folder and words?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              // color: Colors.red,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        Image.asset('assets/girl.jpg', width: 100),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),                              
                            ),
                            child: Icon(Icons.lock, color: Colors.white, size: 20),
                          )
                        )
                      ],
                    )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Image.asset('assets/coin01.png', width: 25),
                    SizedBox(width: 5),
                    Text('5', style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87
                    ))
                  ])
                ]
              )
            ),
            SizedBox(height: 10),
            Text('Do you want to Continue?'),
          ],
        ),
      ),
      actions: <Widget>[
        // TextButton(
        //   child: const Text('Cancel', style: TextStyle(
        //     fontSize: 17,
        //     fontWeight: FontWeight.normal,
        //     color: Colors.black54
        //     )),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        // TextButton(
        //   child: const Text('Unlock!', style: TextStyle(
        //     fontSize: 17,
        //     fontWeight: FontWeight.normal,
        //     )),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),


        TextButton(
          child: const Text('CANCEL', style: TextStyle(color: Colors.black54),),
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
}