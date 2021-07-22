import 'package:flutter/material.dart';
import 'package:oken/pages/add_page.dart';
import 'package:oken/pages/chat_page.dart';
import 'package:oken/pages/folder_page.dart';
import 'package:oken/pages/home_page.dart';
import 'package:oken/pages/image_page.dart';
import 'package:oken/pages/reading_page.dart';
import 'package:oken/pages/question_page.dart';
import 'package:oken/pages/themed_quiz_page.dart';
import 'package:oken/pages/tutorial_page.dart';
import 'package:oken/pages/user_page.dart';
import 'package:oken/pages/viewer_page.dart';
import 'package:oken/pages/vocab_page.dart';
import 'package:oken/providers/question_provider.dart';
import 'package:oken/providers/reading_provider.dart';
import 'package:oken/providers/themed_quiz_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/providers/word_list.dart';
import 'package:oken/providers/word_provider.dart';
import 'package:oken/providers/hint_img_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordList()),
        ChangeNotifierProvider(create: (context) => QuestionProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
        ChangeNotifierProvider(create: (context) => WordProvider()),
        ChangeNotifierProvider(create: (context) => ReadingProvider()),
        ChangeNotifierProvider(create: (context) => HintImgProvider()),
        ChangeNotifierProvider(create: (context) => ThemedQuizProvider()),
        ChangeNotifierProvider(create: (context) => UIProvider()),
        ChangeNotifierProvider(create: (context) => VocabProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomePage(),
            'user': (BuildContext context) => UserPage(),
            'reading': (BuildContext context) => ReadingPage(),
            'questions': (BuildContext context) => QuestionPage(),
            'images': (BuildContext context) => ImagePage(),
            'themed_quiz': (BuildContext context) => ThemedQuizPage(),
            'chat': (BuildContext context) => ChatPage(),
            'tutorial': (BuildContext context) => TutorialPage(),
            'vocabulary': (BuildContext context) => VocabPage(),
            'viewer': (BuildContext context) => ViewerPage(),
            'add': (BuildContext context) => AddPage(),
            'folder': (BuildContext context) => FolderPage(),
          }),
    );
  }
}
