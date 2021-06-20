import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';

class WordEditPage extends StatefulWidget {
  WordEditPage({Key key}) : super(key: key);

  @override
  _WordEditPageState createState() => _WordEditPageState();
}

class _WordEditPageState extends State<WordEditPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        SizedBox(height: 15),
        _header(context),
        SizedBox(height: 25),
        _occurrence(),
        Divider(),
        _word(),
        SizedBox(height: 25),
        Divider(),
        _tags(),
        SizedBox(height: 25),
        Divider(),
        _description(),
      ])),
    ));
  }
  
  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5),
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            SizedBox(width: 5),
            Text('My bucket', style: TextStyle(fontSize: 20))
          ],
        ),
      ],
    );
  }

  Widget _occurrence() {
    double _currentSliderValue = 20;
    return Column(
      children: [        
        Container(
          padding: EdgeInsets.only(left: 15),
          width: double.infinity,
          child: Text('Ocurrence', style: TextStyle(fontSize: 18)),
        ),
        Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      )
      ],
    );
  }

  Widget _word() {
    return Column(
      children: [
        SizedBox(height:40),
        Text('Frog', style: TextStyle(fontSize: 60)),
        SizedBox(height:40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.favorite_border, size: 35),
            Icon(Icons.delete_outlined, size: 35),
          ],
        )
      ],
    );
  }

  Widget _tags() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
         _chip(Icon(Icons.thumb_up_alt_outlined), 'Known'),
         SizedBox(width:20),
         _chip(Icon(Icons.help_center_outlined), 'Confused'),
        SizedBox(width:20),
        _chip(Icon(Icons.loyalty_outlined), 'New'),
        ]
      ),
    );
    }

  Widget _chip(icon, text) {
    return  Chip(
        avatar: icon,
        label: Text(text),
        backgroundColor: Colors.grey.shade300,
        // deleteIcon: Icon( Icons.close_sharp, ),
        // onDeleted: () {setState(() {print("bla");}); }
        );

  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
  decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Add a description (Optional)...'
  ),
),
    );
  }

}