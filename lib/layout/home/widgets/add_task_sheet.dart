import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/shared/reusable_componenets/custom_form_field.dart';
class AddTaskSheer extends StatefulWidget {
  @override
  State<AddTaskSheer> createState() => _AddTaskSheerState();
}

class _AddTaskSheerState extends State<AddTaskSheer> {
  TextEditingController taskTitleController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: Text("Add New Task",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),textAlign: TextAlign.center)),
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close)),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 15,),
                  CustomFormField(
                    label: "enter your task",
                    controller: taskTitleController,
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
                    controller: taskDescriptionController,
                    maxLines: 3,
                    keyboard: TextInputType.multiline,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return'description can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text("${homeProvider.selectedDate.day}/${homeProvider.selectedDate.month}/${homeProvider.selectedDate.year}"),
                  TextButton(onPressed: (){
                    showTimePicker(context: context, initialTime:homeProvider.selectedTime,onEntryModeChanged: homeProvider.changeTime,);
                    setState(() {

                    });
                    }, child: Text("Select Time",style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w400, fontSize: 20),textAlign: TextAlign.center)),
                  Text("${homeProvider.selectedTime.hour}:${homeProvider.selectedTime.minute}")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
