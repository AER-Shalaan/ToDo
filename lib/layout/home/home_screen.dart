import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home/provider/home_provider.dart';
import 'package:to_do/layout/home/tabs/list_tab.dart';
import 'package:to_do/layout/home/tabs/settings.dart';
import 'package:to_do/layout/home/widgets/add_task_sheet.dart';
import 'package:to_do/style/app_colors.dart';
import '../../shared/Providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const String roteName ="/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [ListTab(),SettingsTab()];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
            shape: StadiumBorder(
                side: BorderSide(color: Colors.white,width: 4)),
            onPressed: (){
              showAddTaskBottomSheet();

            },child: Icon(Icons.add,color: Colors.white,size: 24,)),
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
    scaffoldKey.currentState?.showBottomSheet(backgroundColor:Colors.transparent,
            clipBehavior: Clip.antiAlias,
            (context)=> AddTaskSheer());
  }
}
