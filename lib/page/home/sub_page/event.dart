import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thaijourney/constant/constant.dart';
import 'package:thaijourney/constant/themeprovider.dart';
import 'package:thaijourney/page/home/sub_page/value/cyclic_event.dart';
import 'value/calendar_style.dart';
import 'value/event_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Map<DateTime, List<Map<String, dynamic>>> _events;
  List<Map<String, dynamic>> _selectedEvents = [];
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.utc(2024, 07, 20): [
        {
          'eventName': 'Lampang Cultural Street Market',
          'imagePath': 'assets/events/วัฒนธรรม.jpg',
          'startTime': '16:00',
          'endTime': '19:30',
        },
      ],
    };

    List<List<Map<String, dynamic>>> cyclicEvents = [
      CyclicEventGenerator.generateCyclicEvents(
        startDate: DateTime.utc(2024, 01, 04),
        numberOfOccurrences: 999,
        eventName: 'Phen Sub Street Market',
        imagePath: 'assets/events/เพ็ญทรัพย์.jpg',
        startTime: '17:30',
        endTime: '20:30',
      ),
      CyclicEventGenerator.generateCyclicEvents(
        startDate: DateTime.utc(2024, 01, 05),
        numberOfOccurrences: 999,
        eventName: 'Lampang Cultural Street Market',
        imagePath: 'assets/events/วัฒนธรรม.jpg',
        startTime: '16:00',
        endTime: '19:30',
      ),
    ];

    for (var cyclicEventGroup in cyclicEvents) {
      for (var event in cyclicEventGroup) {
        DateTime date = event['date'];
        if (_events[date] != null) {
          _events[date]!.add(event);
        } else {
          _events[date] = [event];
        }
      }
    }

    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var isDarkMode = themeProvider.isDarkMode;
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event,
          style: TextStyle(
            fontSize: SizeConfig.height(3),
            fontWeight: FontWeight.w600,
            fontFamily: "ThaiFont",
          ),
        ),
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: SizeConfig.height(10),
      ),
      backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: getCalendarStyle(isDarkMode),
            headerStyle: getHeaderStyle(isDarkMode),
            daysOfWeekStyle: getDaysOfWeekStyle(isDarkMode),
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents = _events[selectedDay] ?? [];
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return EventListWidget(
                  imagePath: event['imagePath']!,
                  eventName: event['eventName']!,
                  date: event['date'] ?? _selectedDay,
                  startTime: event['startTime']!,
                  endTime: event['endTime']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
