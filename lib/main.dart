import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/view/screens/empty_screen.dart';
import 'package:todo_app/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: ThemeData(
        textTheme:
            GoogleFonts.mochiyPopPOneTextTheme(Theme.of(context).textTheme),
      ),
      home: AnimatedSplashScreen(
          splash: 'assets/images/splashScreen.png',
          nextScreen: const HomeScreen(),
        centered: true,
        backgroundColor: green2,
        duration: 3000,
      ),
    );
  }
}
