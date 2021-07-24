import 'package:flutter/material.dart';

class QuestionDrawer extends StatelessWidget {
  QuestionDrawer(this.isExample);
  final bool isExample;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Drawer(child: isExample ? _exampleDrawer() : _vocabDrawer());
  }

  Widget _vocabDrawer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _vocabTitle(),
            SizedBox(
              height: size.height * 0.01,
            ),
            _vocabList(),
            SizedBox(
              height: size.height * 0.03,
            ),
            _vocabFooter()
          ],
        ),
      ),
    );
  }

  Widget _vocabTitle() {
    return Row(
      children: [
        Text(
          'HISTORY',
          style: TextStyle(fontSize: size.width * 0.053, color: Colors.black54),
        )
      ],
    );
  }

  Widget _vocabList() {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: size.height * 0.4,
        maxHeight: size.height * 0.78,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
            _vocabItem(),
          ],
        ),
      ),
    );
  }

  Widget _vocabItem() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dracula',
                  style: TextStyle(
                      fontSize: size.width * 0.052, color: Colors.black87)),
              SizedBox(
                height: 5,
              ),
              Text('Jump, run, drink',
                  style: TextStyle(
                      fontSize: size.width * 0.045, color: Colors.black54)),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              'Learned',
              style: TextStyle(
                  color: Colors.black54, fontSize: size.width * 0.038),
            ),
          )
        ],
      ),
    );
  }

  Widget _vocabFooter() {
    return RichText(
        text: TextSpan(
      style: TextStyle(
        fontSize: size.width * 0.052,
        color: Colors.black87,
      ),
      children: [
        TextSpan(text: 'The words you '),
        TextSpan(text: 'learn ', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: 'will no longer appear in the quiz 👌'),
      ],
    ));
  }

  Widget _exampleDrawer() {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: 30),
              child: Text(
                'It challenges you to make an answer with the words',
                style: TextStyle(
                    fontSize: size.width * 0.06, color: Colors.black87),
              ),
            ),
            SizedBox(height: size.height * 0.035),
            _title('1.... QUESTION'),
            SizedBox(height: 5),
            Text(
              'If you were in your house what would you do?',
              style: TextStyle(
                  fontSize: size.width * 0.052, color: Colors.black87),
            ),
            SizedBox(height: size.height * 0.03),
            Divider(),
            SizedBox(height: size.height * 0.01),
            _title('2.... WORDS'),
            SizedBox(height: size.height * 0.025),
            Center(child: Image.asset('assets/words_example.png', width: 210)),
            SizedBox(height: size.height * 0.03),
            Divider(),
            SizedBox(height: size.height * 0.01),
            _title('3.... RESPONSE'),
            SizedBox(height: size.height * 0.035),
            Center(child: Image.asset('assets/audio_example.png', width: 200))
          ],
        ));
  }

  Widget _title(txt) {
    return Text(txt, style: TextStyle(fontSize: size.width * 0.045));
  }
}
