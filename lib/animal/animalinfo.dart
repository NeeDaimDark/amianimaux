import 'package:amianimauxx/animal/animaldetails.dart';

import '../race/racehome.dart';
import 'package:flutter/material.dart';

import '../race/race_details.dart';
import 'animalhome.dart';// assuming you have a race details page

class AnimalInfo extends StatelessWidget {
  final Animal _animal;

  AnimalInfo(this._animal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,

      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => AnimalDetails(_animal))
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.network(_animal.imageUrl, width: 200, height: 110),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_animal.animalName),
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
