import 'package:flutter/material.dart';

import '../../shared/reusable_componenets/custom_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/Login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/bg.jpg"))),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormField(label: "Email", keyboard: TextInputType.emailAddress),
                SizedBox(height: 15),
                CustomFormField(label:"Password", keyboard: TextInputType.visiblePassword,obscure: true ,
                  suffixIcon: IconButton(
                    onPressed: (){},
                    icon: Icon(
                        Icons.visibility_off),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
