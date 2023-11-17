import '../race/racehome.dart';
import 'package:flutter/material.dart';

import '../race/race_details.dart';
import 'racehome.dart';// assuming you have a race details page

class RaceInfo extends StatelessWidget {
  final Race _race;

  RaceInfo(this._race);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => RaceDetails(_race))
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.network(_race.imageUrl, width: 200, height: 110),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_race.raceName),
                 // Text(_race.description, textScaleFactor: 2),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
