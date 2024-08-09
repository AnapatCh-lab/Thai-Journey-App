// event_list_widget.dart

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';

class EventListWidget extends StatelessWidget {
  final String imagePath;
  final String eventName;
  final DateTime date;
  final String startTime;
  final String endTime;

  const EventListWidget({
    required this.imagePath,
    required this.eventName,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.height(1.5),
        horizontal: SizeConfig.height(1),
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: isDarkMode ? 2 : 5,
            blurRadius: isDarkMode ? 1 : 7,
            offset: isDarkMode ? const Offset(0, 0) : const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(SizeConfig.height(1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: SizeConfig.height(12),
                height: SizeConfig.height(12),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: SizeConfig.height(1.5)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: TextStyle(
                    fontSize: SizeConfig.height(2.5),
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: SizeConfig.height(1)),
                Text(
                  date.toLocal().toString().split(' ')[0],
                  style: TextStyle(
                    fontSize: SizeConfig.height(2),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: SizeConfig.height(1)),
                Text(
                  'From $startTime to $endTime',
                  style: TextStyle(
                    fontSize: SizeConfig.height(2),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
