import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/shared/reusable_componenets/custom_form_field.dart';

class AddTaskSheet extends StatefulWidget {
  void Function() onCancel;
  TextEditingController titleController;
  TextEditingController descriptionController;
  GlobalKey<FormState> formKey;
  AddTaskSheet({super.key, required this.onCancel,required this.titleController,required this.descriptionController , required this.formKey});
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      height: height*0.54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(30))
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height*0.01),
              Row(
                children: [
                  SizedBox(width: width*0.05),
                  Expanded(child: Text("Add New Task",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),textAlign: TextAlign.center)),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                    widget.onCancel();
                    }, icon: Icon(Icons.close)),
                ],
              ),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  CustomFormField(
                    label: "enter your task",
                    controller: widget.titleController,
                    keyboard: TextInputType.text,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return'title can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  CustomFormField(
                    label: "enter your task description",
                    controller: widget.descriptionController,
                    maxLines: 3,
                    keyboard: TextInputType.multiline,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return'description can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                      Text("Selected date:",style: TextStyle(fontSize: 18),),
                      Text(DateFormat.yMMMMEEEEd().format(homeProvider.selectedDate),
                      style: TextStyle(fontSize: 16.0,color: Colors.black45),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
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
                    SizedBox(width: width*0.16),
                    Text(DateFormat.jm().format(DateTime(homeProvider.selectedDate.year,homeProvider.selectedDate.month,homeProvider.selectedDate.day,homeProvider.selectedTime!.hour,homeProvider.selectedTime!.minute)),
                        style: TextStyle(fontSize: 16.0,color: Colors.black45))
                      ]
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
