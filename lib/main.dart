import 'package:flutter/material.dart';
import 'package:oken/pages/chat_page.dart';
import 'package:oken/pages/shop_page.dart';
import 'package:oken/pages/splash_screen.dart';
// import 'package:oken/pages/home_page.dart';
import 'package:oken/pages/talk_page.dart';
import 'package:oken/pages/water_ripple_page.dart';
import 'package:oken/pages/word_edit_page.dart';
import 'package:oken/pages/profile_page.dart';
import 'package:oken/pages/login_page.dart';
import 'package:oken/pages/word_list_page.dart';
import 'package:oken/providers/word_list.dart';
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
        ChangeNotifierProvider( create: (context) => WordList() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => TalkPage(),
          // '/': (BuildContext context) => TalkPage(),
          // 'talk': (BuildContext context) => TalkPage(),
          'word-edit': (BuildContext context) => WordEditPage(),
          'profile': (BuildContext context) => ProfilePage(),
          'login': (BuildContext context) => LoginPage(),
          'word-list': (BuildContext context) => WordListPage(),
          'shop': (BuildContext context) => Shop(),
          'chat': (BuildContext context) => ChatPage(),
          // 'chat': (BuildContext context) => Splash(),
          // 'chat': (BuildContext context) => WaterRipplePage(),
        }
      ),
    );
  }
}