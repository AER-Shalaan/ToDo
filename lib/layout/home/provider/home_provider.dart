import 'package:flutter/material.dart';
typedef OnDateChange = void Function(DateTime)? ;
typedef OnEntryModeChanged = void Function(TimePickerEntryMode)?;
class HomeProvider extends ChangeNotifier{
  int currentNavIndex = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay.now();
  OnDateChange changeDate(DateTime newSelectedDate){
    if(selectedDate.year == newSelectedDate.year && selectedDate.month == newSelectedDate.month && selectedDate.day == newSelectedDate.day)return null;
   selectedDate=newSelectedDate;
    notifyListeners();
    return null;
  }
  void changeTime(TimeOfDay? newSelectedTime){
    newSelectedTime ??=TimeOfDay.now();
    if(selectedTime == newSelectedTime)return;
    selectedTime = newSelectedTime;
    notifyListeners();
  }
  void changeTab(int newIndex){
    if(currentNavIndex == newIndex)return;
    currentNavIndex = newIndex;
    notifyListeners();
  }

}

