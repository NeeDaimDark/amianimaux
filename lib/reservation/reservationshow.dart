import 'package:flutter/material.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String username;
  final String animalName;
  final DateTime selectedDateTime;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  ReservationDetailsPage({
    required this.username,
    required this.animalName,
    required this.selectedDateTime,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservation Details"),
        backgroundColor: Colors.green, // Change app bar color to green
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              username,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Animal Name:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              animalName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Selected Date and Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              selectedDateTime.toString(),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Start Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              startTime.format(context),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "End Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              endTime.format(context),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightGreenAccent, // Change background color to light green
    );
  }
}
