import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/layout/home/tabs/list_tab.dart';
import 'package:to_do/layout/home/tabs/settings.dart';
import 'package:to_do/layout/home/widgets/add_task_sheet.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/shared/remote/firebase/firestore_helper.dart';
import 'package:to_do/shared/reusable_componenets/dialog_utils.dart';
import 'package:to_do/style/app_colors.dart';
import '../../shared/Providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String routeName ="/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [ListTab(),SettingsTab()];
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isSheetOpened = false;
  @override
  Widget build(BuildContext context) {
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom!=0;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: isKeyboardOpen?null:
        FloatingActionButton(
            heroTag: null,
            shape: StadiumBorder(
                side: BorderSide(color: Colors.white,width: 4)),
            onPressed: () async {
              if(!isSheetOpened){
                homeProvider.selectedTime=TimeOfDay.now();
                showAddTaskBottomSheet();
                isSheetOpened = true;
              }else{
                if((formKey.currentState?.validate()??false) && homeProvider.selectedTime !=null){
                   await FireStoreHelper.AddNewTask(
                       Task(
                      title: taskTitleController.text,
                      date:DateTime(
                          homeProvider.selectedDate.year,
                          homeProvider.selectedDate.month,
                          homeProvider.selectedDate.day,).millisecondsSinceEpoch,
                      time: DateTime(
                          homeProvider.selectedDate.year,
                          homeProvider.selectedDate.month,
                          homeProvider.selectedDate.day,
                          homeProvider.selectedTime!.hour,
                          homeProvider.selectedTime!.minute).millisecondsSinceEpoch,
                      description:taskDescriptionController.text
                       ),
                         provider.firebaseUserAuth!.uid
                   );
                   DialogUtils.showMessage(context: context, message: "Task Add Succesfully",positiveTitleButton: "ok",positiveButtonPress: (){DialogUtils.hideLoading(context);Navigator.pop(context);});
                   homeProvider.selectedTime=TimeOfDay.now();
                   taskDescriptionController.value=TextEditingValue.empty;
                   taskTitleController.value=TextEditingValue.empty;
                   isSheetOpened =false;
                }
              }
              setState(() {});

            },child: Icon(isSheetOpened?Icons.check:Icons.add,color: Colors.white,size: 24,)),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: BottomNavigationBar(
              onTap: (index){
                homeProvider.changeTab(index);
              },
              currentIndex: homeProvider.currentNavIndex,
              items: [
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/btb_icons/Icon awesome-list.svg',
                    colorFilter: ColorFilter.mode(AppColors.unselectedIconColor, BlendMode.srcIn)),
                    activeIcon: SvgPicture.asset('assets/images/btb_icons/Icon awesome-list.svg',
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
                    label: ""),
                BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/btb_icons/Icon feather-settings.svg',
                    colorFilter: ColorFilter.mode(AppColors.unselectedIconColor, BlendMode.srcIn)),
                    activeIcon: SvgPicture.asset('assets/images/btb_icons/Icon feather-settings.svg',
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
                    label: ""),
              ]),
        ),

      body: Scaffold(
        key: scaffoldKey,
          body:tabs[homeProvider.currentNavIndex]
      )
    );
  }

  void showAddTaskBottomSheet(){
    HomeProvider homeProvider = Provider.of<HomeProvider>(context,listen: false);
    scaffoldKey.currentState?.showBottomSheet(backgroundColor:Colors.transparent,
            clipBehavior: Clip.antiAlias,
            (context)=> AddTaskSheet(
              onCancel: (){
                isSheetOpened =false;
                homeProvider.selectedTime=TimeOfDay.now();
                taskDescriptionController.value=TextEditingValue.empty;
                taskTitleController.value=TextEditingValue.empty;
                setState(() {

                });
              }, titleController: taskTitleController, descriptionController: taskDescriptionController, formKey: formKey,
              
            ),
      enableDrag: false
    );
  }
}
