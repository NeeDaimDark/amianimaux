import '../animal/animalhome.dart';
import '../race/racehome.dart';
import 'package:flutter/material.dart';

class RaceDetails extends StatefulWidget {
  final Race _race;

  const RaceDetails(this._race);

  @override
  State<RaceDetails> createState() => _RaceDetailsState();
}

class _RaceDetailsState extends State<RaceDetails> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._race.raceName),
          backgroundColor: Colors.green
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Image.network(widget._race.imageUrl, width: 460, height: 215),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._race.raceName),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Text(widget._race.description),
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
                    Text("animaux", textScaleFactor: 2)
                  ],
                ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Ahome(
                      raceName: widget._race.raceName, // Pass raceName to Ahome
                    ),
                  ),
                );
              },
            ),
          )
          // Add more details specific to the race as needed
        ],
      ),
    );
  }
}
