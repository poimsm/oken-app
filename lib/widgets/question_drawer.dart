import 'package:flutter/material.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart';
import 'package:provider/provider.dart';

class QuestionDrawer extends StatefulWidget {
  QuestionDrawer(this.isExample);
  final bool isExample;

  @override
  State<QuestionDrawer> createState() => _QuestionDrawerState();
}

class _QuestionDrawerState extends State<QuestionDrawer> {
  Size size;
  VocabProvider vocabulary;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    vocabulary = Provider.of<VocabProvider>(context);

    return Drawer(child: widget.isExample ? _exampleDrawer() : _vocabDrawer());
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
    return Text(
      'HISTORY',
      style: TextStyle(fontSize: size.width * 0.053, color: Colors.black54),
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
          children: List.generate(vocabulary.history.length,
              (index) => _vocabItem(vocabulary.history[index], index)),
        ),
      ),
    );
  }

  Widget _vocabItem(elem, i) {
    return ListTile(
        trailing: (elem['known'])
            ? SizedBox(width: 10)
            : OutlinedButton(
                onPressed: () =>
                    vocabulary.markAsKnownFromHistory(elem['id'], i),
                child: Text(
                  'Learned',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
              ),
        title: Text(Helper().toCapital(elem['title']),
            style: TextStyle(
                fontSize: size.width * 0.052, fontWeight: FontWeight.normal)),
        subtitle: Text(
          Helper().toCapital(elem['synonyms']),
          style: TextStyle(
            fontSize: size.width * 0.047,
          ),
        ));
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
    String txt = 'It challenges you to make an answer with the words';
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: 30),
              child: Text(
                txt,
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
