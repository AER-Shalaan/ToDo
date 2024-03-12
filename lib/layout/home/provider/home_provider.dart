import 'package:flutter/material.dart';
typedef OnDateChange = void Function(DateTime)? ;
typedef OnEntryModeChanged = void Function(TimePickerEntryMode)?;
class HomeProvider extends ChangeNotifier{
  int currentNavIndex = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  OnDateChange changeDate(newSelectedDate){
    if(selectedDate == newSelectedDate)return null;
    selectedDate = newSelectedDate;
    notifyListeners();
    return null;
  }
  OnEntryModeChanged changeTime(newSelectedTime){
    if(selectedTime == newSelectedTime)return null;
    selectedTime = newSelectedTime;
    notifyListeners();
    return null;
  }
  void changeTab(int newIndex){
    if(currentNavIndex == newIndex)return;
    currentNavIndex = newIndex;
    notifyListeners();
  }
}

