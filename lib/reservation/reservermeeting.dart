import '../reservation/reservationshow.dart';
import 'package:flutter/material.dart';

class ReserverMeet extends StatefulWidget {
  final DateTime selectedDateTime;

  ReserverMeet(this.selectedDateTime);

  @override
  State<ReserverMeet> createState() => _ReserverMeetState();
}

class _ReserverMeetState extends State<ReserverMeet> {
  late String? _username;
  late String? _nomanimal;
  late TimeOfDay _startTime = TimeOfDay.now();
  late TimeOfDay _endTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1); // Default end time is 1 hour from start time
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserver votre meet"),
      ),
      body: Center(
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              SizedBox(
                width: 20,
                height: 50,
              ),
              Text(
                "Selected Date and Time: ${widget.selectedDateTime}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Username"),
                  onSaved: (String? value) {
                    _username = value;
                  },
                  validator: (String? value) {
                    if(value == null || value.isEmpty) {
                      return "Le username ne doit pas etre vide";
                    }
                    else if(value.length < 5) {
                      return "Le username doit avoir au moins 5 caractères";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "animal_name"),
                  onSaved: (String? value) {
                    _nomanimal = value;
                  },
                  validator: (String? value) {
                    if(value == null || value.isEmpty) {
                      return "Le nom animal ne doit pas etre vide";
                    }
                    else if(value.length < 3) {
                      return "Le nomanimal doit avoir au moins 5 caractères";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              ListTile(
                title: Text("Start Time: ${_startTime.format(context)}"),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );
                  if (selectedTime != null && selectedTime != _startTime) {
                    setState(() {
                      _startTime = selectedTime;
                    });
                  }
                },
              ),
              ListTile(
                title: Text("End Time: ${_endTime.format(context)}"),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );
                  if (selectedTime != null && selectedTime != _endTime) {
                    setState(() {
                      _endTime = selectedTime;
                    });
                  }
                },
              ),
              // Rest of your form fields...
              // Username, animal_name, etc.
              ElevatedButton(
                child: Text("Reserver"),
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    _keyForm.currentState!.save();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ReservationDetailsPage(
                          username: _username!,
                          animalName: _nomanimal!,
                          selectedDateTime: widget.selectedDateTime,
                          startTime: _startTime,
                          endTime: _endTime,
                        ),
                      ),
                    );
                  }
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text("Annuler"),
                onPressed: () => Navigator.pushReplacementNamed(context, "/agenda"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
