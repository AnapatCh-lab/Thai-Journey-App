// ignore_for_file: non_constant_identifier_names

class CyclicEventGenerator {
  static List<Map<String, dynamic>> generateCyclicEvents({
    required DateTime startDate,
    required int numberOfOccurrences,
    required String eventName,
    required String imagePath,
    required String startTime,
    required String endTime,
    Duration recurrence = const Duration(days: 7),
  }) {
    List<Map<String, dynamic>> events = [];

    for (int i = 0; i < numberOfOccurrences; i++) {
      DateTime eventDate = startDate.add(recurrence * i);
      events.add({
        'eventName': eventName,
        'imagePath': imagePath,
        'startTime': startTime,
        'endTime': endTime,
        'date': eventDate,
      });
    }

    return events;
  }
}
