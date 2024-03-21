// import 'package:clock2/views/screen/clock_page.dart';
// import 'package:clock2/views/screen/game_page.dart';
// import 'package:clock2/views/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:timer/views/screens/clock_page.dart';

//App initialization
void main() {
  //App execution
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: false,
        colorSchemeSeed: Colors.blue,
      ),
      routes: {
        '/': (context) => const ClockPage(),
      },
    );
  }
}
