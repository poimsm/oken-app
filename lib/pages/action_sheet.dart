import 'package:flutter/material.dart';
import 'package:oken/providers/word_list.dart';
import 'package:provider/provider.dart';


class ActionSheet extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}


class VideoState extends State<ActionSheet> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => context.read<WordList>().togleActionSheet(),
              child: Container(),
            ),
          ),
          _menuActionSheet(),

          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Column(
          //     children: [
          //       _menuActionSheet(),
          //       SizedBox(height: 8),
          //       _cancelActionSheet(),
          //       SizedBox(height: 8),
          //     ]              
          //   )
          // ),
          
        ],
      ),
    );
  }


  Widget _menuActionSheet() {
  return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Titulo de la cosa', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.75)
              ))
            ),
            SizedBox(height: 20),
            _itemActionSheet(Icon(Icons.shuffle), 'Random Questions', 'random'),
            _itemActionSheet(Icon(Icons.work_outline), 'Interview Questions', 'interview'),
            SizedBox(height: 20),
            // _itemActionSheet(Icon(Icons.settings), 'Settings', 'settings'),
          ],
        )
      ),
    );
  }


   Widget _itemActionSheet(icon, text, action) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () => context.read<WordList>().togleActionSheet(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          height: 45,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              Text(text, style: TextStyle(fontSize: 18),),
              SizedBox(width: 10),
            ],
          )
        ),
      ),
    );
  }

  Widget _cancelActionSheet() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child:InkWell(
          onTap: () => context.read<WordList>().togleActionSheet(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 55,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.close),            
                Text('Cancel', style: TextStyle(fontSize: 18)),
                SizedBox(width: 10),
              ],
            )
          ),
        ),
    );
  }

}