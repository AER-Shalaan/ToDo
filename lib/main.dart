import 'package:flutter/material.dart';
import 'package:to_do/layout/home/home_screen.dart';
import 'package:to_do/layout/register/register_screen.dart';
import 'package:to_do/style/theme/dark.dart';
import 'package:to_do/style/theme/light.dart';
import 'layout/login/login_screen.dart';
import 'layout/splash/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.light,
      darkTheme: DarkTheme.dark,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName:(_)=>Splash(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.roteName:(_)=>HomeScreen()
      },
    );
  }
}
