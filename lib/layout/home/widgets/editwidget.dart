import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/shared/reusable_componenets/custom_form_field.dart';
import '../../../model/task.dart';
import '../../../shared/Providers/auth_provider.dart';
import '../../../shared/remote/firebase/firestore_helper.dart';
import '../../../shared/reusable_componenets/dialog_utils.dart';
import '../provider/home_provider.dart';

class EditWidget extends StatefulWidget {
  static const String routeName ="/EditWidget";
  const EditWidget({super.key});

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  @override
  Widget build(BuildContext context) {
    Task args = ModalRoute.of(context)?.settings.arguments as Task;
    TextEditingController titleTextEditingController = TextEditingController();
    TextEditingController descriptionTextEditingController = TextEditingController();
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    GlobalKey<FormState> editForm = GlobalKey();
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Form(
            key: editForm ,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AppBar(
                    toolbarHeight: 157,
                    title:Text("To Do List",textAlign: TextAlign.start),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Card(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Edit task", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)))
                            ],
                          ),
                          SizedBox(height: 30),
                          CustomFormField(
                            label: "This is Title",
                            controller: titleTextEditingController,
                            keyboard: TextInputType.text,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return'title can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          CustomFormField(
                            label: "Task details",
                            controller: descriptionTextEditingController,
                            keyboard: TextInputType.multiline,
                            maxLines: 3,
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return'title can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed:()async{
                                      DateTime? selectedDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(const Duration(days: 365)),
                                        initialDate: homeProvider.selectedDate,

                                      );
                                      homeProvider.changeDate(selectedDate??DateTime.now());
                                    }, child:
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Select Date",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18)),
                                      SizedBox(width: 10),
                                      Icon(Icons.calendar_month_outlined,color: Colors.white,size: 16)
                                    ]
                                )
                                ),
                                SizedBox(width: 10),
                                Text(DateFormat('dd/MM/yyyy').format(DateTime(homeProvider.selectedDate.year,homeProvider.selectedDate.month,homeProvider.selectedDate.day,homeProvider.selectedTime!.hour,homeProvider.selectedTime!.minute)),
                                    style: TextStyle(fontSize: 16.0,color: Colors.black45))
                              ]
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed:()async{
                                      TimeOfDay? selectedTime = await showTimePicker(
                                        context: context,
                                        initialTime:TimeOfDay.now(),
                                      );
                                      homeProvider.changeTime(selectedTime);
                                    }, child:
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Select Time",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18)),
                                      SizedBox(width: 10),
                                      Icon(Icons.access_time_outlined,color: Colors.white,size: 16)
                                    ]
                                )
                                ),
                                SizedBox(width: 20),
                                Text(DateFormat.jm().format(DateTime(homeProvider.selectedDate.year,homeProvider.selectedDate.month,homeProvider.selectedDate.day,homeProvider.selectedTime!.hour,homeProvider.selectedTime!.minute)),
                                    style: TextStyle(fontSize: 16.0,color: Colors.black45))
                              ]
                          ),
                          SizedBox(height:80),
                          SizedBox(
                            height: 40,
                            width: 160,
                            child: ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40)
                                    )),
                                onPressed: () async {
                                  if((editForm.currentState?.validate()??false) && homeProvider.selectedTime !=null){
                                  await FireStoreHelper.editTask(
                                      userId: myAuthProvider.firebaseUserAuth!.uid,
                                      taskId: args.id??"" ,
                                      title: titleTextEditingController.text,
                                      description: descriptionTextEditingController.text,
                                      date: homeProvider.selectedDate.millisecondsSinceEpoch,
                                      time: DateTime(
                                          homeProvider.selectedDate.year,
                                          homeProvider.selectedDate.month,
                                          homeProvider.selectedDate.day,
                                          homeProvider.selectedTime!.hour,
                                          homeProvider.selectedTime!.minute).millisecondsSinceEpoch);
                                  DialogUtils.showMessage(context: context, message: "Task Edit Succesfully",positiveTitleButton: "ok",positiveButtonPress: (){DialogUtils.hideLoading(context);Navigator.pop(context);});
                                  }
                                  },
                                child: Text("Save Changes",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                          ),
                          SizedBox(height: 50)
                        ],
                      ),
                    ),
                  ),
                )

            ],),
          ),
        ],
      ),
    );
  }
}
