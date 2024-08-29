import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Thai month names
const List<String> thaiMonthNames = [
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม'
];

class CustomHeader extends StatelessWidget {
  final DateTime focusedMonth;
  final void Function(DateTime) onPageChanged;
  final bool isThaiLocale;

  const CustomHeader({
    super.key,
    required this.focusedMonth,
    required this.onPageChanged,
    required this.isThaiLocale,
  });

  @override
  Widget build(BuildContext context) {
    final monthName = isThaiLocale
        ? thaiMonthNames[focusedMonth.month - 1]
        : DateFormat.MMMM().format(focusedMonth);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () =>
                onPageChanged(focusedMonth.subtract(Duration(days: 30))),
          ),
          Text(
            '$monthName ${focusedMonth.year}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () =>
                onPageChanged(focusedMonth.add(Duration(days: 30))),
          ),
        ],
      ),
    );
  }
}
