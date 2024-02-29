import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/style/app_colors.dart';
import '../login/login_screen.dart';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
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
}