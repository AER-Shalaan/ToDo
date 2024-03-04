import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/layout/register/register_screen.dart';
import 'package:to_do/shared/constants.dart';
import 'package:to_do/shared/firebaseautherrorcodes.dart';

import '../../shared/reusable_componenets/custom_form_field.dart';
import '../../shared/reusable_componenets/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/Login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image:DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/bg.jpg"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Login",textAlign: TextAlign.center),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 1),
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
                const SizedBox(height: 15),
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
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  if(formKey.currentState?.validate()?? false){
                    // Navigator.pushNamedAndRemoveUntil(context, HomeScreen.roteName, (route) => false);
                    login();
                  }
                },
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary)
                    ,child: const Text("Login",style: TextStyle(color: Colors.white,fontSize: 18))),
                const Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        child: Text("SignUp",style: TextStyle(color: Theme.of(context).colorScheme.primary),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login() async{
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text
        );
        DialogUtils.hideLoading(context);
        print("user id: ${credential.user?.uid}");
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == FirebaseAuthErrorCodes.userNotFound) {
          DialogUtils.showMessage(context: context, message: 'No user found for that email',
          positiveTitleButton: "OK",
          positiveButtonPress: (){
            DialogUtils.hideLoading(context);
          });

        } else if (e.code == FirebaseAuthErrorCodes.wrongPassword) {
          DialogUtils.showMessage(context: context, message: 'Wrong password',
              positiveTitleButton: "OK",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              });
        }
      } catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message:e.toString(),
            positiveTitleButton: "ok",
            positiveButtonPress: (){
              DialogUtils.hideLoading(context);
            }
        );
      }
    }
  }
}
