import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oken/providers/word_list.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class WordListPage extends StatefulWidget {
  WordListPage({Key key}) : super(key: key);

  @override
  _WordListPageState createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> words = Provider.of<WordList>(context).wordlistAll;

    return SafeArea(
      child: 
        Scaffold(
          body: Stack(children: [
          _background(),
             SingleChildScrollView(
              child: Column(children: [
                _header(context),
                Image.asset('assets/pixel07.png', height: 50),
                  _subHeader(context),
                  ListView.builder(
                     shrinkWrap: true,
                    itemCount: words.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _item(words[index]);
                    }
                  ),
              ])),
        ]),
    
        floatingActionButton: FloatingActionButton(
            onPressed: () => _modal(context),
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ), 
      ),);
  }
  Widget _background() {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff7C6D8B)
      );
  }
  // Widget _background() {
  //     return Image.asset('assets/bg02.jpg', height:double.infinity, fit:BoxFit.cover);
  // }

  // class _WordListPageState extends State<WordListPage> {
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Scaffold(
  //     body: SingleChildScrollView(        
  //         child: Column(children: [
  //       SizedBox(height: 15),
  //       _header(context),
  //       SizedBox(height: 15),
  //       _item(context),
  //        SizedBox(height: 15),
  //       _item(context),
  //        SizedBox(height: 15),
  //       _item(context),
  //     ])),
  //   ));
  // }



  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
            SizedBox(width: 5),
            Text('Oken', style: TextStyle(fontSize: 20, color: Colors.white))
          ],
        )
        ,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:   InkWell(
          child: Icon(Icons.more_vert, size: 35),
          onTap: () => _toast(),
          )
        ),
      ],
    );
  }

  
  Widget _subHeader(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      color: Color(0xff563682),
      child: 
    Row(      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            Text('My bucket words that I save', style: TextStyle(fontSize: 20,))
          ],
        )
        ,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
        //   child:   InkWell(
        //   child: Icon(LineIcons.angleRight, size: 25),
        //   onTap: () {
            
        //   }
        // )
        ),
      ],
    )
        );
  }

  Widget _item(text) {
    return Material(
      color: Colors.transparent,
          child: InkWell(
            onTap: () => _toast(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: _itemBody(text),
            )
      ),
    );
  }

  Widget _itemBody(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        children: [
          SizedBox(width: 15),
          Text(text, style: TextStyle(fontSize: 17))
        ],
      )
      ,
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:   InkWell(
          child: Icon(LineIcons.angleRight, size: 20),
          onTap: () { }
        )
      ),
    ],
    );
  }

  void _modal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog (
          contentPadding: EdgeInsets.zero,
          title: Text('Texto complementario para ver que sucede cuando escribo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text('Texto complementario para ver que sucede cuando escribo'),
                    SizedBox(height: 15),
                    IntrinsicWidth(child: _input())
                  ]                
                )
              ),
              if (false) Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(width: 1, color: Colors.green),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4)
                  )
                ),
                child: InkWell(
                  child: Center(
                      child: Text(
                        'Save New Word 😊',
                        style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop()
                )
            )
            ],           
          ),
          actions: [
            // Container(
            //   width: double.infinity,
            //   color: Colors.red,
            //   child: Text('hoola')
            // )
            FlatButton(
              child: Text('Save New Word 😊'),
              // child: Text('SAVE NOW 😊'),
              onPressed: () => Navigator.of(context).pop(), 
              )
          ],
        );
      }
    );    
  }

  Widget _input() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          // contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(),
          hintText: 'Enter a new word here '
        ),
      ),
    );
  }

  Widget _input2() {
    return Container(
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a new word'
        ),
      ),
    );
  }  

  void _toast() {
    Toast.show("Soon available", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
