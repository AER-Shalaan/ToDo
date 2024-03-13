import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/home_screen.dart';
import 'package:to_do/shared/Providers/auth_provider.dart';
import 'package:to_do/style/app_colors.dart';
import '../login/login_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/Splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  @override

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      checkAutoLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  const BoxDecoration(
          color:AppColors.backgroundLightColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 5),
            const Image(image: AssetImage("assets/images/splash_icon/logo.png")),
            SizedBox(height: 10),
            Center(child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).colorScheme.primary, size: 80) ),
            const Spacer(flex: 3),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Text("supervised by Ali Samir", style: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.60),fontSize: 14)),
                const Image(image: AssetImage("assets/images/splash_icon/route blue.png"))

              ],
            ),
            const SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
  checkAutoLogin() async {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context, listen: false);
    if(provider.isFirebaseUserLoggedIn()){
      await provider.retrieveDatabaseUserDara();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}