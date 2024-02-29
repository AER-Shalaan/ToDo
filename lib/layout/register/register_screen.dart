import 'package:flutter/material.dart';
import 'package:to_do/shared/constants.dart';

import '../../shared/reusable_componenets/custom_form_field.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/Register";
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true ;
  bool isConfirmObscure = true ;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/bg.jpg"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Create Account",textAlign: TextAlign.center),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormField(
                  label: "Full Name",
                  keyboard: TextInputType.name,
                  controller: fullNameController,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "this field can't be empty";
                    }
                    return null;
                  }
                ),
                CustomFormField(
                  label: "Email",
                  keyboard: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "this field can't be empty";
                    }
                    if(!RegExp(Constants.emailRegExp).hasMatch(value)){
                      return"Email is not valid";
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  label:"Password",
                  keyboard: TextInputType.visiblePassword,
                  obscure: isObscure ,
                  controller: passController,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isObscure = !isObscure;
                        });},
                      icon: Icon(
                        isObscure?Icons.visibility_off:Icons.visibility,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      )
                  ),
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "this field can't be empty";
                    }
                    if(value.length<8){
                      return"Use 8 characters or more for your password";
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  label:"confirm password",
                  keyboard: TextInputType.visiblePassword,
                  obscure: isConfirmObscure ,
                  controller: confirmPassController,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          isConfirmObscure = !isConfirmObscure;
                        });},
                      icon: Icon(
                        isConfirmObscure?Icons.visibility_off:Icons.visibility,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      )
                  ),
                  validator: (value) {
                    if(value != passController.text){
                      return "Those passwords didn't match";
                    }
                    if(value==null || value.isEmpty){
                      return "this field can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  if(formKey.currentState?.validate()?? false){
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.roteName, (route) => false);                  }
                },
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary)
                    ,child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 18)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
