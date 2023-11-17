import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import '../reservation/reservermeeting.dart';

class Agenda extends StatelessWidget {
   Agenda({super.key});

   DateTime selectedDateTime = DateTime.now(); // Initialize with a default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick a date for your meet"),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 1,
        initialDisplayDate: DateTime.now(),
        initialSelectedDate: DateTime.now(),
        onSelectionChanged: (CalendarSelectionDetails details) {
          // Save the selected date and time.
          selectedDateTime = details.date!;
        },
        dataSource: MeetingDataSource(getAppointments()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedDateTime != null) {
            // Navigate to the new page and pass the selected date and time.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReserverMeet(selectedDateTime),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 10));
  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'meeting',
    color: Colors.blue,
    //recurrenceRule: 'FREQ=DAILY;COUNT=3',
    isAllDay: true,
  ));

  // print('Appointments: $meetings');
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
