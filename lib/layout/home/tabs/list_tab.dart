import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/shared/Providers/auth_provider.dart';
import '../../login/login_screen.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height*0.054),
              child: AppBar(
                toolbarHeight: height*0.19,
                  title:Text("To Do List",textAlign: TextAlign.start),
                  leading: IconButton(
                    onPressed: ()async{
                      await myAuthProvider.signOut();
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
                  )
              ),
            ),
            EasyInfiniteDateTimeLine(
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  height: height/9,

                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Theme.of(context).colorScheme.primary,width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    dayStrStyle:TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.5
                    ),
                    dayNumStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2.5
                    ),
                  ),
                  activeDayStyle: DayStyle(
                      dayStrStyle:const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.5
                      ),
                      dayNumStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 2.5
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(color: Colors.white54 , width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      )
                  ),
                  inactiveDayStyle: const DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    dayStrStyle:TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.5
                    ),
                    dayNumStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2.5
                    ),
                  ),

                ),
                firstDate: DateTime.now(),
                focusDate: homeProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                timeLineProps: const EasyTimeLineProps(
                    separatorPadding: 30
                ),
                showTimelineHeader: false,
                onDateChange: homeProvider.changeDate
            ),
          ],
        ),

      ],
    );
  }
}
