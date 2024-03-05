import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/shared/constants.dart';
import 'package:to_do/shared/firebaseautherrorcodes.dart';
import 'package:to_do/shared/reusable_componenets/dialog_utils.dart';

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
      decoration: const BoxDecoration(
          image:DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/bg.jpg"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Create Account",textAlign: TextAlign.center),
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
                const SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  if(formKey.currentState?.validate()?? false){
                    createNewUser();                 }
                },
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary)
                    ,child: const Text("Register",style: TextStyle(color: Colors.white,fontSize: 18)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createNewUser() async{
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try{
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text
        );
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
            message: " Hi ${fullNameController.text}\nyour id: ${credential.user?.uid}",
          positiveTitleButton: "OK",
            positiveButtonPress:(){
              DialogUtils.hideLoading(context);
            }

    );
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == FirebaseAuthErrorCodes.weakPassword) {
          DialogUtils.showMessage(context: context, message: 'The password provided is too weak',
          positiveTitleButton: "ok",
            positiveButtonPress: (){
              DialogUtils.hideLoading(context);
            }
          );
        } else if (e.code == FirebaseAuthErrorCodes.emailAlreadyInUse) {
          DialogUtils.showMessage(context: context, message: 'The account already exists for that email',
              positiveTitleButton: "ok",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              }
          );

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
