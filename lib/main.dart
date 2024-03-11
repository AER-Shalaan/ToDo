import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/home_screen.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/layout/register/register_screen.dart';
import 'package:to_do/shared/Providers/auth_provider.dart';
import 'package:to_do/style/theme/dark.dart';
import 'package:to_do/style/theme/light.dart';
import 'firebase_options.dart';
import 'layout/login/login_screen.dart';
import 'layout/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create:(context) => MyAuthProvider(),
    child: const MyApp()));
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
        HomeScreen.roteName:(_)=>ChangeNotifierProvider(
          create: (_)=>HomeProvider(),
            child: HomeScreen())
      },
    );
  }
}
