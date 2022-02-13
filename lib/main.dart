import 'package:crypto_app/home.dart';
import 'package:flutter/material.dart';
import 'intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
      fontFamily: 'Comfortaa',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroPage(title: 'Crypto App'),
        '/home': (context) => HomePage(),
      },
    );
  }
}

