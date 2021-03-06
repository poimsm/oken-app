import 'package:flutter/material.dart';
import 'package:oken/pages/coin_page.dart';
import 'package:oken/pages/folder_page.dart';
import 'package:oken/pages/home_page.dart';
import 'package:oken/pages/photo_page.dart';
import 'package:oken/pages/book_page.dart';
import 'package:oken/pages/quiz_page.dart';
import 'package:oken/pages/routine_page.dart';
import 'package:oken/pages/tutorial_page.dart';
import 'package:oken/pages/tutorial_photo_page.dart';
import 'package:oken/pages/user_page.dart';
import 'package:oken/pages/viewer_page.dart';
import 'package:oken/pages/vocab_page.dart';
import 'package:oken/pages/write_page.dart';
import 'package:oken/providers/audio_provider.dart';
import 'package:oken/providers/coin_provider.dart';
import 'package:oken/providers/quiz_provider.dart';
import 'package:oken/providers/book_provider.dart';
import 'package:oken/providers/routine_provider.dart';
import 'package:oken/providers/timer_provider.dart';
import 'package:oken/providers/ui_provider.dart';
import 'package:oken/providers/vocab_provider.dart';
import 'package:oken/providers/photo_provider.dart';
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
        ChangeNotifierProvider(create: (context) => QuizProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => PhotoProvider()),
        ChangeNotifierProvider(create: (context) => RoutineProvider()),
        ChangeNotifierProvider(create: (context) => UIProvider()),
        ChangeNotifierProvider(create: (context) => VocabProvider()),
        ChangeNotifierProvider(create: (context) => CoinProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus.unfocus(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            initialRoute: '/',
            routes: {
              '/': (BuildContext context) => HomePage(),
              'user': (BuildContext context) => UserPage(),
              'reading': (BuildContext context) => BookPage(),
              'quiz': (BuildContext context) => QuizPage(
                    argument: ModalRoute.of(context).settings.arguments,
                  ),
              'photos': (BuildContext context) => ImagePage(),
              'routine': (BuildContext context) => RoutinePage(),
              'tutorial': (BuildContext context) => TutorialPage(),
              'vocabulary': (BuildContext context) => VocabPage(),
              'viewer': (BuildContext context) => ViewerPage(),
              'folder': (BuildContext context) => FolderPage(),
              'coin': (BuildContext context) => CoinPage(),
              'write': (BuildContext context) => WritePage(),
              'photos-tutorial': (BuildContext context) => TutorialPhotoPage(),
            }),
      ),
    );
  }
}
