import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/login/login_screen.dart';

import '../../shared/Providers/auth_provider.dart';
import '../../shared/reusable_componenets/dialog_utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String roteName ="/HomeScreen";

  @override
  Widget build(BuildContext context) {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    return Scaffold(
      appBar:
      AppBar(
        leading: IconButton(
          onPressed: ()async{
            await provider.signOut();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
        ),
      ),
      body: Center(
        child: Text(
          "Hi ${provider.databaseUser!.fullName}",style: TextStyle(color: Colors.white,fontSize: 32)
        ),
      ),
    );
  }
}
