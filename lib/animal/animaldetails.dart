
import 'package:amianimauxx/reservation/agenda.dart';
import 'package:flutter/material.dart';

import 'animalhome.dart';

class AnimalDetails extends StatefulWidget {
  final Animal _animal;

  const AnimalDetails(this._animal);

  @override
  State<AnimalDetails> createState() => _RaceDetailsState();
}

class _RaceDetailsState extends State<AnimalDetails> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._animal.animalName),
          backgroundColor: Colors.green

      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Image.network(widget._animal.imageUrl, width: 460, height: 215),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._animal.animalName),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._animal.description),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 200,
            height: 100,
            child: ElevatedButton(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Calendar", textScaleFactor: 2)
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Agenda())
                  );
                }
            ),
          )
          // Add more details specific to the race as needed
        ],
      ),
    );
  }
}
