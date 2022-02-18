import 'package:flutter/material.dart';

import 'package:github_profile/pages/home_page.dart';
import 'package:github_profile/pages/profile_page.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
