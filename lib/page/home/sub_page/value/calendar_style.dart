// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thaijourney/constant/constant.dart';

CalendarStyle getCalendarStyle(bool isDarkMode) {
  return CalendarStyle(
    defaultTextStyle: TextStyle(
      color: isDarkMode ? Colors.white : Colors.black,
      fontSize: SizeConfig.height(2),
      fontWeight: FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(
      color: Colors.orange,
      fontSize: SizeConfig.height(2),
      fontWeight: FontWeight.bold,
    ),
    selectedTextStyle: TextStyle(
      color: Colors.white,
      fontSize: SizeConfig.height(2.5),
      fontWeight: FontWeight.bold,
    ),
    selectedDecoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.orange[400],
    ),
    todayDecoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.red.withOpacity(0.6),
    ),
    todayTextStyle: TextStyle(
      color: Colors.white,
      fontSize: SizeConfig.height(2),
      fontWeight: FontWeight.bold,
    ),
    markerDecoration: BoxDecoration(
      color: Colors.red[400],
      shape: BoxShape.circle,
    ),
  );
}

HeaderStyle getHeaderStyle(bool isDarkMode) {
  return HeaderStyle(
    titleCentered: true,
    formatButtonVisible: false,
    titleTextStyle: TextStyle(
      color: isDarkMode ? Colors.white : Colors.black,
      fontSize: SizeConfig.height(2.5),
      fontWeight: FontWeight.bold,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right_rounded,
      color: isDarkMode ? Colors.white : Colors.black,
      size: SizeConfig.height(4),
    ),
    leftChevronIcon: Icon(
      Icons.chevron_left_rounded,
      color: isDarkMode ? Colors.white : Colors.black,
      size: SizeConfig.height(4),
    ),
  );
}

DaysOfWeekStyle getDaysOfWeekStyle(bool isDarkMode) {
  return DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      color: isDarkMode ? Colors.white : Colors.black,
      fontWeight: FontWeight.bold,
    ),
    weekendStyle: TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
  );
}
