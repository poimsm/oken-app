import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/utils/helper.dart' as helper;
import 'package:provider/provider.dart';
import 'package:oken/constants/color.dart' as COLOR;

class QuizDrawer extends StatefulWidget {
  QuizDrawer(this.type);
  final String type;

  @override
  State<QuizDrawer> createState() => _QuizDrawerState();
}

class _QuizDrawerState extends State<QuizDrawer> {
  Size size;
  VocabProvider vocabProvider;
  Widget child;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    vocabProvider = Provider.of<VocabProvider>(context);

    print(widget.type);

    switch (widget.type) {
      case 'power-word':
        child = _powerWordDrawer();
        break;
      case 'example':
        child = _exampleDrawer();
        break;
      case 'vocabulary':
        child = _vocabDrawer();
        break;
      default:
    }

    return Drawer(child: child);
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
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        'HISTORY',
        style: TextStyle(fontSize: size.width * 0.053, color: Colors.black54),
      ),
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
          children: List.generate(vocabProvider.history.length,
              (index) => _vocabItem(vocabProvider.history[index], index)),
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
                    vocabProvider.markAsKnownFromHistory(elem['id'], i),
                child: Text(
                  'Learned',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.normal),
                ),
              ),
        title: Text(helper.toCapital(elem['title']),
            style: TextStyle(
                fontSize: size.width * 0.052, fontWeight: FontWeight.normal)),
        subtitle: Text(
          helper.toCapital(elem['synonyms']),
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
            _title('1.... QUIZ'),
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

  Widget _powerWordDrawer() {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0),
            Row(
              children: [
                Text(
                  ' POWER WORD: ',
                  style: TextStyle(fontSize: 17),
                ),
                Text('INITIATIVE ',
                    style: TextStyle(
                        color: Color(COLOR.ORANGE),
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                Text(
                  '',
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Employers love to people who take initiative because it also shows self-confidence and that you're a hard worker.",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              "If you know that a colleague is struggling to meet a deadline then you can take the steps needed to offer specific help to your colleague before she needs to ask for help.",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 45),
            Text(
              "MEANING ",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "You do what needs to be done without anyone asking you.",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 45),
            Text(
              "USE ",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "(a) I took the initiative to   _ _ _ _",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                  color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "(b) I had to   _ _ _ _ _   working on my own initiative",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                  color: Colors.black87),
            ),
            SizedBox(height: 35),
            Text(
              "Share a specific example when you did something because you knew it needed to be done 👌",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 17,
                  color: Colors.black87),
            ),
            // SizedBox(height: 25),
            // Center(child: Icon(LineIcons.chevronRight, size: 40, color: Colors.black87))
          ],
        ));
  }
}
