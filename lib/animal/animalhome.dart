// import the necessary packages if not already imported
import 'package:amianimauxx/animal/animalinfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../race/racehome.dart';



class Ahome extends StatefulWidget {
  final String? raceName;
  const Ahome({this.raceName});

  @override
  State<Ahome> createState() => _HomeState();
}

class _HomeState extends State<Ahome> {
  final List<Animal> _animals = [];
  final String _baseUrl = "http://10.0.2.2:8000"; // Update the base URL with the correct port
  late Future<bool> _fetchedAnimals;



  Future<bool> fetchedAnimals() async {
    try {
      String? raceName = widget.raceName; // Provide the desired raceName here
      String raceIdUrl = "$_baseUrl/race/raceIdByName/$raceName";
      print("Fetching raceId from: $raceIdUrl");

      http.Response raceIdResponse = await http.get(Uri.parse(raceIdUrl));
      if (raceIdResponse.statusCode == 200) {
        String raceId = json.decode(raceIdResponse.body)["raceId"];
        String animalsUrl = "$_baseUrl/animal/animalsByRace/$raceId";
        print("Fetching animals from: $animalsUrl");

        http.Response animalsResponse = await http.get(Uri.parse(animalsUrl));
        if (animalsResponse.statusCode == 200) {
          final List<dynamic> animalsFromServer = json.decode(animalsResponse.body);
          setState(() {
            _animals.clear();
            animalsFromServer.forEach((element) {
              _animals.add(Animal(
                element["animalName"],
                Race(
                  element["race"]["raceName"], // Assuming 'race' is an object with 'raceName'
                  element["race"]["description"],
                  element["race"]["imageUrl"],
                ),
                int.parse(element["age"].toString()), // Parsing 'age' as an integer
                element["description"],
                element["imageUrl"],
                element["owner"],
              ));
            });
          });
          return true;
        } else {
          print("Failed to fetch animals. Status code: ${animalsResponse.statusCode}");
          return false;
        }
      } else {
        print("Failed to fetch raceId. Status code: ${raceIdResponse.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return false;
    }
  }


  @override
  void initState() {
    _fetchedAnimals = fetchedAnimals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('animals '),
            backgroundColor: Colors.green,
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
    ),
    body:  FutureBuilder(
      future: _fetchedAnimals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return ListView.builder(
            itemCount: _animals.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimalInfo(_animals[index]);
            },
          );
        }
      },
    )
    );
  }
}

class Animal {
  late final String animalName;
  late final Race race;
  late final int age;
  late final String description;
  late final String imageUrl;
  late final String owner;

  Animal(this.animalName, this.race, this.age, this.description, this.imageUrl,
      this.owner);

  @override
  String toString() {
    return 'Animal{animalName: $animalName, race: $race, age: $age, description: $description, imageUrl: $imageUrl, owner: $owner}';
  }
}

