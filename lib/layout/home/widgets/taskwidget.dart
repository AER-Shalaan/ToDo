import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:to_do/shared/remote/firebase/firestore_helper.dart';
import 'package:to_do/layout/home/widgets/editwidget.dart';

import '../../../model/task.dart';
import '../../../shared/Providers/auth_provider.dart';
import '../provider/home_provider.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(task.time??0);
    return Padding(
      padding: EdgeInsets.only(right: width*0.05,left:width*0.05),
      child: Slidable(

        startActionPane:ActionPane(
            motion:ScrollMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(
                onPressed: (context){
                  FireStoreHelper.deleteTask(userId: myAuthProvider.firebaseUserAuth!.uid, taskId: task.id??"");
                },
                icon: Icons.delete,
                label: "Delete",
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
              ),
            ]),
        endActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: 0.2,
            children: [
              SlidableAction(onPressed: (context){
                homeProvider.selectedTime = TimeOfDay(hour: taskDate.hour, minute: taskDate.minute);
                Navigator.pushNamed(context, EditWidget.routeName,arguments: task);
              },
                icon: Icons.edit,
                label: "Edit",
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
              ),
            ]),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              children: [
                Container(
                  width: width*0.014,
                  decoration: BoxDecoration(
                    color: task.isDone??false?Colors.green:Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(width: width*0.045),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title??"", style:  task.isDone??false?Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.green):Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Container(
                          width: width*0.45,
                          height: height*0.035,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(

                              child: ReadMoreText(
                                task.description??"",
                                trimLines: 1,
                                textAlign: TextAlign.justify,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "Show more",
                                trimExpandedText: "Show less",
                                lessStyle: TextStyle(fontSize: 14, color: Colors.red[700]),
                                moreStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ),
                        ),
                        //Text(task.description??"" ,style: const TextStyle(color: Colors.black , fontSize: 14),)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined,color: Colors.black54,size: 20),
                        const SizedBox(width: 5),
                        Text(DateFormat.jm().format(taskDate), style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400 , color: Colors.black54))

                      ],
                    )

                  ],
                )),
                task.isDone??false?Text("Done!" , style: TextStyle(color: Colors.green,fontSize: 22 , fontWeight: FontWeight.bold)):ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: (){
                      FireStoreHelper.doneTask(userId: myAuthProvider.firebaseUserAuth!.uid, taskId: task.id??"",isDone: true);
                      }, child:Icon(Icons.check))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
