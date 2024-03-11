import 'package:flutter/material.dart';
typedef OnDateChange = void Function(DateTime)? ;
class HomeProvider extends ChangeNotifier{
  int currentNavIndex = 0;
  DateTime selectedDate = DateTime.now();

  OnDateChange changeDate(newSelectedDate){
    if(selectedDate == newSelectedDate)return null;
    selectedDate = newSelectedDate;
    notifyListeners();
    return null;
  }
  void changeTab(int newIndex){
    if(currentNavIndex == newIndex)return;
    currentNavIndex = newIndex;
    notifyListeners();
  }
}

