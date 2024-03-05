import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(),
                SizedBox(width: 15,),
                Text("Loading...",style: TextStyle(color: Colors.black),)
              ],
            ),
          ),
        ),
      );
    });
  }
  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context ,required String message ,
    String? positiveTitleButton,
    String? negativeTitleButton,
    void Function()? positiveButtonPress,
    void Function()? negativeButtonPress,
  }){
    showDialog(context: context, builder: (context){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10 , right: 10),
                  child: Text(message,textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(positiveTitleButton!=null)
                      TextButton(
                      onPressed: positiveButtonPress,
                      child: Text(positiveTitleButton),
                    ),
                    if(negativeTitleButton!=null)
                      TextButton(
                        onPressed: negativeButtonPress,
                        child: Text(negativeTitleButton),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}